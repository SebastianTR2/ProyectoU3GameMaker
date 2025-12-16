/// STEP EVENT - o_enemy_skeleton
/// ==========================================
/// IA Y COMBATE DEL ESQUELETO
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
// El esqueleto mira hacia el jugador
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
        sprite_index = s_skeleton_idle;
        image_speed = 0.3;
        
        // Si el jugador está cerca, comenzar a perseguir
        if (dist < hunt_range) {
            state = "chase";
        }
        break;
    
    // --------------------------------------------
    case "chase":
        sprite_index = s_skeleton_walk;
        image_speed = 0.5;
        
        // Si el jugador se aleja mucho, volver a idle
        if (dist > hunt_range * 1.5) {
            state = "idle";
        }
        // Si está en rango de ataque y el cooldown terminó, atacar
        else if (dist <= attack_range && attack_timer <= 0) {
            state = "attack";
        }
        // Si no está en rango, moverse hacia el jugador
        else if (dist > attack_range) {
            var newx = x + lengthdir_x(spd, dir);
            var newy = y + lengthdir_y(spd, dir);
            
            // Verificar colisiones antes de moverse
            if (place_free(newx, y)) x = newx;
            if (place_free(x, newy)) y = newy;
        }
        break;
    
    // --------------------------------------------
    case "attack":
        sprite_index = s_skeleton_attack;
        image_speed = 0.4;
        
        // Crear hitbox solo una vez al inicio del ataque
        if (!attack_hitbox_created) {
            // Calcular posición del hitbox delante del esqueleto
            var offset = 30; // Distancia del hitbox desde el centro del esqueleto
            var hitbox_x = x + lengthdir_x(offset, dir);
            var hitbox_y = y + lengthdir_y(offset, dir);
            
            // Crear el hitbox de la espada
            var hitbox = instance_create_layer(hitbox_x, hitbox_y, "Instances", o_enemy_sword_hitbox);
            if (hitbox != noone) {
                hitbox.owner = id; // Asignar el esqueleto como dueño
                hitbox.damage = damage;
                attack_hitbox_ref = hitbox; // Guardar referencia para moverlo
                show_debug_message("Esqueleto creó hitbox de ataque");
            }
            
            // Marcar que ya creamos el hitbox y iniciar timer de duración
            attack_hitbox_created = true;
            attack_duration_timer = attack_duration;
        }
        
        // Mover el hitbox con el esqueleto durante el ataque
        // Recalcular dirección hacia el jugador (puede haberse movido)
        var current_dir = point_direction(x, y, target.x, target.y);
        var offset = 30;
        if (instance_exists(attack_hitbox_ref)) {
            // Actualizar posición del hitbox delante del esqueleto
            attack_hitbox_ref.x = x + lengthdir_x(offset, current_dir);
            attack_hitbox_ref.y = y + lengthdir_y(offset, current_dir);
        }
        
        // Reducir timer de duración del ataque
        attack_duration_timer--;
        
        // Después de la duración del ataque, volver a chase o idle
        if (attack_duration_timer <= 0) {
            // Destruir el hitbox si aún existe
            if (instance_exists(attack_hitbox_ref)) {
                with (attack_hitbox_ref) instance_destroy();
            }
            
            attack_timer = attack_cooldown; // Reiniciar cooldown
            attack_hitbox_created = false; // Resetear flag para el próximo ataque
            attack_hitbox_ref = noone;
            
            // Si el jugador se alejó, perseguir; si no, volver a idle
            if (dist > attack_range + 10) {
                state = "chase";
            } else {
                state = "idle";
            }
        }
        break;
    
    // --------------------------------------------
    case "dead":
        sprite_index = s_skeleton_dead;
        image_speed = 0.2;
        
        // Destruir hitbox si existe
        if (instance_exists(attack_hitbox_ref)) {
            with (attack_hitbox_ref) instance_destroy();
        }
        
        // Dar experiencia al jugador
        if (instance_exists(target)) {
            with (target) {
                xp += other.xp_drop;
                show_debug_message("Esqueleto derrotado! +" + string(other.xp_drop) + " XP");
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
    show_debug_message("Esqueleto ha muerto");
}

