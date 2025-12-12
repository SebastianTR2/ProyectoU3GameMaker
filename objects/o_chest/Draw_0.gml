/// DRAW EVENT - o_chest
/// ==========================================
/// DIBUJAR COFRE Y PROMPT
/// ==========================================

// Dibujar el cofre
draw_self();

// Mostrar indicador "Presiona E" si el jugador está cerca
if (show_prompt && !opened)
{
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_text(x, y - sprite_height - 5, "[E] Abrir");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
