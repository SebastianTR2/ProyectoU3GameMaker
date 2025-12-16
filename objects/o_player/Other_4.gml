/// @description Respawn Logic

if (variable_global_exists("player_dead") && global.player_dead) {
    if (variable_global_exists("checkpoint_room") && global.checkpoint_room == room) {
        
        // Mover al checkpoint
        x = global.checkpoint_x;
        y = global.checkpoint_y;
        
        // Revivir
        global.player_dead = false;
        dead = false; // o_player variable
        can_move = true;
        state = "idle";
        hp = hp_max;
        image_alpha = 1;
        
        show_debug_message("Player respawned at checkoint!");
    }
}
