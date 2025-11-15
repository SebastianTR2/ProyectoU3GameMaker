/// STEP EVENT - o_slime

var target = o_player;
if (!instance_exists(target)) exit;

// === Calcular distancia y dirección ===
var dist = point_distance(x, y, target.x, target.y);
var dir  = point_direction(x, y, target.x, target.y);

// === Timers ===
if (attack_timer > 0) attack_timer--;

// === ORIENTACIÓN DEL SPRITE ===
// (Sprites base miran a la izquierda)
if (target.x > x) {
    image_xscale = -1; // mira a la derecha
} else {
    image_xscale = 1;  // mira a la izquierda
}

// ================================================
// LÓGICA DE ESTADOS
// ================================================
switch (state)
{
    case "idle":
        if (dist < hunt_range) state = "hunting";
        if (irandom(40) == 0) {
            // part_particles_create(global.ps_main, x, y, global.p_slime, 1);
        }
    break;

    case "hunting":
        if (dist > hunt_range * 1.5) state = "idle";
        else if (dist > attack_range)
        {
            var newx = x + lengthdir_x(spd, dir);
            var newy = y + lengthdir_y(spd, dir);
            if (place_free(newx, y)) x = newx;
            if (place_free(x, newy)) y = newy;
        }
        else state = "attacking";
    break;

    case "attacking":
        if (attack_timer <= 0)
        {
            sprite_index = sprite_attack;
            if (place_meeting(x, y, target))
            {
                var p = instance_place(x, y, target);
                if (p != noone) with (p)
                    scr_player_take_damage(other.id, other.damage, "melee");
            }
            attack_timer = attack_cooldown;
        }
        if (dist > attack_range + 10) state = "hunting";
    break;

    case "dead":
        instance_destroy();
    break;
}

// === CAMBIO DE SPRITES ===
switch (state)
{
    case "idle":      sprite_index = sprite_idle; break;
    case "hunting":   sprite_index = sprite_move; break;
    case "attacking": sprite_index = sprite_attack; break;
    case "dead":      sprite_index = sprite_dead; break;
}

// === CHEQUEAR MUERTE ===
if (hp <= 0 && state != "dead") state = "dead";
