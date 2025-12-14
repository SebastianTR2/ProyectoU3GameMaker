/// @description Room Start Logic
// Gestionar llegada a rm_pradera desde el prólogo
if (room == rm_pradera) {
    show_debug_message(">>> o_prologo_manager: LLegamos a rm_pradera!");

    // Verificar si venimos del prólogo
    if (variable_global_exists("from_prologue") && global.from_prologue) {
        show_debug_message(">>> o_prologo_manager: Spawning player and cleanup.");

        // 1. Crear Player si no existe
        if (!instance_exists(o_player)) {
             // Coordenadas seguras por defecto.
             var spawn_x = 240; 
             var spawn_y = 240;
             instance_create_layer(spawn_x, spawn_y, "Instances", o_player);
             show_debug_message(">>> o_prologo_manager: Player CREADO en " + string(spawn_x) + "," + string(spawn_y));
        }

        // 2. Asegurar o_wake_up (efecto fade in)
        // Si el usuario lo hizo persistente, ya estará. Si no, lo creamos.
        if (!instance_exists(o_wake_up)) {
            instance_create_layer(0, 0, "Instances", o_wake_up);
            show_debug_message(">>> o_prologo_manager: o_wake_up CREADO.");
        }

        // 3. Resetear flag
        global.from_prologue = false;

        // 4. Auto-destruir el manager (ya cumplió su misión)
        instance_destroy();
    }
}
