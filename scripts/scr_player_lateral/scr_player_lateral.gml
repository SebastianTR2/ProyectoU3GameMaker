// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_lateral(){
	/// @description scr_player_lateral()
	/// Control lateral (plataformas, salto, combate básico)

	if (!variable_instance_exists(self, "move_speed")) exit;
	if (!can_move) exit;
	if (state == "block" || state == "dead") exit; //

	// Movimiento lateral
	var move = 0;
	if (keyboard_check(vk_right) || keyboard_check(ord("D"))) move = 1;
	if (keyboard_check(vk_left)  || keyboard_check(ord("A"))) move = -1;

	xSpeed = move * move_speed;
	if (is_running && stamina > 0) stamina -= stamina_drain;

	// Colisión horizontal
	if (place_free(x + xSpeed, y)) x += xSpeed;

	// Gravedad
	if (!place_meeting(x, y + 1, o_solid))
	{
	    ySpeed += grav;
	    if (ySpeed > fall_speed_max) ySpeed = fall_speed_max;
	    grounded = false;
	}
	else
	{
	    ySpeed = 0;
	    grounded = true;
	}

	// Salto
	if (keyboard_check_pressed(vk_space) && grounded)
	{
	    ySpeed = -jump_power;
	    grounded = false;
	    //if (snd_jump != noone) audio_play_sound(snd_jump, 1, false);
	}

	// Colisión vertical
	if (place_free(x, y + ySpeed)) y += ySpeed;
	else
	{
	    while (place_free(x, y + sign(ySpeed))) y += sign(ySpeed);
	    ySpeed = 0;
	}

	// Estados
	if (!grounded) state = "jump";
	else if (move != 0) state = "walk";
	else if (!attacking) state = "idle";

}