/// STEP - o_magic_projectile
x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);

// Verificar colisión con enemigos
var enemy = instance_place(x, y, o_enemy_body);
if (enemy != noone)
{
    scr_enemy_take_damage(enemy, damage, element);
    if (!pierce) instance_destroy();
}

if (place_meeting(x, y, o_solid)) instance_destroy();
life--;
if (life <= 0) instance_destroy();
