if (!instance_exists(target)) instance_destroy();

var dir = point_direction(x, y, target.x, target.y);
x += lengthdir_x(spd, dir);
y += lengthdir_y(spd, dir);

if (place_meeting(x, y, o_player))
{
    var p = instance_place(x, y, o_player);
    if (p != noone)
    {
        with (p)
            scr_player_take_damage(other, other.damage, "melee");
    }

    //if (global.ps_main != undefined)
        //part_particles_create(global.ps_main, x, y, global.p_spark, 3);

    instance_destroy();
}

// Fade gradual
alpha -= fade_speed;
if (alpha <= 0) instance_destroy();
