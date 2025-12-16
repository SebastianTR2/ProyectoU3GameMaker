// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_dialogo_eomer(){
    // Diálogo de Eomer
    // Inicializar la cola si no existe
    if (!variable_global_exists("list_chat")) {
        global.list_chat = ds_queue_create();
    }
    
    // Limpiar cola previa
    ds_queue_clear(global.list_chat);
    
    // Añadir todas las líneas del diálogo a la cola
    ds_queue_enqueue(global.list_chat, "Eomer: ¡Alto ahí! ¿Qué hace un elfo solo tan lejos de la muralla?");
    ds_queue_enqueue(global.list_chat, "Eomer: Se acerca la noche. Los monstruos no preguntan nombres. Tengo una casa cerca. Si quieres techo y silencio, sígueme.?");
    
    
    // Activar el diálogo y crear o_chat (solo una vez)
    global.dialogue_active = true;
    global.dialogo_terminado = false;
    
    // Crear el objeto o_chat SOLO si no existe
    if (instance_exists(o_chat)) {
        with (o_chat) instance_destroy();
    }
    
    instance_create_layer(0, 0, "Instances", o_chat);
}