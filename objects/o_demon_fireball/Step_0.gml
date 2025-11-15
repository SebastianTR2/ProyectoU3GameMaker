life--;
if (life <= 0) instance_destroy();

if (place_meeting(x, y, o_player))
{
    var p = instance_place(x, y, o_player);
    if (p != noone)
    {
        with (p)
            scr_player_take_damage(other, other.damage, "magic");
    }

    //if (global.ps_main != undefined)
        //part_particles_create(global.ps_main, x, y, global.p_boom, 3);

    instance_destroy();
}
