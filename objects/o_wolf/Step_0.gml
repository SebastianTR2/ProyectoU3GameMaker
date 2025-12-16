/// STEP EVENT - o_wolf
/// ================================================
/// IA y combate del enemigo cuerpo a cuerpo
/// ================================================

var target = o_player;
if (!instance_exists(target)) exit;

// === ACTUALIZAR DIRECCIÓN Y DISTANCIA ===
var dist = point_distance(x, y, target.x, target.y);
var dir_to_player = point_direction(x, y, target.x, target.y);

// === TIMERS ===
if (attack_timer > 0) attack_timer--;

// === IA PRINCIPAL ===
switch (state)
{
    // --------------------------------------------
    case "idle":
        if (dist < hunt_range) state = "hunting";
        break;

    // --------------------------------------------
    case "hunting":
        if (dist > hunt_range * 1.5)
        {
            state = "idle";
        }
        else if (dist > attack_range)
        {
            var newx = x + lengthdir_x(spd, dir_to_player);
            var newy = y + lengthdir_y(spd, dir_to_player);

            if (place_free(newx, y)) x = newx;
            if (place_free(x, newy)) y = newy;
        }
        else
        {
            state = "attacking";
        }
        break;

    // --------------------------------------------
    case "attacking":
        // Solo atacar si el cooldown terminó
        if (attack_timer <= 0)
			{
			    if (place_meeting(x, y, target))
			    {
			        var p = instance_place(x, y, target);
			        if (p != noone)
			        {
			            with (p)
			            {
			                // pasa SIEMPRE tipo "melee" para bloqueo total
			                scr_player_take_damage(other.id, other.damage, "melee");
			            }
			        }
			    }
			    attack_timer = attack_cooldown;
			}
        // Luego vuelve a "hunting" si el jugador se aleja
        if (dist > attack_range + 10)
            state = "hunting";
        break;

    // --------------------------------------------
    case "dead":
        instance_destroy();
        break;
}

// ================================================
// CAMBIO DE SPRITES SEGÚN DIRECCIÓN Y ESTADO
// ================================================
if (dir_to_player < 90 || dir_to_player > 270) // jugador a la derecha
{
    switch (state)
    {
        case "idle": sprite_index = s_wolf_reposo_derecha; break;
        case "hunting": sprite_index = s_wolf_caminando_derecha; break;
        case "attacking": sprite_index = s_wolf_atacando_derecha; break;
        case "dead": sprite_index = s_wolf_reposo_derecha; break;
    }
}
else // jugador a la izquierda
{
    switch (state)
    {
        case "idle": sprite_index = s_wolf_reposo; break;
        case "hunting": sprite_index = s_wolf_caminando; break;
        case "attacking": sprite_index = s_wolf_atacando; break;
        case "dead": sprite_index = s_wolf_reposo; break;
    }
}
