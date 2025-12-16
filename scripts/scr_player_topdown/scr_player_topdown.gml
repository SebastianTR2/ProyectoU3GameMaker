// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_topdown(){
	/// @description scr_player_topdown()
	/// Movimiento, combate y control general en vista top-down

	if (!variable_instance_exists(self, "move_speed")) exit;
	if (global.game_paused) exit; // Pausa total
	if (!can_move) exit;

	if (state == "block" || state == "dead") exit; // ← añade esta línea


	// === MOVIMIENTO ===
	mx = 0; my = 0;

	if ( keyboard_check(ord("D"))) mx += 1;
	if ( keyboard_check(ord("A"))) mx -= 1;
	if ( keyboard_check(ord("S"))) my += 1;
	if ( keyboard_check(ord("W"))) my -= 1;

	// Normalizar
	if (mx != 0 || my != 0)
	{
	    var len = point_distance(0, 0, mx, my);
	    mx /= len; my /= len;
	}

	// === CORRER (usa stamina) ===
	if ((keyboard_check(vk_shift) || keyboard_check(ord("Q"))) && stamina > 0)
	{
	    current_speed = run_speed;
	    is_running = true;
	    stamina -= stamina_drain;
	}
	else
	{
	    current_speed = move_speed;
	    is_running = false;
	}

	// Movimiento con colisiones
	var newx = x + mx * current_speed;
	var newy = y + my * current_speed;
	if (place_free(newx, y)) x = newx;
	if (place_free(x, newy)) y = newy;

	// === DIRECCIÓN VISUAL ===
	if (abs(mx) > 0 || abs(my) > 0)
	{
	    if (mx > 0) sprite_facing = 2;
	    else if (mx < 0) sprite_facing = 1;
	    else if (my < 0) sprite_facing = 3;
	    else if (my > 0) sprite_facing = 0;
	}

	// === ESTADOS ===
	if (mx != 0 || my != 0) state = "walk";
	else if (!attacking && state != "block" && state != "cast") state = "idle";

}