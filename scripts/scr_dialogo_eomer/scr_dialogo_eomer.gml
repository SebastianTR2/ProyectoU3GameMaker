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
    ds_queue_enqueue(global.list_chat, "Eomer: ¡Saludos, viajero! Me alegra verte por aquí.");
    ds_queue_enqueue(global.list_chat, "Eomer: ¿Hay algo en lo que pueda ayudarte?");
    ds_queue_enqueue(global.list_chat, "Eomer: Si necesitas información sobre esta región, estaré encantado de compartir lo que sé.");
    
    // Activar el diálogo y crear o_chat (solo una vez)
    global.dialogue_active = true;
    global.dialogo_terminado = false;
    
    // Crear el objeto o_chat SOLO si no existe
    if (instance_exists(o_chat)) {
        with (o_chat) instance_destroy();
    }
    
    instance_create_layer(0, 0, "Instances", o_chat);
}