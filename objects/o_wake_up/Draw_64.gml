/// DRAW GUI EVENT - o_wake_up

// Dibujar capa negra con alpha variable
draw_set_alpha(wake_alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

// Restaurar valores
draw_set_alpha(1);
draw_set_color(c_white);

// Debug visual
if (wake_timer == 1 || wake_timer % 30 == 0) {
    show_debug_message(">>> DRAW GUI ejecutándose - Alpha: " + string(wake_alpha));
}