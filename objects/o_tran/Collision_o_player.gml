/// @description Handle Transition

// ------------------------------------------------------------------
// FIX: Soporte para "Creation Code" (Código de Creación)
// ------------------------------------------------------------------
// Si el usuario define "target" en el Código de Creación de la instancia,
// ese código corre DESPUÉS del evento Create, por lo que nuestras variables
// iniciales podrían estar desactualizadas. Aquí, justo antes de usarlo,
// verificamos si existe "target" y actualizamos target_room si es necesario.

if (variable_instance_exists(id, "target")) {
    if (target_room == noone || target != target_room) {
        target_room = target;
    }
}

if (variable_instance_exists(id, "exit_ori")) {
    if (ori == -1 || exit_ori != ori) {
        ori = exit_ori;
    }
}

// ------------------------------------------------------------------
// LÓGICA DE TRANSICIÓN
// ------------------------------------------------------------------

// 1. Guardar la room actual como procedencia
global.previous_room = room;

// 2. Determinar el ID de entrada
// Si tenemos un entry_id definido, lo guardamos para saber dónde aparecer
if (variable_instance_exists(id, "entry_id") && entry_id != noone && entry_id != "") {
    global.previous_entry = entry_id;
} else {
    // Si es una transición simple, reseteamos el entry anterior
    global.previous_entry = noone;
}

// 3. Cambiar de sala
if (target_room != noone && room_exists(target_room)) {
    
    // === LÓGICA DE PUERTA CERRADA (TUTORIAL) ===
    if (room == rm_Trampa_Subteranea && target_room == rm_Camara_Artefacto) {
        if (!variable_global_exists("has_tutorial_key") || global.has_tutorial_key == false) {
             if (!instance_exists(o_dialog_box)) {
                 if (variable_global_exists("list_chat") && global.list_chat != undefined) {
                     ds_queue_enqueue(global.list_chat, "La puerta está sellada con un antiguo mecanismo de cierre.");
                     ds_queue_enqueue(global.list_chat, "Necesitas encontrar la llave para abrirla.");
                     ds_queue_enqueue(global.list_chat, "Quizás derrotar a todos los enemigos revele algo...");
                 }
            }
            // Empujar al jugador un poco para que no spamee el mensaje
            with(other) {
                y -= 10; 
            }
            exit; // NO HACER LA TRANSICIÓN
        }
    }
    
    // IMPORTANTE: Mover al jugador fuera de la pantalla o desactivarlo
    // para evitar colisiones múltiples en el mismo frame si el cambio tarda.
    // (Opcional, pero recomendado)
    
    room_goto(target_room);
} else {
    // Debug info para el usuario si algo falla
    var _name = "o_tran (inst: " + string(id) + ")";
    show_debug_message("ERROR [" + _name + "]: target_room no válida o no asignada.");
    show_debug_message("       -> target_room: " + string(target_room));
    if (variable_instance_exists(id, "target")) {
        show_debug_message("       -> variable 'target': " + string(target));
    }
}
