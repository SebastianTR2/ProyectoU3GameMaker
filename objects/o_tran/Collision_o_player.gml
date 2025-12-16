/// @description Handle Transition

// ------------------------------------------------------------------
// LÓGICA DE TRANSICIÓN
// ------------------------------------------------------------------

// FIX: Soporte para "Creation Code"
// Forzar actualización de target_room antes de chequear nada
if (variable_instance_exists(id, "target")) {
    if (target_room == noone || target != target_room) {
        target_room = target;
    }
}

// LÓGICA DE PUERTA CERRADA (TUTORIAL)
// Solo la puerta que lleva a la CÁMARA DEL ARTEFACTO está bloqueada y requiere E
var _is_locked_door = (room == rm_Trampa_Subteranea && target_room == rm_Camara_Artefacto);

if (_is_locked_door) {
    // Esta puerta requiere presionar E y tener llave (manejado en Step)
    // Bloquear transición automática por colisión
    exit;
}

// ------------------------------------------------------------------
// TRANSICIÓN AUTOMÁTICA (Para todas las demás puertas)
// ------------------------------------------------------------------

if (variable_instance_exists(id, "exit_ori")) {
    if (ori == -1 || exit_ori != ori) {
        ori = exit_ori;
    }
}

// 1. Guardar la room actual como procedencia
global.previous_room = room;

// 2. Determinar el ID de entrada
if (variable_instance_exists(id, "entry_id") && entry_id != noone && entry_id != "") {
    global.previous_entry = entry_id;
} else {
    global.previous_entry = noone;
}

// 3. Cambiar de sala
if (target_room != noone && room_exists(target_room)) {
    room_goto(target_room);
} else {
    // Debug info
    show_debug_message("o_tran Collision: target_room no válido: " + string(target_room));
}

