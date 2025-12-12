/// STEP EVENT de o_story_controller

//Aquí se manejan: cinemáticas pendientes, auto_triggers y atajos debug opcionales

story_tick++;

// 1️⃣ Manejo de cinemáticas en curso
if (global.story_in_cinematic) {
    if (is_undefined(global.story_current_cinematic) || global.story_current_cinematic == noone) {
        global.story_in_cinematic = false;
    } else {
        // Convención: la función de cinemática devuelve true cuando terminó
        var finished = global.story_current_cinematic();
        if (finished) {
            global.story_in_cinematic = false;
            global.story_current_cinematic = noone;
        }
    }
    exit; // mientras hay cinemática, no procesamos triggers
}

// 2️⃣ Si no hay cinemática, ¿hay algo en la cola?
if (!ds_queue_is_empty(global.story_cinematic_queue)) {
    global.story_current_cinematic = ds_queue_dequeue(global.story_cinematic_queue);
    global.story_in_cinematic      = true;
    exit;
}

// 3️⃣ Auto-triggers (zonas, condiciones de historia, etc.)
story_auto_trigger_cooldown--;
if (story_auto_trigger_cooldown <= 0) {
    story_auto_trigger_cooldown = 5; // por ejemplo, cada 5 steps

    var _list = global.story_auto_triggers;
    var _count = ds_list_size(_list);

    for (var i = 0; i < _count; i++) {
        var t = _list[| i]; // struct

        if (t.once && t.fired) {
            continue;
        }

        if (t.condition()) { // si la condición se cumple
            t.action();
            if (t.once) t.fired = true;
        }
    }
}

// 4️⃣ Debug (opcional)
if (story_debug) {
    if (keyboard_check_pressed(ord("F"))) {
        show_debug_message("Story phase: " + string(global.story_phase));
    }
}
