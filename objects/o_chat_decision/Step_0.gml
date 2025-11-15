/// STEP EVENT — o_chat_decision

if (keyboard_check_pressed(vk_down))
    selected = clamp(selected + 1, 0, ds_list_size(options) - 1);

if (keyboard_check_pressed(vk_up))
    selected = clamp(selected - 1, 0, ds_list_size(options) - 1);

if (keyboard_check_pressed(vk_space)) {

    if (variable_global_exists("dialog_options")) {
        var option_data = global.dialog_options[selected];
        var script_name = option_data[1];

        if (script_name != "") {
            var scr = asset_get_index(script_name);
            if (scr != -1) script_execute(scr);
        }

        // Limpieza de variables globales
        global.dialog_options = [];
        global.decision_callback = "";
    }

    // 🔹 Si no se abrió un nuevo o_chat, liberar control
    if (instance_number(o_chat) == 0) {
        global.dialogue_active = false;
        global.npc_talking = noone;
    }

    instance_destroy();
}
