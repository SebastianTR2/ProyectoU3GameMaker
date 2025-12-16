/// @description Pick Up Key
global.has_tutorial_key = true;

// Asegurar que o_chat existe antes de encolar mensajes
if (!instance_exists(o_chat)) {
    instance_create_depth(0, 0, -9999, o_chat);
}

ds_queue_enqueue(global.list_chat, "¡Has encontrado la Llave Antigua!");
ds_queue_enqueue(global.list_chat, "Ahora puedes abrir la puerta de la derecha.");

// Efecto de sonido (opcional)
// audio_play_sound(snd_key, 10, false);

instance_destroy();

