/// STEP EVENT - o_chat

if (keyboard_check_pressed(vk_space)) {

    if (!ds_queue_empty(global.list_chat)) {
        chat = ds_queue_head(global.list_chat);
        ds_queue_dequeue(global.list_chat);

    } else {
        // OPCIONES
        if (variable_global_exists("dialog_options") && !is_undefined(global.dialog_options)) {
            if (array_length(global.dialog_options) > 0) {
                instance_create_layer(0, 0, "Instances", o_chat_decision);
            }
        }

        // CAMBIO DE ROOM LUEGO DEL DIÁLOGO SI SE PIDIO
        if (variable_global_exists("next_room_after_dialogue") && global.next_room_after_dialogue != undefined) {
            var next = global.next_room_after_dialogue;
            global.next_room_after_dialogue = undefined;

            // IMPORTANTE: marcar finalización del diálogo ANTES del room_goto
            global.dialogo_terminado = true;
            room_goto(next);
        }

        // DIÁLOGO TERMINADO NORMALMENTE
        global.dialogo_terminado = true;
        instance_destroy();
    }
}

