// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_story_init_globals() {

    // Evitar inicializar dos veces
    if (variable_global_exists("story_initialized") && global.story_initialized) {
        return;
    }
    global.story_initialized = true;

    /// ===============================
    /// FASES Y ESTADO GENERAL
    /// ===============================
    // Puedes usar un enum en otro script si quieres algo más legible
    global.story_phase      = 0;      // fase principal (número o string)
    global.story_subphase   = 0;      // subfase opcional
    global.story_chapter    = 1;      // capítulo grande (opcional)
    
    // Debug
    global.debug_mode = false;

    /// ===============================
    /// FLAGS Y RUTAS
    /// ===============================
    if (!variable_global_exists("story_flags")) {
        global.story_flags = ds_map_create();             // bools / estados clave
    }

    if (!variable_global_exists("story_routes")) {
        global.story_routes = ds_map_create();            // mapa de rutas
        ds_map_add(global.story_routes, "moral",      "neutral");   // guardian/rebelde
        ds_map_add(global.story_routes, "karma",      "equilibrio"); // luz/caos
        ds_map_add(global.story_routes, "element",    "ninguno");    // fuego/tiempo/viento
        ds_map_add(global.story_routes, "world",      "ciudad");     // ciudad/salvaje
        ds_map_add(global.story_routes, "companion",  "ninguno");    // mika/eomer
        ds_map_add(global.story_routes, "skill",      "ninguna");    // tecnologica/arcana

        // Alias cómodos para acceso directo
        global.route_moral      = global.story_routes[? "moral"];
        global.route_karma      = global.story_routes[? "karma"];
        global.route_element    = global.story_routes[? "element"];
        global.route_world      = global.story_routes[? "world"];
        global.route_companion  = global.story_routes[? "companion"];
        global.route_skill      = global.story_routes[? "skill"];
    }

    /// ===============================
    /// SISTEMA DE MISIONES
    /// ===============================
    if (!variable_global_exists("quest")) {
        global.quest = ds_map_create(); // id -> "no_iniciada"/"en_progreso"/"completada"/"fallada"
    }

    /// ===============================
    /// DECISIONES Y AUTO-TRIGGERS
    /// ===============================
    if (!variable_global_exists("story_decisions")) {
        global.story_decisions = ds_map_create();   // id_decision -> struct con datos
    }

    if (!variable_global_exists("story_auto_triggers")) {
        global.story_auto_triggers = ds_list_create(); // lista de structs {id, condition, action, once, fired}
    }

    /// ===============================
    /// CINEMÁTICAS
    /// ===============================
    if (!variable_global_exists("story_cinematic_queue")) {
        global.story_cinematic_queue = ds_queue_create(); // cola de funciones de cinemáticas
    }
    global.story_current_cinematic = noone;   // función actual o -1
    global.story_in_cinematic      = false;

    /// ===============================
    /// SISTEMA DE DIÁLOGOS (OPCIONES)
    /// ===============================
    // El sistema de diálogo (o_chat) leerá esto
    global.dialog_options = [];      // lista de ["Texto", "nombre_script"]

    // Flags ejemplo
    ds_map_set(global.story_flags, "prologo_completado", false);
    ds_map_set(global.story_flags, "conoce_lucius", false);
}
