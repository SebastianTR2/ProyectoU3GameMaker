/// scr_cinematic_prologo()

//7. Sistema de cinemáticas  Convención: Cada cinemática es una función que:
// controla: fade in/out , cámara , posición de personajes , bloqueo de input , diálogos
//devuelve true cuando termina, false mientras sigue.

function scr_cinematic_prologo() {

    // Podemos usar estados internos estáticos
    static _step = 0;

    switch (_step) {
        case 0:
            // Bloquear controles
            global.player_can_move = false;

            // Iniciar fade in desde negro
            scr_fx_fade_in(0.02); // (tú implementas este helper)

            _step++;
            break;

        case 1:
            if (scr_fx_is_fade_done()) {
                // posicionar player, NPCs, cámara...
                with (o_player) {
                    x = 100; y = 200;
                }
                // Lanzar primer diálogo automático
                // scr_dialog_start("prologo_01");
                _step++;
            }
            break;

        case 2:
            // Esperar a que termine el diálogo
            if (!global.dialog_active) {
                // Update historia
                global.story_phase = 10; // por ejemplo, DESPERTAR
                scr_start_mission("M_prologo");

                // Desbloquear controles
                global.player_can_move = true;

                // Reset interno para la próxima vez
                _step = 0;
                return true; // cinemática terminó
            }
            break;
    }

    return false; // sigue en ejecución
}


//7.2 Arranque de una cinemática  Desde cualquier parte del juego:

// Ejemplo: al entrar en la pradera inicial
//ds_queue_enqueue(global.story_cinematic_queue, scr_cinematic_prologo);