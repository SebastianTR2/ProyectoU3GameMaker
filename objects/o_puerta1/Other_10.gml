/// @description Abrir Puerta

// LÓGICA ESPECIAL TUTORIAL - PUERTA CERRADA
if (room == rm_Trampa_Subteranea) {
    // Si la puerta está bloqueada, asegurar que se mantenga cerrada y sólida
if (room == rm_Trampa_Subteranea && x > room_width / 2) {
    if (!variable_global_exists("has_tutorial_key") || global.has_tutorial_key == false) {
        open = false;
        image_index = 0;
        solid = true;
        exit;
    }
}
}

if (!open)
{
    open = true;
    image_index = 1; // Cambiar a Frame 1 (Abierta)
    solid = false;   // Dejar pasar
    
    // Opcional: Sonido
    // audio_play_sound(snd_puerta, 10, false);
}