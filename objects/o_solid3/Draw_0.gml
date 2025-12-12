/// @description Insert description here
// You can write your code in this editor

//Shadow
if (z != -16) {
	draw_sprite_ext(s_SolidShadow, 0, x, ystart, image_xscale, image_yscale, 0, c_white, 1);
}

//Self
depth = -bbox_bottom + z;
draw_sprite_ext(sprite_index, 0, x, ystart + z, image_xscale, image_yscale, 0, c_white, 1);