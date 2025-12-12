/// scr_story_show_decision(id_decision)

//Mostrar decisión (conexión con sistema de diálogos)
//Esta función se llama cuando quieres lanzar una decisión (desde una cinemática o NPC)
function scr_story_show_decision(_id) {

    var dec = ds_map_find_value(global.story_decisions, _id);
    if (is_undefined(dec)) {
        show_debug_message("Decision no encontrada: " + string(_id));
        return;
    }

    // Construir global.dialog_options en el formato pedido
    global.dialog_options = [];

    for (var i = 0; i < array_length(dec.options); i++) {
        var opt = dec.options[i];
        array_push(global.dialog_options, [ opt.text, opt.script_name ]);
    }

    // Aquí llamas a tu sistema de diálogo para mostrar opciones
    // Ejemplo genérico:
    // scr_dialog_start_with_options(dec.title, global.dialog_options);

    // El sistema de diálogo, cuando el jugador elija una opción,
    // hará algo como:
    // script_execute(asset_get_index(opt_script_name));
}
