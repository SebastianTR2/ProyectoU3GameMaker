/// STEP EVENT - o_slime
/// ==========================================
/// IA SIMPLE DEL SLIME
/// ==========================================

var target = o_player;
if (global.game_paused) {
    image_speed = 0;
    exit;
} else {
    image_speed = 1;
}
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
        if (dist < hunt_range)
            state = "chase";
        break;

    case "chase":
        if (dist > hunt_range * 1.5)
            state = "idle";
        else if (dist <= attack_range)
            state = "attack";
        else
        {
            // Moverse hacia el jugador
            var newx = x + lengthdir_x(spd, dir);
            var newy = y + lengthdir_y(spd, dir);
            if (place_free(newx, y)) x = newx;
            if (place_free(x, newy)) y = newy;
        }
        break;

    case "attack":
        if (attack_timer <= 0)
        {
            // Verificar colisión con el jugador
            if (distance_to_object(target) < attack_range)
            {
                // Hacer daño al jugador
                if (instance_exists(target))
                {
                    with (target)
                    {
                        if (invulnerable_timer <= 0)
                        {
                            var final_damage = other.damage;
                            
                            // Reducir daño si está bloqueando
                            if (blocking)
                            {
                                final_damage *= block_reduction;
                                show_debug_message("¡Bloqueado! Daño reducido a " + string(final_damage));
                            }
                            
                            hp -= final_damage;
                            invulnerable_timer = 60; // 1 segundo de invulnerabilidad
                            
                            // Efecto visual de daño
                            image_blend = c_red;
                            alarm[0] = 5; // Restaurar color en 5 frames
                            
                            // Crear número de daño flotante
                            var dmg_num = instance_create_layer(x, y - sprite_height/2, "Instances", o_damage_number);
                            dmg_num.damage_text = string(round(final_damage * 10) / 10); // Mostrar con 1 decimal
                            dmg_num.color = c_yellow; // Amarillo para daño al jugador
                            
                            show_debug_message("Slime te golpeó! Daño: " + string(final_damage) + " HP: " + string(hp));
                        }
                    }
                }
            }
            attack_timer = attack_cooldown;
        }
        if (dist > attack_range + 10)
            state = "chase";
        break;

    case "dead":
        // Dar experiencia al jugador
        if (instance_exists(target))
        {
            with (target)
            {
                xp += other.xp_drop;
            }
        }
        instance_destroy();
        break;
}

// === MUERTE ===
if (hp <= 0)
{
    state = "dead";
}
