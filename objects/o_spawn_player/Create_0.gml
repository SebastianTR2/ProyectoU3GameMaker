/// CREATE EVENT - o_spawn_player

// DEBUG: Verificar ejecución y estado
show_debug_message(">>> o_spawn_player CREATE ejecutándose");
if (variable_global_exists("from_prologue")) {
    show_debug_message(">>> global.from_prologue existe: " + string(global.from_prologue));
} else {
    show_debug_message(">>> ERROR: global.from_prologue NO EXISTE");
}

// Verificar si venimos del prólogo
if (variable_global_exists("from_prologue") && global.from_prologue) {
    show_debug_message("=== SPAWN DESDE PROLOGO ===");
    
    // Crear el jugador en esta posición
    if (!instance_exists(o_player)) {
        var _layer = layer_get_id("Instances");
        if (layer_exists(layer_get_id("Player"))) _layer = layer_get_id("Player");
        
        var _player = instance_create_layer(x, y, _layer, o_player);
        _player.can_move = false;
        
        show_debug_message("Player creado en: " + string(x) + "," + string(y));
    }
    
    // Crear controlador de "despertar"
    var _wake = instance_create_layer(0, 0, "Instances", o_wake_up);
    show_debug_message("o_wake_up ID: " + string(_wake));
    
    // Resetear el flag
    global.from_prologue = false;
}

// Auto-destruir este objeto después de usarlo
// instance_destroy(); // COMENTADO PARA DEBUG
