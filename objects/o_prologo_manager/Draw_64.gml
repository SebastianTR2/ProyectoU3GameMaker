// CINEMÁTICA 1 (imagen 1)
if (global.prologo_phase == 8) {
    draw_sprite_stretched(
        s_cinematica1,
        0,
        0, 0,
        display_get_gui_width(),
        display_get_gui_height()
    );
}

// CINEMÁTICA 2 (imagen 2)
if (global.prologo_phase == 9) {
    draw_sprite_stretched(
        s_cinematica2,
        0,
        0, 0,
        display_get_gui_width(),
        display_get_gui_height()
    );
}
