/// USER DEFINED EVENT - scr_interact override
/// ==========================================
/// ABRIR COFRE
/// ==========================================

if (!opened)
{
    opened = true;
    image_index = 1; // Frame 1 = abierto
    
    // Dar recompensa al jugador
    if (instance_exists(o_player))
    {
        with (o_player)
        {
            // Aquí puedes agregar oro, items, etc.
            show_debug_message("¡Cofre abierto! Obtenido: " + string(other.contains_gold) + " oro");
            
            // Si tienes sistema de inventario:
            // gold += other.contains_gold;
        }
    }
    
    show_debug_message("Cofre abierto!");
}
else
{
    show_debug_message("El cofre ya está vacío.");
}
