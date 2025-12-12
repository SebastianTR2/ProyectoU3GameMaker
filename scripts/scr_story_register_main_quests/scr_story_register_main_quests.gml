/// scr_story_register_main_quests()
function scr_story_register_main_quests() {
    // Principal historia
    ds_map_set(global.quest, "M_prologo",          "no_iniciada");
    ds_map_set(global.quest, "M_roll_mazmorra",    "no_iniciada");
    ds_map_set(global.quest, "M_ciudad_costera",   "no_iniciada");
    ds_map_set(global.quest, "M_reino_enano",      "no_iniciada");
    ds_map_set(global.quest, "M_palacio_pesadillas", "no_iniciada");
    ds_map_set(global.quest, "M_runa_sagrada",     "no_iniciada");

    // Secundarias / acompañantes / rutas
    ds_map_set(global.quest, "S_mika_nucleo_1",    "no_iniciada");
    ds_map_set(global.quest, "S_eomer_hermana",    "no_iniciada");
    ds_map_set(global.quest, "S_ruta_luz",         "no_iniciada");
    ds_map_set(global.quest, "S_ruta_caos",        "no_iniciada");
}
