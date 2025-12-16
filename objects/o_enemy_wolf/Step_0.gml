/// STEP EVENT - o_enemy_wolf
/// ==========================================
/// IA Y COMBATE DEL LOBO CON DASH
/// ==========================================

// Verificar si el jugador existe
var target = o_player;
if (!instance_exists(target)) exit;

// Calcular distancia y dirección al jugador
var dist = point_distance(x, y, target.x, target.y);
var dir = point_direction(x, y, target.x, target.y);

// Reducir timers
if (dash_timer > 0) dash_timer--;

// === ORIENTACIÓN DEL SPRITE ===
// El lobo mira hacia el jugador
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
        sprite_index = s_wolf_idle;
        image_speed = 0.3;
        
        // Si el jugador está cerca, comenzar a caminar hacia él
        if (dist < hunt_range) {
            state = "walk";
        }
        break;
    
    // --------------------------------------------
    case "walk":
        sprite_index = s_wolf_walk;
        image_speed = 0.5;
        
        // Si el jugador se aleja mucho, volver a idle
        if (dist > hunt_range * 1.5) {
            state = "idle";
        }
        // Si está en rango para dash y el cooldown terminó, iniciar dash
        else if (dist <= dash_range && dash_timer <= 0) {
            state = "dash";
            dash_direction = dir; // Guardar dirección hacia el jugador
            dash_duration_timer = dash_duration;
            dash_hitbox_created = false;
        }
        // Si no está en rango, caminar hacia el jugador
        else if (dist > dash_range) {
            var newx = x + lengthdir_x(spd, dir);
            var newy = y + lengthdir_y(spd, dir);
            
            // Verificar colisiones antes de moverse
            if (place_free(newx, y)) x = newx;
            if (place_free(x, newy)) y = newy;
        }
        break;
    
    // --------------------------------------------
    case "dash":
        sprite_index = s_wolf_run;
        image_speed = 0.6;
        
        // Crear hitbox solo una vez al inicio del dash
        if (!dash_hitbox_created) {
            // Crear el hitbox del dash en la posición del lobo
            var hitbox = instance_create_layer(x, y, "Instances", o_enemy_wolf_dash_hitbox);
            if (hitbox != noone) {
                hitbox.owner = id; // Asignar el lobo como dueño
                hitbox.damage = damage;
                dash_hitbox_ref = hitbox; // Guardar referencia para moverlo
                show_debug_message("Lobo inició dash hacia el jugador");
            }
            dash_hitbox_created = true;
        }
        
        // Mover el hitbox con el lobo durante el dash
        if (instance_exists(dash_hitbox_ref)) {
            dash_hitbox_ref.x = x;
            dash_hitbox_ref.y = y;
        }
        
        // Moverse en la dirección del dash (atraviesa al jugador)
        // El dash NO se detiene al golpear, continúa hasta el final
        var newx = x + lengthdir_x(dash_speed, dash_direction);
        var newy = y + lengthdir_y(dash_speed, dash_direction);
        
        // Verificar colisiones con sólidos (pero NO con el jugador)
        if (place_free(newx, y)) {
            x = newx;
        } else {
            // Si choca con sólido, cambiar dirección ligeramente
            dash_direction += 45;
        }
        
        if (place_free(x, newy)) {
            y = newy;
        } else {
            // Si choca con sólido, cambiar dirección ligeramente
            dash_direction += 45;
        }
        
        // Reducir timer de duración del dash
        dash_duration_timer--;
        
        // Después de la duración del dash, entrar en recover
        if (dash_duration_timer <= 0) {
            // Destruir el hitbox si aún existe
            if (instance_exists(dash_hitbox_ref)) {
                with (dash_hitbox_ref) instance_destroy();
            }
            
            dash_timer = dash_cooldown; // Reiniciar cooldown
            dash_hitbox_created = false; // Resetear flag
            dash_hitbox_ref = noone;
            recover_duration_timer = recover_duration;
            state = "recover";
            show_debug_message("Lobo terminó dash, entrando en recover");
        }
        break;
    
    // --------------------------------------------
    case "recover":
        sprite_index = s_wolf_walk;
        image_speed = 0.3;
        
        // Reducir timer de recuperación
        recover_duration_timer--;
        
        // Durante el recover, el lobo puede reposicionarse
        // Si el jugador está muy cerca, alejarse un poco
        if (dist < 50) {
            var flee_dir = dir + 180; // Dirección opuesta al jugador
            var newx = x + lengthdir_x(spd * 0.5, flee_dir);
            var newy = y + lengthdir_y(spd * 0.5, flee_dir);
            
            if (place_free(newx, y)) x = newx;
            if (place_free(x, newy)) y = newy;
        }
        
        // Después del recover, volver a walk o idle
        if (recover_duration_timer <= 0) {
            if (dist < hunt_range) {
                state = "walk";
            } else {
                state = "idle";
            }
        }
        break;
    
    // --------------------------------------------
    case "dead":
        sprite_index = s_wolf_dead;
        image_speed = 0.2;
        
        // Destruir hitbox si existe
        if (instance_exists(dash_hitbox_ref)) {
            with (dash_hitbox_ref) instance_destroy();
        }
        
        // Dar experiencia al jugador
        if (instance_exists(target)) {
            with (target) {
                xp += other.xp_drop;
                show_debug_message("Lobo derrotado! +" + string(other.xp_drop) + " XP");
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
    show_debug_message("Lobo ha muerto");
}


