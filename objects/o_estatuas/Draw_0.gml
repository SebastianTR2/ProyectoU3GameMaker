draw_self();

if (instance_exists(o_player)) {
    var _dist = point_distance(x, y, o_player.x, o_player.y);
    // Aumentar rango de visualización
    if (_dist < 65) { 
        // Solo mostrar si NO hay chat abierto
        if (!instance_exists(o_chat) && !instance_exists(o_dialog_box)) {
            // Usar sprite de tecla E si existe, sino fallback a texto
            if (sprite_exists(s_keyboard_E)) {
                draw_sprite(s_keyboard_E, 0, x, y - 50);
            } else {
                draw_set_halign(fa_center);
                draw_text(x, y - 50, "E");
                draw_set_halign(fa_left);
            }
        }
    }
}
