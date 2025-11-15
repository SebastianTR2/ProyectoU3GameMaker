/// STEP EVENT — o_goblin

var target = o_player;
if (!instance_exists(target)) exit;

var dist = point_distance(x, y, target.x, target.y);
var dir  = point_direction(x, y, target.x, target.y);

if (attack_timer > 0) attack_timer--;
if (taunt_timer > 0) taunt_timer--;

// === ORIENTACIÓN DEL SPRITE ===
// Mira hacia donde esté el jugador
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
            state = choose("chase", "taunt"); // a veces provoca
        break;

    case "chase":
        if (dist > hunt_range * 1.5)
            state = "idle";
        else if (dist <= attack_range)
            state = "attack_melee";
        else if (dist <= ranged_range && has_projectile)
            state = "attack_ranged";
        else
        {
            var newx = x + lengthdir_x(spd, dir);
            var newy = y + lengthdir_y(spd, dir);
            if (place_free(newx, y)) x = newx;
            if (place_free(x, newy)) y = newy;
        }
        break;

    case "attack_melee":
        if (attack_timer <= 0)
        {
            if (place_meeting(x, y, target))
            {
                var p = instance_place(x, y, target);
                if (p != noone)
                {
                    with (p)
                        scr_player_take_damage(other, other.damage, "melee");
                }
            }
            attack_timer = attack_cooldown;
        }
        if (dist > attack_range + 10)
            state = "chase";
        break;

    case "attack_ranged":
        if (attack_timer <= 0)
        {
            var bomb = instance_create_layer(x, y - 8, "Instances", projectile_type);
            bomb.direction = dir;
            bomb.speed = 4;
            bomb.damage = ranged_damage;
            bomb.owner = id;

            // 🔄 Alinea el proyectil con la dirección visual del goblin
            bomb.image_xscale = image_xscale;

            attack_timer = attack_cooldown;
        }
        if (dist < attack_range)
            state = "attack_melee";
        if (dist > ranged_range + 20)
            state = "chase";
        break;

    case "taunt":
        if (taunt_timer <= 0 && dist < 180)
        {
            if (instance_exists(target))
            {
                with (target)
                {
                    defense = max(0, defense - 1); // reduce defensa
                    show_debug_message("El duende te ha provocado (-1 DEF temporal)");
                }
            }
            taunt_timer = taunt_cooldown;
            attack_timer = 40;
        }
        if (attack_timer <= 0)
            state = "chase";
        break;

    case "dead":
        instance_destroy();
        break;
}

// === CAMBIO DE SPRITE ===
switch (state)
{
    case "idle":          sprite_index = sprite_idle; break;
    case "chase":         sprite_index = sprite_walk; break;
    case "attack_melee":  sprite_index = sprite_attack_melee; break;
    case "attack_ranged": sprite_index = sprite_attack_ranged; break;
    case "taunt":         sprite_index = sprite_taunt; break;
    case "dead":          sprite_index = sprite_dead; break;
}
