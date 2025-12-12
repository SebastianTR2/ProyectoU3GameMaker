/// STEP EVENT - o_damage_number
/// ==========================================
/// MOVIMIENTO Y FADE
/// ==========================================

// Subir
y_offset -= rise_speed;

// Fade out
alpha_value -= 1/lifespan;

// Destruir cuando termine
lifespan--;
if (lifespan <= 0)
{
    instance_destroy();
}
