/// @description Step Event - Handle E Key Interaction

// Solo procesar si el jugador está colisionando con esta puerta
if (!place_meeting(x, y, o_player)) {
    player_near = false;
    exit;
}

player_near = true;

// Verificar si el jugador presiona E
if (keyboard_check_pressed(ord("E"))) {
    // Asegurar target_room actualizado
    if (variable_instance_exists(id, "target")) {
        if (target_room == noone || target != target_room) {
            target_room = target;
        }
    }
    
    // LÓGICA DE PUERTA CERRADA (TUTORIAL -> SANTUARIO)
    // Identificamos la puerta por su destino
    var _is_locked_door = (room == rm_Trampa_Subteranea && target_room == rm_Camara_Artefacto);
    
    if (_is_locked_door) {
        
        var _has_key = false;
        if (variable_global_exists("has_tutorial_key")) {
            _has_key = global.has_tutorial_key;
        }
        
        if (!_has_key) {
            // No tiene la llave: Mostrar mensaje y NO transicionar
            
            if (variable_global_exists("list_chat") && global.list_chat != undefined) {
                // Limpiar cola por si acaso (opcional, pero seguro)
                ds_queue_clear(global.list_chat);
                
                ds_queue_enqueue(global.list_chat, "La puerta está sellada con un antiguo mecanismo de cierre.");
                ds_queue_enqueue(global.list_chat, "Necesitas encontrar la llave para abrirla.");
                
                // Asegurar que o_chat existe
                if (!instance_exists(o_chat)) {
                    instance_create_depth(0, 0, -9999, o_chat);
                }
            }
            exit; // IMPORTANTE: Terminar aquí, no ejecutar room_goto
        }
        // Si tiene llave, continúa abajo hacia room_goto
    }
    
    // Si llegamos aquí: O no es la puerta cerrada, O tenemos la llave.
    // TRANSICIÓN MANUAL
    
    global.previous_room = room;
    
    if (variable_instance_exists(id, "exit_ori")) {
        if (ori == -1 || exit_ori != ori) ori = exit_ori;
    }
    
    if (variable_instance_exists(id, "entry_id") && entry_id != noone && entry_id != "") {
        global.previous_entry = entry_id;
    } else {
        global.previous_entry = noone;
    }
    
    if (target_room != noone && room_exists(target_room)) {
        room_goto(target_room);
    }
}


