/// STEP EVENT — o_skeleton

var target = o_player;
if (!instance_exists(target)) exit;

var dist = point_distance(x, y, target.x, target.y);
var dir = point_direction(x, y, target.x, target.y);

if (attack_timer > 0) attack_timer--;

// === ORIENTACIÓN DEL SPRITE ===
if (target.x > x) {
    image_xscale = 1;  // mira a la derecha
} else {
    image_xscale = -1; // mira a la izquierda
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
        } else {
            switch (attack_type) {
                case "melee":
                    if (dist <= attack_range) state = "attack";
                    break;
                case "ranged":
                    if (dist <= ranged_range) state = "ranged";
                    break;
                case "lance":
                    if (dist <= attack_range * 1.5) state = "attack";
                    break;
            }

            // Movimiento hacia el jugador
            if (dist > attack_range) {
                var newx = x + lengthdir_x(spd, dir);
                var newy = y + lengthdir_y(spd, dir);
                if (place_free(newx, y)) x = newx;
                if (place_free(x, newy)) y = newy;
            }
        }
        break;

    case "attack":
        if (attack_timer <= 0) {
            if (place_meeting(x, y, o_player)) {
                with (o_player) {
                    if (invulnerable_timer <= 0) {
                        var final_damage = other.damage;
                        
                        // Aplicar defensa si existe
                        if (variable_instance_exists(id, "defense")) {
                            final_damage = max(1, final_damage - defense);
                        }
                        
                        // Reducir daño si está bloqueando
                        if (variable_instance_exists(id, "blocking") && blocking && variable_instance_exists(id, "block_reduction")) {
                            final_damage = final_damage * block_reduction;
                            show_debug_message("¡Bloqueado! Daño reducido a " + string(final_damage));
                        }
                        
                        hp -= final_damage;
                        invulnerable_timer = 60; // 1 segundo de invulnerabilidad
                        
                        // Efecto visual de daño
                        image_blend = c_red;
                        alarm[0] = 5; // Restaurar color en 5 frames
                        
                        // Crear número de daño flotante
                        if (instance_exists(o_damage_number)) {
                            var dmg_num = instance_create_layer(x, y - sprite_height/2, "Instances", o_damage_number);
                            if (dmg_num != noone) {
                                dmg_num.damage_text = string(round(final_damage * 10) / 10);
                                dmg_num.color = c_red;
                            }
                        }
                        
                        show_debug_message("Skeleton te golpeó! Daño: " + string(final_damage) + " HP: " + string(hp));
                    }
                }
            }
            attack_timer = attack_cooldown;
        }
        if (dist > attack_range + 10)
            state = "chase";
        break;

    case "ranged":
        if (attack_timer <= 0) {
            var arrow = instance_create_layer(x, y - 6, "Instances", o_skeleton_arrow);
            arrow.direction = dir;
            arrow.speed = 5;
            arrow.damage = ranged_damage;
            arrow.owner = id;
            attack_timer = attack_cooldown;
        }
        if (dist < attack_range) state = "attack";
        if (dist > ranged_range + 30) state = "chase";
        break;

    case "dead":
        instance_destroy();
        break;
}

// === SPRITES ===
switch (state)
{
    case "idle":   sprite_index = sprite_idle; break;
    case "chase":  sprite_index = sprite_walk; break;
    case "attack":
        if (attack_type == "melee") sprite_index = sprite_attack_melee;
        else if (attack_type == "lance") sprite_index = sprite_attack_lance;
        break;
    case "ranged": sprite_index = sprite_attack_ranged; break;
    case "dead":   sprite_index = sprite_dead; break;
}
