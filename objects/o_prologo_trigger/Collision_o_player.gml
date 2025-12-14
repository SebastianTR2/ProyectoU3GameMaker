// Determinar qué bloque activar
var block_to_activate = 1; // Default: Bloque 1

if (variable_instance_exists(id, "target_block")) {
    block_to_activate = target_block;
}

// Activar solo si no está activo ya (o forzar reinicio)
if (global.prologo_block != block_to_activate) {
    global.prologo_block = block_to_activate;
    global.prologo_phase = -1; // Reiniciar fase para inicio limpio
    
    // Debug
    show_debug_message("COLLISION: Trigger activa Bloque " + string(block_to_activate));
}

instance_destroy();
