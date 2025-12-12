// Helper to create dialog with specific options
function create_dialog_options(_title, _text, _options_array) {
    if (instance_exists(o_dialog_box)) instance_destroy(o_dialog_box);
    var _d = instance_create_depth(0, 0, -9999, o_dialog_box);
    _d.title = _title;
    _d.text = _text;
    _d.options = _options_array;
    _d.selected_option = 0;
    _d.active = true;
    return _d;
}

// Keep original for back-compat or simple use
function create_dialog(_title, _text, _has_choice) {
    var _opts = [];
    if (_has_choice) _opts = ["SÍ (Acepto)", "NO (Rechazo)"];
    return create_dialog_options(_title, _text, _opts);
}

function interact_with_statue(_god_id) {
    if (_god_id == -1) return; 
    
    var _god = global.Gods[_god_id];
    var _player_has_god = false;
    var _blessings_count = 0;
    
    // Check current status
    for (var i = 0; i < 3; i++) {
        if (global.ActiveBlessings[i] != -1) {
            _blessings_count++;
            if (global.ActiveBlessings[i] == _god_id) _player_has_god = true;
        }
    }

    // Prepare Dialog
    global.DialogGodID = _god_id;
    
    if (_player_has_god) {
         create_dialog(_god.name, _god.dialogs.already, false); 
         global.DialogState = "already";
    } else if (variable_struct_exists(_god, "locked") && _god.locked) {
         // REJECTED GOD LOGIC
         create_dialog(_god.name, _god.dialogs.reject, false); // Show angry dialog
    } else {
        var _full_title = _god.name + ", " + _god.title + "\n(Panteón: " + _god.pantheon + ")";
        var _desc = get_blessing_desc(_god);
        
        if (_blessings_count < 3) {
            // Can accept
            var _msg = _god.dialogs.offer + "\n\n>> CONCEDE: " + _desc + " <<";
            create_dialog(_full_title, _msg, true);
            global.DialogState = "offer_can_accept";
        } else {
            // Full - Swap logic with SELECTION
            var _msg = _god.dialogs.full + "\nObtendrás: " + _desc + "\n\n(SELECCIONA QUÉ BENDICIÓN ELIMINAR)";
            
            // Build options list from current gods
            var _opts = [];
            for(var k=0; k<3; k++) {
                var _current_gid = global.ActiveBlessings[k];
                var _current_god = global.Gods[_current_gid];
                _opts[k] = "Reemplazar a " + _current_god.name;
            }
            array_push(_opts, "Cancelar (Rechazar a " + _god.name + ")");
            
            create_dialog_options(_full_title, _msg, _opts);
            global.DialogState = "offer_must_swap";
        }
    }
}
 
// ... get_blessing_desc ... (unchanged)

function swap_blessing(_new_god_id, _slot_to_replace) {
    if (_slot_to_replace < 0 || _slot_to_replace > 2) return;

    var _old_god_id = global.ActiveBlessings[_slot_to_replace];
    var _old_god = global.Gods[_old_god_id];
    var _new_god = global.Gods[_new_god_id];
    
    // Check Permanent
    if (variable_struct_exists(_old_god, "permanent") && _old_god.permanent) {
        create_dialog(_old_god.name, _old_god.dialogs.full, false); // "Cant remove me"
        return;
    }
    
    // LOCK THE OLD GOD (Angry mechanics)
    global.Gods[_old_god_id].locked = true; 
    
    // Remove old stats logic
    apply_stats(_old_god_id, false); // Remove stats
    
    // Add new
    global.ActiveBlessings[_slot_to_replace] = _new_god_id;
    apply_stats(_new_god_id, true);
    
    create_dialog(_new_god.name, _new_god.dialogs.accept, false);
    check_pantheon_bonus();
}
function get_blessing_desc(_god) {
    var _desc = "";
    var _stats = _god.stats;
    var _keys = variable_struct_get_names(_stats);
    for (var i = 0; i < array_length(_keys); i++) {
        var _k = _keys[i];
        var _v = _stats[$ _k];
        
        switch(_k) {
            case "strength": _desc += "+" + string(_v) + " Fuerza "; break;
            case "intelligence": _desc += "+" + string(_v) + " Int. "; break;
            case "vitality": _desc += "+" + string(_v) + " Vit. "; break;
            case "speed": _desc += "+" + string(_v) + " Vel. "; break;
            case "defense": _desc += "+" + string(_v * 100) + "% Defensa "; break; // Show as percentage
            default: _desc += "+" + string(_v) + " " + _k + " "; break;
        }
    }
    return _desc;
}

function accept_blessing(_god_id) {
    var _god = global.Gods[_god_id];
    var _slot = -1;
    
    // Find empty slot
    for(var i=0; i<3; i++) {
        if (global.ActiveBlessings[i] == -1) {
            _slot = i;
            break;
        }
    }
    
    if (_slot != -1) {
        global.ActiveBlessings[_slot] = _god_id;
        apply_stats(_god_id, true); // Add stats
        create_dialog(_god.name, _god.dialogs.accept, false);
        check_pantheon_bonus();
    }
}


function apply_stats(_god_id, _add) {
    var _god = global.Gods[_god_id];
    var _mult = _add ? 1 : -1;
    
    // Direct access to player specific variables
    if instance_exists(o_player) {
        var _s = _god.stats;
        if (variable_struct_exists(_s, "strength")) o_player.attr_str += _s.strength * _mult;
        if (variable_struct_exists(_s, "intelligence")) o_player.attr_int += _s.intelligence * _mult;
        if (variable_struct_exists(_s, "vitality")) o_player.attr_vit += _s.vitality * _mult;
        if (variable_struct_exists(_s, "speed")) o_player.attr_spd += _s.speed * _mult;
        
        // Recalculate derived stats to match o_player logic
        with(o_player) {
             hp_max = 100 + (attr_vit * 5); // Corrected to *5 as per previous inspection
             mana_max = 50 + (attr_int * 2);
             damage = 10 + attr_str;
             
             move_speed = 3 + (attr_spd * 0.1);
             run_speed = 5 + (attr_spd * 0.15);
             
             if (hp > hp_max) hp = hp_max;
        }
    }
}

function check_pantheon_bonus() {
    var _p_map = ds_map_create();
    
    for(var i=0; i<3; i++) {
        var _gid = global.ActiveBlessings[i];
        if (_gid != -1) {
            var _p = global.Gods[_gid].pantheon;
            if (!ds_map_exists(_p_map, _p)) ds_map_add(_p_map, _p, 0);
            ds_map_replace(_p_map, _p, ds_map_find_value(_p_map, _p) + 1);
        }
    }
    
    global.ActivePantheonBonus = "";
    var _k = ds_map_find_first(_p_map);
    while(!is_undefined(_k)) {
        if (ds_map_find_value(_p_map, _k) >= 3) {
            global.ActivePantheonBonus = _k;
            // Potential bonus notification here if desired
        }
        _k = ds_map_find_next(_p_map, _k);
    }
    ds_map_destroy(_p_map);
}
