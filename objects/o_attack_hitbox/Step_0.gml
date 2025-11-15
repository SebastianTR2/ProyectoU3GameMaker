/// STEP EVENT - o_attack_hitbox
with (o_enemy)
{
    if (place_meeting(x, y, other))
    {
        scr_enemy_take_damage(id, other.damage, other.attack_type);
        instance_destroy(other);
    }
}
// Reducir duración
lifespan--;
if (lifespan <= 0) instance_destroy();
