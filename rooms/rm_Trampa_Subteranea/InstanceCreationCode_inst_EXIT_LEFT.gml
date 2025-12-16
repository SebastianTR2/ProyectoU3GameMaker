// Salida izquierda - Regresa a la sala anterior
// Usa global.previous_room para volver de donde vino
if (variable_global_exists("previous_room") && global.previous_room != noone) {
    target = global.previous_room;
} else {
    // Fallback por si no hay previous_room definido
    target = rm_Santuario_Guardian; 
}
ori = 270; // izquierda
