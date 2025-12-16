/// STEP EVENT
if (room != rm_Trampa_Subteranea) exit;

if (tut_step == 0) {
    // Retraso inicial
    timer++;
    if (timer > 30) {
        scr_tutorial_dialogue(0);
        tut_step = 1;
        timer = 0;
    }
}
else if (tut_step == 1) {
    // Esperar a que el jugador gane XP (mate un slime)
    if (instance_exists(o_player)) {
        if (o_player.xp > xp_start) {
            timer++;
            if (timer > 60) { // Esperar un poco después de matar
                scr_tutorial_dialogue(1);
                tut_step = 2; 
                timer = 0;
            }
        }
    }
}
else if (tut_step == 2) {
    // Verificar si todos los slimes han sido derrotados
    if (!instance_exists(o_slime)) {
        // Todos los slimes muertos, spawear la llave en el centro
        if (!key_spawned) {
            var _center_x = room_width / 2;
            var _center_y = room_height / 2;
            instance_create_depth(_center_x, _center_y, -100, o_llave_tutorial);
            key_spawned = true;
            
            // MENSAJE IMPORTANTE cuando aparece la llave
            if (variable_global_exists("list_chat") && global.list_chat != undefined) {
                ds_queue_enqueue(global.list_chat, "¡Todos los enemigos han sido derrotados!");
                ds_queue_enqueue(global.list_chat, "¡Algo brilla en el centro de la sala!");
                ds_queue_enqueue(global.list_chat, "Parece ser una llave antigua...");
                
                // Crear el objeto de chat para mostrar los mensajes
                if (!instance_exists(o_chat)) {
                    instance_create_depth(0, 0, -9999, o_chat);
                }
            }
        }
        tut_step = 3; // Tutorial completado
    }
}
