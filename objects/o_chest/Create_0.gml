/// CREATE EVENT - o_chest
/// ==========================================
/// COFRE INTERACTUABLE
/// ==========================================

// Estado del cofre
opened = false;
image_speed = 0; // Sin animación automática
image_index = 0; // Frame 0 = cerrado

// Contenido del cofre (puedes personalizarlo)
contains_gold = irandom_range(10, 50);
contains_item = noone; // Puede ser un objeto específico

// Indicador visual
show_prompt = false;
