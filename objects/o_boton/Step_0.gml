var antes = hover;
hover = point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom);

if (!antes && hover) {
    audio_play_sound(snd_hover, 1, false);
}
