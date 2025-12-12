/// scr_start_mission(id)
function scr_start_mission(_id) {
    var state = "en_progreso";
    ds_map_set(global.quest, _id, state);
}

/// scr_complete_mission(id)
function scr_complete_mission(_id) {
    ds_map_set(global.quest, _id, "completada");
}

/// scr_fail_mission(id)
function scr_fail_mission(_id) {
    ds_map_set(global.quest, _id, "fallada");
}

/// scr_is_mission_active(id)
function scr_is_mission_active(_id) {
    if (!ds_map_exists(global.quest, _id)) return false;
    var st = ds_map_find_value(global.quest, _id);
    return (st == "en_progreso");
}

/// scr_is_mission_completed(id)
function scr_is_mission_completed(_id) {
    if (!ds_map_exists(global.quest, _id)) return false;
    var st = ds_map_find_value(global.quest, _id);
    return (st == "completada");
}
