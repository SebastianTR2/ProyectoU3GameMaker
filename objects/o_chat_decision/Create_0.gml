 /// o_chat_decision — CREATE EVENT

// Crear estructura de opciones
options = ds_list_create();
selected = 0;
text = "";

// Verificar que existan las opciones globales
if (variable_global_exists("dialog_options") && !is_undefined(global.dialog_options)) {
    for (var i = 0; i < array_length(global.dialog_options); i++) {
        ds_list_add(options, global.dialog_options[i][0]);
    }
} else {
    ds_list_add(options, "(Sin opciones disponibles)");
}

// Texto opcional de título
text = "¿Qué decides?";
