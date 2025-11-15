// Actualizar timer
timer += 1;

switch (global.prologo_phase) {

    // --------------------------------------------------------
    // FASE 0 – Narrativa inicial (texto automático)
    // --------------------------------------------------------
    case 0:
        if (timer > room_speed * 6) {
            timer = 0;
            global.prologo_phase = 1;
        }
    break;


    // --------------------------------------------------------
    // FASE 1 – Diálogos Elfo + Gato Robot
    // --------------------------------------------------------
    case 1:
        if (!global.dialogue_active)
            scr_dialogo("Elfo", "¿Estás seguro de que es aquí?");
        global.prologo_phase = 1.1;
        timer = 0;
    break;

    case 1.1:
        if (global.dialogo_terminado) {
            scr_dialogo("Gato Robot", "Sí. El mapa marca este punto exacto.");
            global.prologo_phase = 1.2;
        }
    break;

    case 1.2:
        if (global.dialogo_terminado) {
            scr_dialogo("Elfo", "No me gusta. Esto parece una tumba.");
            global.prologo_phase = 1.3;
        }
    break;

    case 1.3:
        if (global.dialogo_terminado) {
            scr_dialogo("Gato Robot", "Debajo hay una cámara sellada. Debe ser lo que buscamos.");
            global.prologo_phase = 1.4;
        }
    break;

    case 1.4:
        if (global.dialogo_terminado) {
            scr_dialogo("Elfo", "Buscar poder nunca ha sido buena idea...");
            global.prologo_phase = 1.5;
        }
    break;

    case 1.5:
        if (global.dialogo_terminado) {
            scr_dialogo("Gato Robot", "El poder está aquí. ¿Lo sientes?");
            global.prologo_phase = 1.6;
        }
    break;

    case 1.6:
        if (global.dialogo_terminado) {
            scr_dialogo("Elfo", "Sí... me está llamando.");
            global.prologo_phase = 2;
            timer = 0;
        }
    break;



    // --------------------------------------------------------
    // FASE 2 – Elfo llega al pedestal
    // --------------------------------------------------------
    case 2:
        if (!global.dialogue_active) {
            scr_dialogo("Elfo", "Finalmente...");
            global.prologo_phase = 3;
        }
    break;


    // --------------------------------------------------------
    // FASE 3 – Aparición del Guardián
    // --------------------------------------------------------
    case 3:
        if (global.dialogo_terminado) {
            scr_dialogo("???", "Detente.");
            global.prologo_phase = 4;
        }
    break;


    // --------------------------------------------------------
    // FASE 4 – Confrontación filosófica
    // --------------------------------------------------------
    case 4:
        if (global.dialogo_terminado) {
            scr_dialogo("Guardián", "No eres digno.");
            global.prologo_phase = 4.1;
        }
    break;

    case 4.1:
        if (global.dialogo_terminado) {
            scr_dialogo("Elfo", "Me pertenece por fuerza.");
            global.prologo_phase = 4.2;
        }
    break;

    case 4.2:
        if (global.dialogo_terminado) {
            scr_dialogo("Guardián", "Hablas como los que perdieron el mundo.");
            global.prologo_phase = 4.3;
        }
    break;

    case 4.3:
        if (global.dialogo_terminado) {
            scr_dialogo("Elfo", "La historia la escriben los fuertes.");
            global.prologo_phase = 4.4;
        }
    break;

    case 4.4:
        if (global.dialogo_terminado) {
            scr_dialogo("Guardián", "La custodian los humildes.");
            global.prologo_phase = 4.5;
        }
    break;

    case 4.5:
        if (global.dialogo_terminado) {
            scr_dialogo("Guardián", "Última advertencia.");
            global.prologo_phase = 4.6;
        }
    break;

    case 4.6:
        if (global.dialogo_terminado) {
            scr_dialogo("Elfo", "¡Este poder será mío!");
            global.prologo_phase = 5;
        }
    break;



    // --------------------------------------------------------
    // FASE 5 – Activar portal y absorber a los dos
    // --------------------------------------------------------
    case 5:
        instance_create_layer(
            o_elfo_cinematica.x,
            o_elfo_cinematica.y,
            "Instances",
            o_portal
        );

        global.prologo_phase = 6;
        timer = 0;
    break;



    // --------------------------------------------------------
    // FASE 6 – Sentencia final
    // --------------------------------------------------------
    case 6:
        if (!global.dialogue_active)
            scr_dialogo("Guardián", "Irás al pasado. Aprende, o sé quebrado.");
        global.prologo_phase = 6.1;
    break;

    case 6.1:
        if (global.dialogo_terminado) {
            scr_dialogo("Elfo", "¡NO decidirás por mí!");
            global.prologo_phase = 7;
            timer = 0;
        }
    break;


    // --------------------------------------------------------
    // FASE 7 – Absorción final y fundido
    // --------------------------------------------------------
    case 7:
        if (timer > room_speed * 2) {
            instance_create_layer(0, 0, "GUI", o_fundido_blanco);
        }
        if (timer > room_speed * 4) {
            //room_goto(rm_pradera);
            global.prologo_phase = 8;
            timer = 0;
        }
    break;


    // --------------------------------------------------------
    // FASE 8 – Cinemática 1
    // --------------------------------------------------------
    case 8:
        if (keyboard_check_pressed(vk_space) || timer > room_speed * 10) {
            global.prologo_phase = 9;
            timer = 0;
        }
    break;


    // --------------------------------------------------------
    // FASE 9 – Cinemática 2
    // --------------------------------------------------------
    case 9:
        if (keyboard_check_pressed(vk_space) || timer > room_speed * 10) {
            global.prologo_phase = 10;
            timer = 0;
			
        }
    break;


    // --------------------------------------------------------
    // FASE 10 – Empieza el juego
    // --------------------------------------------------------
    case 10:
        var spawn = instance_find(o_spawn_player, 0);
		instance_create_layer(spawn.x, spawn.y, "Instances", o_player);

        global.story_phase = 1;
        instance_destroy();
    break;
}
