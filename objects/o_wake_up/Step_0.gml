/// STEP EVENT - o_wake_up

wake_timer++;

if (wake_timer == 1) {
    show_debug_message(">>> o_wake_up: PRIMER STEP - Alpha inicial: " + string(wake_alpha));
}

// Fade in inmediato (sin pausa)  
if (wake_timer <= 120) {
    // Fade in gradual durante 2 segundos (120 frames)
    wake_alpha = 1 - (wake_timer / 120);
    
    if (wake_timer % 30 == 0) {
        show_debug_message(">>> Fade progress - Timer: " + string(wake_timer) + " | Alpha: " + string(wake_alpha));
    }
}
// Al terminar el fade
else if (wake_timer == 121) {
    show_debug_message(">>> FADE COMPLETO - Desbloqueando jugador");
    
    // Descongelar al jugador
    if (instance_exists(o_player)) {
        o_player.can_move = true;
        show_debug_message(">>> Player desbloqueado");
    } else {
        show_debug_message(">>> ERROR: o_player NO EXISTE");
    }
    
    // Destruir este controlador
    show_debug_message(">>> o_wake_up destruyéndose");
    instance_destroy();
}