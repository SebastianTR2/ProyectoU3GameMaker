/// scr_story_set_route(key, value)

//Sistema de rutas – Scripts base 4.1 Helpers genéricos

function scr_story_set_route(_key, _value) {
    ds_map_set(global.story_routes, _key, _value);

    // Actualizar alias globales para acceso rápido
    switch (_key) {
        case "moral":     global.route_moral     = _value; break;
        case "karma":     global.route_karma     = _value; break;
        case "element":   global.route_element   = _value; break;
        case "world":     global.route_world     = _value; break;
        case "companion": global.route_companion = _value; break;
        case "skill":     global.route_skill     = _value; break;
    }
}

/// Atajos específicos para cada ruta

function scr_route_set_moral(_value) {
    // "guardian" / "rebelde"
    scr_story_set_route("moral", _value);
}

function scr_route_set_karma(_value) {
    // "luz" / "caos"
    scr_story_set_route("karma", _value);
}

function scr_route_set_element(_value) {
    // "fuego" / "tiempo" / "viento"
    scr_story_set_route("element", _value);
}

function scr_route_set_world(_value) {
    // "ciudad" / "salvaje"
    scr_story_set_route("world", _value);
}

function scr_route_set_companion(_value) {
    // "mika" / "eomer"
    scr_story_set_route("companion", _value);
}

function scr_route_set_skill(_value) {
    // "tecnologica" / "arcana"
    scr_story_set_route("skill", _value);
}
