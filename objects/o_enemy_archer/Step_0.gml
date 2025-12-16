/// STEP EVENT - o_enemy_archer
/// ==========================================
/// IA Y COMBATE DEL ARQUERO
/// ==========================================

// Verificar si el jugador existe
var target = o_player;
if (!instance_exists(target)) exit;

// Calcular distancia y dirección al jugador
var dist = point_distance(x, y, target.x, target.y);
var dir = point_direction(x, y, target.x, target.y);

// Reducir timers
if (attack_timer > 0) attack_timer--;

// === ORIENTACIÓN DEL SPRITE ===
// El arquero mira hacia el jugador
if (target.x > x) {
    image_xscale = 1;  // mira a la derecha
} else {
    image_xscale = -1; // mira a la izquierda
}

// === IA PRINCIPAL ===
switch (state)
{
    // --------------------------------------------
    case "idle":
        sprite_index = s_archer_idle;
        image_speed = 0.3;
        
        // Si el jugador está cerca, comenzar a perseguir
        if (dist < hunt_range) {
            state = "chase";
        }
        break;
    
    // --------------------------------------------
    case "chase":
        sprite_index = s_archer_walk;
        image_speed = 0.5;
        
        // Si el jugador se aleja mucho, volver a idle
        if (dist > hunt_range * 1.5) {
            state = "idle";
        }
        // Si está muy cerca, alejarse (mantener distancia)
        else if (dist < flee_range) {
            // Alejarse del jugador
            var flee_dir = dir + 180; // Dirección opuesta al jugador
            var newx = x + lengthdir_x(spd, flee_dir);
            var newy = y + lengthdir_y(spd, flee_dir);
            
            if (place_free(newx, y)) x = newx;
            if (place_free(x, newy)) y = newy;
        }
        // Si está en rango óptimo para disparar y el cooldown terminó, disparar
        else if (dist >= shoot_range_min && dist <= shoot_range_max && attack_timer <= 0) {
            state = "shoot";
        }
        // Si está fuera del rango de disparo pero no muy cerca, acercarse
        else if (dist > shoot_range_max) {
            var newx = x + lengthdir_x(spd, dir);
            var newy = y + lengthdir_y(spd, dir);
            
            if (place_free(newx, y)) x = newx;
            if (place_free(x, newy)) y = newy;
        }
        break;
    
    // --------------------------------------------
    case "shoot":
        sprite_index = s_archer_shoot;
        image_speed = 0.4;
        
        // Disparar flecha solo una vez al inicio del ataque
        if (!arrow_fired) {
            // Calcular dirección hacia el jugador
            var shoot_dir = point_direction(x, y, target.x, target.y);
            
            // Crear la flecha ligeramente delante del arquero
            var offset = 20;
            var arrow_x = x + lengthdir_x(offset, shoot_dir);
            var arrow_y = y + lengthdir_y(offset, shoot_dir);
            
            var arrow = instance_create_layer(arrow_x, arrow_y, "Instances", o_enemy_arrow);
            if (arrow != noone) {
                arrow.direction = shoot_dir;
                arrow.speed = 6;
                arrow.damage = damage;
                arrow.owner = id; // Asignar el arquero como dueño
                arrow.image_angle = shoot_dir; // Rotar la flecha
                show_debug_message("Arquero disparó flecha");
            }
            
            arrow_fired = true;
            shoot_duration_timer = shoot_duration;
        }
        
        // Reducir timer de duración del disparo
        shoot_duration_timer--;
        
        // Después de la duración del disparo, volver a chase
        if (shoot_duration_timer <= 0) {
            attack_timer = attack_cooldown; // Reiniciar cooldown
            arrow_fired = false; // Resetear flag para el próximo disparo
            
            // Si el jugador se alejó mucho o está muy cerca, cambiar estado
            if (dist > hunt_range * 1.5) {
                state = "idle";
            } else if (dist < flee_range) {
                state = "chase"; // Alejarse
            } else {
                state = "chase";
            }
        }
        break;
    
    // --------------------------------------------
    case "dead":
        sprite_index = s_archer_dead;
        image_speed = 0.2;
        
        // Dar experiencia al jugador
        if (instance_exists(target)) {
            with (target) {
                xp += other.xp_drop;
                show_debug_message("Arquero derrotado! +" + string(other.xp_drop) + " XP");
            }
        }
        
        // Destruir después de un breve momento para mostrar la animación
        if (image_index >= sprite_get_number(sprite_index) - 1) {
            instance_destroy();
        }
        break;
}

// === VERIFICAR MUERTE ===
if (hp <= 0 && state != "dead") {
    hp = 0;
    state = "dead";
    show_debug_message("Arquero ha muerto");
}

