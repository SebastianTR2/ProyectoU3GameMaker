if (variable_global_exists("ActiveBlessings")) {
    
    // GOD MODE SIZE UPDATE
    var _slot_size = 280; // EVEN BIGGER (was 220)
    var _gap = 40; 
    var _total_width = (_slot_size * 3) + (_gap * 2); 
    
    // Position: Top Right aligned but massive
    var _hud_x = display_get_gui_width() - _total_width - 50; 
    var _hud_y = 50;
    
    // Check Pantheon Bonus for Gold Effect
    var _is_pantheon_active = (variable_global_exists("ActivePantheonBonus") && global.ActivePantheonBonus != "");
    var _slot_color = _is_pantheon_active ? c_orange : c_dkgray; 
    var _border_color = _is_pantheon_active ? c_yellow : c_white;

    draw_set_halign(fa_center); 
    if (font_exists(f_espanol)) draw_set_font(f_espanol);
    draw_set_color(c_white);
    draw_text_transformed(_hud_x + (_total_width/2), _hud_y - 40, "BENDICIONES", 3.0, 3.0, 0); // Title 3.0 scale
    
    var _mouse_gui_x = device_mouse_x_to_gui(0);
    var _mouse_gui_y = device_mouse_y_to_gui(0);
    var _hover_text = "";
    
    for (var i = 0; i < 3; i++) {
        var _gid = global.ActiveBlessings[i];
        
        var _slot_x_draw = _hud_x + (i * (_slot_size + _gap)); 
        var _slot_y_draw = _hud_y + 20;
        
        // Draw Slot Background
        draw_set_color(_slot_color);
        draw_rectangle(_slot_x_draw, _slot_y_draw, _slot_x_draw + _slot_size, _slot_y_draw + _slot_size, false);
        
        // Draw Border (Ultra Thick)
        draw_set_color(_border_color);
        for(var w=0; w<6; w++) {
            draw_rectangle(_slot_x_draw+w, _slot_y_draw+w, _slot_x_draw + _slot_size-w, _slot_y_draw + _slot_size-w, true);
        }
        
        // Content
        if (_gid != -1) {
            var _god = global.Gods[_gid];
            
            // Draw God Name (Larger) inside slot
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_set_color(c_white);
            // 2.5 scale text centered
            draw_text_transformed(_slot_x_draw + _slot_size/2, _slot_y_draw + _slot_size/2, _god.name, 2.5, 2.5, 0);
            draw_set_valign(fa_top);
            
            // Check Hover
            if (_mouse_gui_x > _slot_x_draw && _mouse_gui_x < _slot_x_draw + _slot_size && 
                _mouse_gui_y > _slot_y_draw && _mouse_gui_y < _slot_y_draw + _slot_size) {
                 
                 _hover_text = _god.name + "\n" + _god.title + "\n---\n" + get_blessing_desc(_god);
            }
        } else {
             draw_set_halign(fa_center);
             draw_set_valign(fa_middle);
             draw_set_color(c_gray);
             draw_text_transformed(_slot_x_draw + _slot_size/2, _slot_y_draw + _slot_size/2, "VACÍO", 2.5, 2.5, 0);
             draw_set_valign(fa_top);
        }
    }
    
    // Draw Hover Tooltip LAST (on top of everything)
    if (_hover_text != "") {
        var _tw = string_width(_hover_text) + 20;
        var _th = string_height(_hover_text) + 20;
        var _tx = _mouse_gui_x - _tw - 10; // Draw to left of mouse
        var _ty = _mouse_gui_y + 10;
        
        // Keep inside screen
        if (_tx < 0) _tx = _mouse_gui_x + 10;
        
        draw_set_color(c_black);
        draw_set_alpha(0.9);
        draw_rectangle(_tx, _ty, _tx + _tw, _ty + _th, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_rectangle(_tx, _ty, _tx + _tw, _ty + _th, true);
        
        draw_set_halign(fa_left);
        draw_text(_tx + 10, _ty + 10, _hover_text);
    }
    
    draw_set_color(c_white);
    draw_set_halign(fa_left);
}
