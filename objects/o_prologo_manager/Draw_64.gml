// CINEMÁTICAS FINALES (controladas por cinematic_phase en case 9999)
if (variable_instance_exists(id, "cinematic_phase")) {
    
    // FASE 1: Mostrar cinematica1
    if (cinematic_phase == 1) {
        draw_sprite_stretched(
            s_cinematica1,
            0,
            0, 0,
            display_get_gui_width(),
            display_get_gui_height()
        );
    }
    
    // FASE 2: Mostrar cinematica2
    else if (cinematic_phase == 2) {
        draw_sprite_stretched(
            s_cinematica2,
            0,
            0, 0,
            display_get_gui_width(),
            display_get_gui_height()
        );
    }
    
    // FASE 3: Fade to black sobre la última cinemática
    else if (cinematic_phase == 3) {
        // Primero dibujar la cinematica2 de fondo
        draw_sprite_stretched(
            s_cinematica2,
            0,
            0, 0,
            display_get_gui_width(),
            display_get_gui_height()
        );
        
        // Luego el fade negro encima
        draw_set_alpha(cinematic_alpha);
        draw_set_color(c_black);
        draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
}


