draw_self();

if (instance_exists(o_player)) {
    var _dist = point_distance(x, y, o_player.x, o_player.y);
    if (_dist < 30) {
        draw_set_halign(fa_center);
        draw_text(x, y - 40, "Presiona E");
        draw_set_halign(fa_left);
    }
}
