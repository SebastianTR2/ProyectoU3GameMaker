// Basic proximity interaction
if (instance_exists(o_player)) {
    var _dist = point_distance(x, y, o_player.x, o_player.y);
    if (_dist < 30) { // Interaction radius
        // Show prompt? "Press E"
        // draw_text(x, y-20, "E"); // Better in Draw event
        
        if (keyboard_check_pressed(ord("E"))) {
            if (!instance_exists(o_dialog_box)) {
                interact_with_statue(my_god_id);
            }
        }
    }
}
