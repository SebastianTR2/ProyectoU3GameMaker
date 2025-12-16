// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_dialogo_recepcionista(){
    // Diálogo de Recepcionista
    // Inicializar la cola si no existe
    if (!variable_global_exists("list_chat")) {
        global.list_chat = ds_queue_create();
    }
    
    // Limpiar cola previa
    ds_queue_clear(global.list_chat);
    
    // Añadir todas las líneas del diálogo a la cola
    ds_queue_enqueue(global.list_chat, "Recepcionista: ¿Trámite?");
    ds_queue_enqueue(global.list_chat, "Eomer: Identificación. Mi… compañero aquí perdió la memoria. No sabe quién es ni de dónde viene.");
    ds_queue_enqueue(global.list_chat, "Recepcionista: ¿Un caso de amnesia? No es raro últimamente. Aunque…");
    ds_queue_enqueue(global.list_chat, "Recepcionista: …no solemos tener elfos solicitando registro voluntario.");
    ds_queue_enqueue(global.list_chat, "Daeron: ¿Eso es un problema?");
    ds_queue_enqueue(global.list_chat, "Recepcionista: Solo si decides morder a alguien.");
    ds_queue_enqueue(global.list_chat, "Recepcionista: Tranquilo, no eres el primero que entra con cara de no saber ni su propio nombre.");
    ds_queue_enqueue(global.list_chat, "Recepcionista ((mirándolo con atención):Aun así… hay algo en ti que no logro ubicar.");
    ds_queue_enqueue(global.list_chat, "Eomer: ¿Qué clase de registro es este exactamente?");
    ds_queue_enqueue(global.list_chat, "Recepcionista: El tipo que no se mete en política.");
    ds_queue_enqueue(global.list_chat, "Recepcionista: Documento afinidades mágicas, permisos de práctica, accidentes leves con fuego y explosiones no autorizadas.");
    ds_queue_enqueue(global.list_chat, "Recepcionista: Vamos, coloca el brazo aquí.");
    ds_queue_enqueue(global.list_chat, "Recepcionista: No dolerá… si no tienes nada que ocultar.");
    ds_queue_enqueue(global.list_chat, "Daeron: ¿Y si tengo algo que no sé que oculto?");
    ds_queue_enqueue(global.list_chat, "Recepcionista (sonríe apenas): Entonces lo descubriremos juntos.");
    
    // Activar el diálogo y crear o_chat (solo una vez)
    global.dialogue_active = true;
    global.dialogo_terminado = false;
    
    // Crear el objeto o_chat SOLO si no existe
    if (instance_exists(o_chat)) {
        with (o_chat) instance_destroy();
    }
    
    instance_create_layer(0, 0, "Instances", o_chat);
}

