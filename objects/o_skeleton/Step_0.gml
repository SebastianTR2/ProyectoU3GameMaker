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
            if (place_meeting(x, y, target)) {
                var p = instance_place(x, y, target);
                if (p != noone) {
                    with (p)
                        scr_player_take_damage(other, other.damage, "melee");
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
