/// STEP EVENT — o_guardian_corrupt

var target = o_player;
if (!instance_exists(target)) exit;

// === DISTANCIAS Y DIRECCIÓN ===
var dist = point_distance(x, y, target.x, target.y);
var dir  = point_direction(x, y, target.x, target.y);

if (attack_timer > 0) attack_timer--;
if (echo_timer > 0) echo_timer--;
if (parry_timer > 0) parry_timer--;
if (timecut_timer > 0) timecut_timer--;

// === ORIENTACIÓN DEL SPRITE ===
// Mira hacia donde esté el jugador
if (target.x > x) {
    image_xscale = 1;  // derecha
} else {
    image_xscale = -1; // izquierda
}

// === IA PRINCIPAL ===
switch (state)
{
    // ------------------------------------------------------------
    case "idle":
        if (dist < hunt_range) state = "chase";
    break;

    // ------------------------------------------------------------
    case "chase":
        if (dist > hunt_range * 1.5) {
            state = "idle";
        }
        else if (dist <= attack_range && attack_timer <= 0) {
            var next_attack = choose("slash", "parry", "echo", "timecut");
            state = next_attack;
        }
        else {
            var newx = x + lengthdir_x(spd, dir);
            var newy = y + lengthdir_y(spd, dir);
            if (place_free(newx, y)) x = newx;
            if (place_free(x, newy)) y = newy;
        }
    break;

    // ------------------------------------------------------------
    // ⚔️ ATAQUE NORMAL (Slash)
    case "slash":
        if (attack_timer <= 0) {
            //if (audio_exists(snd_slash)) audio_play_sound(snd_slash, 1, false);

            if (place_meeting(x, y, target)) {
                var p = instance_place(x, y, target);
                if (p != noone) {
                    with (p)
                        scr_player_take_damage(other, other.damage, "melee");
                }
            }

            //if (global.ps_main != undefined)
               // part_particles_create(global.ps_main, x, y, global.p_hit, 3);

            attack_timer = attack_cooldown;
        }
        state = "chase";
    break;

    // ------------------------------------------------------------
    // 🛡️ PARADA PERFECTA
    case "parry":
        if (can_parry && parry_timer <= 0) {
           // if (audio_exists(snd_parry)) audio_play_sound(snd_parry, 1, false);

            // Parada: ignora daño y contraataca si está cerca
            if (point_distance(x, y, target.x, target.y) <= 60) {
                with (o_player) {
                    scr_player_take_damage(other, other.damage * 0.5, "melee");
                }

                //if (global.ps_main != undefined)
                   // part_particles_create(global.ps_main, x, y, global.p_spark, 4);
            }

            parry_timer = parry_cooldown;
        }
        state = "chase";
    break;

    // ------------------------------------------------------------
    // 👁️ INVOCAR ECO DEL PASADO
    case "echo":
        if (can_echo && echo_timer <= 0) {
            var echo = instance_create_layer(x + irandom_range(-48, 48), y, "Instances", echo_object);
            echo.target = target;
            echo.damage = damage * 0.6;
            echo.lifetime = 180;

            //if (global.ps_main != undefined)
               // part_particles_create(global.ps_main, x, y, global.p_dj, 3);

            echo_timer = echo_cooldown;
        }
        state = "chase";
    break;

    // ------------------------------------------------------------
    // ⏳ CORTE TEMPORAL (Timecut)
    case "timecut":
        if (can_timecut && timecut_timer <= 0) {
            //if (audio_exists(snd_timecut)) audio_play_sound(snd_timecut, 1, false);

            //if (global.ps_main != undefined)
              //  part_particles_create(global.ps_main, x, y, global.p_tracer, 6);

            // Efecto de ralentización en el jugador
            with (o_player) {
                if (point_distance(x, y, other.x, other.y) <= other.timecut_radius) {
                    move_speed *= 0.4;
                    run_speed *= 0.4;
                    alarm[0] = other.timecut_effect_time;
                }
            }

            timecut_timer = timecut_cooldown;
        }
        state = "chase";
    break;

    // ------------------------------------------------------------
    case "dead":
        instance_destroy();
    break;
}

// === CAMBIO DE SPRITES SEGÚN ESTADO ===
switch (state)
{
    case "idle":     sprite_index = sprite_idle; break;
    case "chase":    sprite_index = sprite_walk; break;
    case "slash":    sprite_index = sprite_slash; break;
    case "parry":    sprite_index = sprite_parry; break;
    case "echo":     sprite_index = sprite_echo; break;
    case "timecut":  sprite_index = sprite_timecut; break;
    case "dead":     sprite_index = sprite_dead; break;
}
