/// STEP - o_magic_projectile
x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);

with (o_enemy)
{
    if (place_meeting(x, y, other))
    {
        scr_enemy_take_damage(id, other.damage, other.element);
        if (!other.pierce) instance_destroy(other);
    }
}

if (place_meeting(x, y, o_solid)) instance_destroy();
life--;
if (life <= 0) instance_destroy();
