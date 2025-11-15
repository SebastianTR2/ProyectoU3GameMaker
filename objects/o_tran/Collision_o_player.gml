if (!instance_exists(o_player)) exit; // seguridad

global.previous_room = room;          // guarda de dónde vienes
global.player_respawn = false;        // resetea respawn
room_goto(target_room);               // cambia de room
