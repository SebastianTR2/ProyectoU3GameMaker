function scr_dialogo(_speaker, _text)
{
    // -------------------------------------------
    // 1. Inicializar la cola de diálogo
    // -------------------------------------------
    if (!variable_global_exists("list_chat"))
    {
        global.list_chat = ds_queue_create();
    }

    // Si ya existe un diálogo activo, no se debe duplicar
    if (global.dialogue_active)
    {
        return;
    }

    // -------------------------------------------
    // 2. Configurar estado del diálogo
    // -------------------------------------------
    global.dialogue_active = true;
    global.dialogo_terminado = false;

    // Limpiar cola previa (es un diálogo nuevo)
    ds_queue_clear(global.list_chat);

    // -------------------------------------------
    // 3. Formatear línea de diálogo
    // -------------------------------------------
    var line = "";

    if (_speaker != "" && _speaker != undefined)
    {
        line = _speaker + ": " + _text;
    }
    else
    {
        line = _text;
    }

    // Añadir línea al sistema
    ds_queue_enqueue(global.list_chat, line);

    // -------------------------------------------
    // 4. Crear el objeto o_chat SOLO si no existe
    // -------------------------------------------
    if (instance_exists(o_chat))
    {
        with (o_chat) instance_destroy(); // limpiar diálogo anterior corrupto
    }

    instance_create_layer(0, 0, "GUI", o_chat);
}
