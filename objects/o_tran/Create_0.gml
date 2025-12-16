/// @description Init Variables
// Configuración por defecto
target_room = noone;
ori = -1;
entry_id = noone;
player_near = false; // Para detectar si el jugador está cerca

// -----------------------------------------------------
// RETROCOMPATIBILIDAD CON "VARIABLE DEFINITIONS"
// -----------------------------------------------------
// Si las variables antiguas existen (definidas en el editor),
// las pasamos a las nuevas variables estandarizadas.

if (variable_instance_exists(id, "target")) {
    target_room = target;
}

if (variable_instance_exists(id, "exit_ori")) {
    ori = exit_ori;
}

