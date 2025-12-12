/// STEP EVENT - o_chest
/// ==========================================
/// DETECTAR JUGADOR CERCANO
/// ==========================================

// Verificar si el jugador está cerca
if (instance_exists(o_player))
{
    var dist = distance_to_object(o_player);
    
    if (dist < 50 && !opened) // Aumentado de 40 a 50
    {
        show_prompt = true;
    }
    else
    {
        show_prompt = false;
    }
}
