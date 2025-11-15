/// STEP EVENT - o_dragon_red

var target = o_player;
if (!instance_exists(target)) exit;

var dist = point_distance(x, y, target.x, target.y);
var dir  = point_direction(x, y, target.x, target.y);

if (attack_timer > 0) attack_timer--;
if (fly_timer > 0) fly_timer--;

// === ORIENTACIÓN DEL SPRITE ===
if (target.x > x) {
    image_xscale = 1;  // mira a la derecha
} else {
    image_xscale = -1; // mira a la izquierda
}

// === CAMBIO DE FASE ===
if (hp <= hp_max * 0.5 && phase == "ground") {
    phase = "air";
    show_debug_message("🔥 El Dragón Rojo alza vuelo enfurecido!");
}

// ==========================================
// FASE TERRESTRE
// ==========================================
if (phase == "ground") {
    switch (state) {
        case "ground":
            if (dist <= attack_range && attack_timer <= 0) {
                state = choose("fire_breath", "tail");
            }
            else if (can_fly && fly_timer <= 0 && irandom(100) < 3) {
                state = "air";
                is_flying = true;
                fly_timer = fly_cooldown;
            }
            break;

        case "fire_breath":
            if (attack_timer <= 0) {
                // 🔥 Aliento de fuego
                //if (audio_exists(fire_sound)) audio_play_sound(fire_sound, 1, false);

                for (var i = 0; i < 5; i++) {
                    var flame = instance_create_layer(
                        x + lengthdir_x(40 + i * 10, dir),
                        y,
                        "Instances",
                        o_fire_breath
                    );
                    flame.direction = dir;
                    flame.speed = 6;
                    flame.damage = fire_damage;
                }

                attack_timer = attack_cooldown;
            }

            if (attack_timer > 0)
                state = "ground";
            break;

        case "tail":
            if (attack_timer <= 0) {
                // 🌀 Barrida de cola
                //if (global.ps_main != undefined)
                    //part_particles_create(global.ps_main, x, y, global.p_boom, 3);

                with (o_player) {
                    if (point_distance(x, y, other.x, other.y) < 80)
                        scr_player_take_damage(other, other.damage, "melee");
                }

                attack_timer = attack_cooldown;
            }
            state = "ground";
            break;

        case "air":
            if (is_flying) {
                y -= 2; // se eleva lentamente
                if (y < 200) { // altura máxima simulada
                    is_flying = false;
                    state = "slam";
                }
            }
            break;

        case "dead":
            instance_destroy();
            break;
    }
}

// ==========================================
// FASE AÉREA
// ==========================================
if (phase == "air") {
    switch (state) {
        case "slam":
            if (attack_timer <= 0) {
                // 💥 Caída sísmica
                var quake_radius = 120;

                if (global.ps_main != undefined)
                    part_particles_create(global.ps_main, x, y, global.p_boom_large, 5);

                with (o_player) {
                    if (point_distance(x, y, other.x, other.y) <= quake_radius)
                        scr_player_take_damage(other, other.damage * 1.5, "melee");
                }

                attack_timer = attack_cooldown + 60;
                state = "ground"; 
                phase = "ground";
                y += 100; // aterriza
            }
            break;
    }
}

// === SPRITES ===
switch (state) {
    case "ground":      sprite_index = sprite_idle_ground; break;
    case "fire_breath": sprite_index = sprite_fire_breath; break;
    case "tail":        sprite_index = sprite_tail; break;
    case "air":         sprite_index = sprite_fly; break;
    case "slam":        sprite_index = sprite_slam; break;
    case "dead":        sprite_index = sprite_dead; break;
}
