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
}
