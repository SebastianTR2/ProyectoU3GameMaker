/// DRAW EVENT - o_damage_number
/// ==========================================
/// DIBUJAR NÚMERO DE DAÑO
/// ==========================================

draw_set_alpha(alpha_value);
draw_set_color(color);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(-1); // Fuente por defecto

// Dibujar el texto de daño
draw_text(x, y + y_offset, damage_text);

// Restaurar configuración
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
