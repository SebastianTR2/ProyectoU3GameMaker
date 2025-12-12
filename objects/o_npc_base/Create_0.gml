/// CREATE EVENT — o_npc_base
/// Clase base de todos los NPC interactuables

// --- Parámetros generales ---
interaction_radius  = 64;              // Distancia máxima de interacción
dialog_id           = "";              // ID del diálogo (cada NPC define el suyo en su CREATE)
sprite_indicator    = s_keyboard_E;    // Sprite del ícono de interacción
show_e              = false;           // Control de visibilidad del ícono

dialog_played       = false;           // Evita repetir el diálogo principal si es necesario
player_ref          = noone;           // Referencia al jugador

// --- Variables globales seguras ---
if (!variable_global_exists("dialogue_active")) global.dialogue_active = false;
if (!variable_global_exists("npc_talking")) global.npc_talking = noone;


// Nuevo: registrar última línea usada
last_dialog_line = 0;
