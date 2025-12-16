/// @description Detectar Jugador
if (instance_exists(o_player))
{
    var dist = distance_to_object(o_player);
    if (dist < 16 && !open)
    {
        show_prompt = true;
    }
    else
    {
        show_prompt = false;
    }
}