// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_start_npc_dialogo(dialog_id){
	switch (dialog_id) {
        case "npc_guardian":        scr_dialogo_guardian(); break;
        case "npc_mika":            scr_dialogo_gato(); break;
        case "npc_eomer":           scr_dialogo_eomer(); break;
        case "npc_recepcionista":   scr_dialogo_recepcionista(); break;
        default:
            show_debug_message("⚠️ NPC sin diálogo definido: " + string(dialog_id));
    }
}