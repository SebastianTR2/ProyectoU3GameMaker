/// @description Set Checkpoint
if (!variable_global_exists("checkpoint_room")) {
    global.checkpoint_room = noone;
    global.checkpoint_x = 0;
    global.checkpoint_y = 0;
}

// Actualizar checkpoint al iniciar la sala donde esté este objeto
// Se guardan las coordenadas de ESTE objeto fuente (o_spawn)
global.checkpoint_room = room;
global.checkpoint_x = x;
global.checkpoint_y = y;

show_debug_message("Checkpoint guardado en: " + room_get_name(room) + " (" + string(x) + "," + string(y) + ")");
