// Basic proximity interaction
if (instance_exists(o_player)) {
    var _dist = point_distance(x, y, o_player.x, o_player.y);
    if (_dist < 65) { // Rango aumentado (antes 30)
        
        if (keyboard_check_pressed(ord("E"))) {
            if (!instance_exists(o_dialog_box) && !instance_exists(o_chat)) {
                interact_with_statue(my_god_id);
            }
        }
    }
}
