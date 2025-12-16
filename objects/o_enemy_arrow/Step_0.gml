/// STEP EVENT - o_enemy_arrow
/// ==========================================
/// Movimiento y detección de colisión con el jugador
/// ==========================================

// Movimiento de la flecha
x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);

// Rotar la flecha según su dirección
image_angle = direction;

// Verificar colisión con el jugador
if (place_meeting(x, y, o_player)) {
    var player = instance_place(x, y, o_player);
    if (player != noone) {
        // Aplicar daño al jugador directamente (sin usar script problemático)
        with (player) {
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
                
                show_debug_message("Flecha golpeó al jugador por " + string(final_damage) + " de daño");
            }
        }
        instance_destroy();
        exit;
    }
}

// Verificar colisión con sólidos
if (place_meeting(x, y, o_solid) || place_meeting(x, y, o_solid2) || place_meeting(x, y, o_solid3)) {
    instance_destroy();
    exit;
}

// Reducir vida útil
life--;
if (life <= 0) {
    instance_destroy();
}


