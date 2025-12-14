/// @description Debug Room Start
show_debug_message(">>> o_spawn_player ROOM START ejecutándose");
show_debug_message(">>> RS: instance_exists(o_player): " + string(instance_exists(o_player)));

// Verificar flag global
if (variable_global_exists("from_prologue")) {
    show_debug_message(">>> RS: global.from_prologue: " + string(global.from_prologue));
} else {
    show_debug_message(">>> RS: global.from_prologue NO EXISTE");
}

// Forzar visibilidad por si acaso
visible = true;
