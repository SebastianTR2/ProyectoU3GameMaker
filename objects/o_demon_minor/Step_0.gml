/// STEP EVENT — o_demon_minor

var target = o_player;
if (!instance_exists(target)) exit;

var dist = point_distance(x, y, target.x, target.y);
var dir  = point_direction(x, y, target.x, target.y);

if (attack_timer > 0) attack_timer--;
if (jump_timer > 0) jump_timer--;

// === ORIENTACIÓN DEL SPRITE ===
// 🧭 Como los sprites miran a la izquierda por defecto,
// el valor 1 mantiene esa dirección, y -1 los voltea a la derecha.
if (target.x > x) {
    image_xscale = -1; // voltea a la derecha
} else {
    image_xscale = 1;  // mantiene la orientación izquierda original
}

// === IA PRINCIPAL ===
switch (state)
{
    case "idle":
        if (dist < hunt_range) state = "chase";
    break;

    case "chase":
        if (dist > hunt_range * 1.5) {
            state = "idle";
        }
        else if (dist <= attack_range) {
            state = choose("melee", "jump");
        }
        else if (dist <= ranged_range && attack_timer <= 0) {
            state = "fireball";
        }
        else {
            var newx = x + lengthdir_x(spd, dir);
            var newy = y + lengthdir_y(spd, dir);

            if (place_free(newx, y)) x = newx;
            if (place_free(x, newy)) y = newy;
        }
    break;

    case "melee":
        if (attack_timer <= 0) {
            // Triple garra / fuego corto
            for (var i = 0; i < 3; i++) {
                if (place_meeting(x, y, target)) {
                    var p = instance_place(x, y, target);
                    if (p != noone) {
                        with (p)
                            scr_player_take_damage(other, other.damage, "melee");
                    }
                }
               // if (global.ps_main != undefined)
                   // part_particles_create(global.ps_main, x, y, global.p_spark, 2);
            }
            attack_timer = attack_cooldown;
        }
        if (dist > attack_range + 10) state = "chase";
    break;

    case "fireball":
        if (attack_timer <= 0) {
            var fb = instance_create_layer(x, y - 8, "Instances", fireball_type);
            fb.direction = dir;
            fb.speed = 5;
            fb.damage = magic_damage;
            fb.owner = id;

            // 🔥 orienta la bola según el giro del demonio
            fb.image_xscale = image_xscale;

            attack_timer = attack_cooldown;
        }
        if (dist < attack_range) state = "melee";
        if (dist > ranged_range + 30) state = "chase";
    break;

    case "jump":
        if (can_jump_attack && jump_timer <= 0) {
            var jump_dir = dir;
            var jump_dist = 48;

            x += lengthdir_x(jump_dist, jump_dir);
            y += lengthdir_y(jump_dist, jump_dir);

            if (place_meeting(x, y, target)) {
                var p = instance_place(x, y, target);
                if (p != noone) {
                    with (p)
                        scr_player_take_damage(other, other.damage * 1.2, "melee");
                }
            }

            //if (global.ps_main != undefined)
                //part_particles_create(global.ps_main, x, y, global.p_boom, 3);

            jump_timer = jump_cooldown;
            attack_timer = attack_cooldown;
        }
        state = "chase";
    break;

    case "dead":
        instance_destroy();
    break;
}

// === CAMBIO DE SPRITES ===
switch (state)
{
    case "idle":      sprite_index = sprite_idle; break;
    case "chase":     sprite_index = sprite_move; break;
    case "melee":     sprite_index = sprite_attack; break;
    case "jump":      sprite_index = sprite_jump; break;
    case "fireball":  sprite_index = sprite_fireball; break;
    case "dead":      sprite_index = sprite_dead; break;
}
