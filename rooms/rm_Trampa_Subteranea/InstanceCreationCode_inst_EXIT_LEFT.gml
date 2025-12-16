// Salida izquierda - Regresa a la sala anterior
// Usa global.previous_room para volver de donde vino
// Creation Code for inst_EXIT_LEFT (Top Left Door)

// Definir a dónde lleva esta puerta (Regreso)
target = rm_Pasillos_Subteraneos; // Forzar regreso a pasillos
ori = 0; // Dirección 

entry_id = "salida_trampa"; // ID para que el otro lado sepa dónde colocar al jugador
// Fallback por si no hay previous_room definido
// target = rm_Santuario_Guardian; // This line is commented out or removed as target is now fixed
ori = 270; // izquierda

// NUEVO: Transición automática (estilo salida normal)
auto = true;
