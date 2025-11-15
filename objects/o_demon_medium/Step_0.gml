/// STEP EVENT — o_demon_medium

var target = o_player;
if (!instance_exists(target)) exit;

var dist = point_distance(x, y, target.x, target.y);
var dir  = point_direction(x, y, target.x, target.y);

if (attack_timer > 0) attack_timer--;
if (charge_timer > 0) charge_timer--;
if (summon_timer > 0) summon_timer--;

// === ORIENTACIÓN DEL SPRITE ===
// 🔸 Hace que mire hacia el jugador automáticamente
if (target.x > x) {
    image_xscale = 1;  // mira a la derecha
} else {
    image_xscale = -1; // mira a la izquierda
}

// === IA PRINCIPAL ===
switch (state)
{
    case "idle":
        if (dist < hunt_range)
            state = "chase";
    break;

    case "chase":
        if (dist > hunt_range * 1.5)
        {
            state = "idle";
        }
        else if (dist <= attack_range && attack_timer <= 0)
        {
            var next_attack = choose("aoe", "charge", "summon");
            state = next_attack;
        }
        else
        {
            var newx = x + lengthdir_x(spd, dir);
            var newy = y + lengthdir_y(spd, dir);
            if (place_free(newx, y)) x = newx;
            if (place_free(x, newy)) y = newy;
        }
    break;

    // === Golpe en área ===
    case "aoe":
        if (attack_timer <= 0)
        {
            //if (global.ps_main != undefined)
                //part_particles_create(global.ps_main, x, y, global.p_boom_large, 4);

            with (o_player)
            {
                if (point_distance(x, y, other.x, other.y) <= other.aoe_radius)
                    scr_player_take_damage(other, other.damage, "melee");
            }

            attack_timer = attack_cooldown;
        }
        state = "chase";
    break;

    // === Embate ígneo (Carga) ===
    case "charge":
        if (can_charge && charge_timer <= 0)
        {
            var charge_dir = dir;
            var charge_dist = 64;
            var charge_steps = 8;

            for (var i = 0; i < charge_steps; i++)
            {
                x += lengthdir_x(charge_dist / charge_steps, charge_dir);
                y += lengthdir_y(charge_dist / charge_steps, charge_dir);

                instance_create_layer(x, y, "Instances", fire_trail);
            }

            if (place_meeting(x, y, target))
            {
                var p = instance_place(x, y, target);
                if (p != noone)
                {
                    with (p)
                        scr_player_take_damage(other, other.damage * 1.5, "melee");
                }
            }

            charge_timer = charge_cooldown;
            attack_timer = attack_cooldown;
        }
        state = "chase";
    break;

    // === Invocación de fuego oscuro ===
    case "summon":
        if (can_summon && summon_timer <= 0)
        {
            for (var i = 0; i < 3; i++)
            {
                var orb = instance_create_layer(
                    x + irandom_range(-32, 32),
                    y - 32 - (i * 24),
                    "Instances",
                    dark_orb
                );
                orb.direction = dir;
                orb.speed = 2.5;
                orb.damage = magic_damage;
                orb.owner = id;
            }

            summon_timer = summon_cooldown;
            attack_timer = attack_cooldown;
        }
        state = "chase";
    break;

    case "dead":
        instance_destroy();
    break;
}

// === CAMBIO DE SPRITE ===
switch (state)
{
    case "idle":    sprite_index = sprite_idle;   break;
    case "chase":   sprite_index = sprite_walk;   break;
    case "aoe":     sprite_index = sprite_attack; break;
    case "charge":  sprite_index = sprite_charge; break;
    case "summon":  sprite_index = sprite_summon; break;
    case "dead":    sprite_index = sprite_dead;   break;
}
