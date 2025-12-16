function scr_tutorial_dialogue(_step) {
    if (!variable_global_exists("list_chat")) {
        global.list_chat = ds_queue_create();
    }

    // Limpiar cola para iniciar nuevo set de diálogos
    ds_queue_clear(global.list_chat);

    // Configurar estado
    global.dialogue_active = true;
    global.dialogo_terminado = false;
    global.game_paused = true;

    if (_step == 0) {
        // INTRODUCCION Y ATAQUE
        ds_queue_enqueue(global.list_chat, "Tutorial: ¡Hola, valiente aventurero! Bienvenido a las profundidades.");
        ds_queue_enqueue(global.list_chat, "Tutorial: No temas, estoy aqui para guiarte en tus primeros pasos.");
        ds_queue_enqueue(global.list_chat, "Tutorial: Antes de enfrentarte a los peligros, aprendamos a defendernos.");
        
        ds_queue_enqueue(global.list_chat, "Tutorial: Para atacar con tu arma, presiona la tecla J o haz CLICK IZQUIERDO.");
        ds_queue_enqueue(global.list_chat, "Tutorial: Si prefieres las artes arcanas, usa la tecla M para lanzar magia (ojo con tu Mana).");
        ds_queue_enqueue(global.list_chat, "Tutorial: Ahora, ¡demuestra tu valor! Presiona ENTER y derrota a los enemigos.");
    }
    else if (_step == 1) {
        // EXPERIENCIA Y ATRIBUTOS
        ds_queue_enqueue(global.list_chat, "Tutorial: ¡Magnifico! Veo que tienes talento para el combate.");
        ds_queue_enqueue(global.list_chat, "Tutorial: Esa energia que sientes es la Experiencia fluyendo en ti.");
        
        ds_queue_enqueue(global.list_chat, "Tutorial: Cuando quieras fortalecerte, presiona C para abrir tu menu de atributos.");
        ds_queue_enqueue(global.list_chat, "Tutorial: El tiempo se detendra mientras asignas tus puntos.");
        ds_queue_enqueue(global.list_chat, "Tutorial: ¡Mucha suerte en tu viaje, heroe!");
    }

    // Crear o_chat
    if (instance_exists(o_chat)) {
        with (o_chat) instance_destroy();
    }
    instance_create_layer(0, 0, "GUI", o_chat);
}
