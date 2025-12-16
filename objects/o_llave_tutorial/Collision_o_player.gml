/// @description Pick Up Key
global.has_tutorial_key = true;
ds_queue_enqueue(global.list_chat, "¡Has encontrado la Llave Antigua!");
ds_queue_enqueue(global.list_chat, "Ahora puedes abrir la puerta de la derecha.");

// Efecto de sonido (opcional)
// audio_play_sound(snd_key, 10, false);

instance_destroy();
