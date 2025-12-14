// --------------------------------------------
// 1) NO HAGAS NADA SI EL PRÓLOGO NO ESTÁ ACTIVO
// --------------------------------------------

// LIMPIEZA AUTOMÁTICA: Si el prólogo terminó y NO estamos en rm_prologo,
// el manager debe destruirse para evitar bugs visuales en otras salas.
if (global.prologo_block == 0 && room != rm_Entrada_Exterior) {
    show_debug_message(">>> o_prologo_manager: Prólogo terminado, destruyéndose en " + room_get_name(room));
    instance_destroy();
    exit;
}

// SEGURIDAD: Si estamos en rm_pradera, ejecutar lógica de spawn y destruirse.
// Esto corrige el problema de bloqueo/pantalla negra si el evento Room Start falla.
if (room == rm_pradera) {
    show_debug_message(">>> o_prologo_manager: Detectado rm_pradera en STEP.");

    // 1. Crear Player si no existe
    if (!instance_exists(o_player)) {
         var spawn_x = 175; 
         var spawn_y = 350;
         instance_create_layer(spawn_x, spawn_y, "Instances", o_player);
         show_debug_message(">>> o_prologo_manager: Player CREADO (fallback) en " + string(spawn_x) + "," + string(spawn_y));
    }

    // 2. Asegurar o_wake_up (si no existe)
    if (!instance_exists(o_wake_up)) {
        instance_create_layer(0, 0, "Instances", o_wake_up);
        show_debug_message(">>> o_prologo_manager: o_wake_up CREADO (fallback).");
    }

    // 3. Reset flag
    if (variable_global_exists("from_prologue")) {
        global.from_prologue = false;
    }

    // 4. DESTRUIR PARA QUITAR PANTALLA NEGRA
    instance_destroy();
    exit;
}

if (global.prologo_block == 0) exit;

timer += 1;


switch (global.prologo_block) { 

    
    // ---------------------------------------------------------------
    // BLOQUE 1 → Llegada a las Catacumbas (Trigger 1)
    // ---------------------------------------------------------------
    case 1:

        switch (global.prologo_phase) {

            case -1:
                global.prologo_phase = 1;
            break;

            case 1:
                if (!global.dialogue_active) {
                    scr_dialogo("Elfo", "¿Estás seguro de que es aquí?");
                    global.prologo_phase = 1.1;
                    timer = 0;
                }
            break;

            case 1.1:
                if (global.dialogo_terminado) {
                    scr_dialogo("Gato Robot", "Sí. El mapa marca este punto exacto. Las coordenadas no mienten.");
                    global.prologo_phase = 999; // FIN DE BLOQUE 1
                }
            break;

            case 999:
                // Esperando Trigger 2
            break;
        }
    break;



    // ---------------------------------------------------------------
    // BLOQUE 2 → Exploración y Poder (Trigger 2)
    // ---------------------------------------------------------------
    case 2:

        switch (global.prologo_phase) {

            case -1:
                global.prologo_phase = 2;
            break;

            case 2:
                if (!global.dialogue_active) {
                    scr_dialogo("Elfo", "No me gusta. Esto parece más una tumba que un santuario.");
                    global.prologo_phase = 2.1;
                }
            break;

            case 2.1:
                if (global.dialogo_terminado) {
                    scr_dialogo("Gato Robot", "Los registros decían 'catacumbas antiguas'. Pero debajo hay una cámara sellada. Debe ser lo que buscamos.");
                    global.prologo_phase = 2.2;
                }
            break;

            case 2.2:
                if (global.dialogo_terminado) {
                    scr_dialogo("Elfo", "No sé si buscar poder en las entrañas del mundo sea buena idea… aunque eso nunca me ha detenido.");
                    global.prologo_phase = 2.3;
                }
            break;

            case 2.3:
                if (global.dialogo_terminado) {
                    scr_dialogo("Gato Robot", "El poder está aquí. Lo sientes, ¿verdad?");
                    global.prologo_phase = 2.4;
                }
            break;

            case 2.4:
                if (global.dialogo_terminado) {
                    scr_dialogo("Elfo", "Sí… y me está llamando.");
                    global.prologo_phase = 1999; // FIN DE BLOQUE 2
                }
            break;

            case 1999:
                // Esperando Trigger 3
            break;
        }
    break;



    // ---------------------------------------------------------------
    // BLOQUE 3 → Confrontación con el Guardián (Trigger 3)
    // ---------------------------------------------------------------
    case 3:

        switch (global.prologo_phase) {

            case -1:
                global.prologo_phase = 101;
            break;

            case 101:
                if (!global.dialogue_active) {
                    scr_dialogo("Elfo", "Finalmente…");
                    global.prologo_phase = 102;
                }
            break;

            case 102:
                if (global.dialogo_terminado) {
                    scr_dialogo("Voz", "Detente.");
                    global.prologo_phase = 103;
                }
            break;

            case 103:
                if (global.dialogo_terminado) {
                    scr_dialogo("El Guardián", "No eres digno.");
                    global.prologo_phase = 104;
                }
            break;

            case 104:
                if (global.dialogo_terminado) {
                    scr_dialogo("El Elfo", "No me importa tu juicio. He venido a reclamar lo que me pertenece por derecho de fuerza.");
                    global.prologo_phase = 105;
                }
            break;

            case 105:
                if (global.dialogo_terminado) {
                    scr_dialogo("El Guardián", "Hablas como aquellos que olvidaron su raíz. Desconoces la historia y, por ello, estás condenado a repetirla.");
                    global.prologo_phase = 106;
                }
            break;

            case 106:
                if (global.dialogo_terminado) {
                    scr_dialogo("El Elfo", "La historia la escriben los fuertes.");
                    global.prologo_phase = 107;
                }
            break;

            case 107:
                if (global.dialogo_terminado) {
                    scr_dialogo("El Guardián", "La historia la custodian los humildes.");
                    global.prologo_phase = 108;
                }
            break;

            case 108:
                if (global.dialogo_terminado) {
                    scr_dialogo("El Guardián", "Te advierto por última vez: no eres digno. Tus pasos han hollado la senda de los que perdieron al mundo.");
                    global.prologo_phase = 109;
                }
            break;

            case 109:
                if (global.dialogo_terminado) {
                    scr_dialogo("El Elfo", "¡No me detendrás con tus advertencias antiguas! ¡Este poder será mío!");
                    global.prologo_phase = 110;
                }
            break;

            case 110:
                if (global.dialogo_terminado) {
                    scr_dialogo("El Guardián", "Si ansías tanto poder, gánatelo donde nació su precio.");
                    global.prologo_phase = 111;
                }
            break;

            case 111:
                if (global.dialogo_terminado) {
                    scr_dialogo("El Guardián", "Irás al pasado a mirar a tus antepasados sin filtros ni glorias.");
                    global.prologo_phase = 112;
                }
            break;

            case 112:
                if (global.dialogo_terminado) {
                    scr_dialogo("El Guardián", "Solo si vences al Demonio Ancestral —el que quebró el curso del mundo y selló la extinción humana— podrás volver.");
                    global.prologo_phase = 113;
                }
            break;

            case 113:
                if (global.dialogo_terminado) {
                    scr_dialogo("El Guardián", "Aprende… o sé quebrado.");
                    global.prologo_phase = 114;
                }
            break;

            case 114:
                if (global.dialogo_terminado) {
                    scr_dialogo("El Elfo", "¡No me enviarás a ningún lado! ¡Ni tú ni nadie decidirán por mí!");
                    global.prologo_phase = 115;
                }
            break;

            case 115:
                if (global.dialogo_terminado) {
                    scr_dialogo("Narrador", "Corrió hacia el Guardián, atravesando el aire distorsionado. Pero en cuanto su puño casi tocó su figura, un remolino de energía se formó a su alrededor.");
                    global.prologo_phase = 116;
                }
            break;

            case 116:
                if (global.dialogo_terminado) {
                    scr_dialogo("Gato Robot", "¡Energía inestable detectada! ¡Campo temporal en expansión!");
                    global.prologo_phase = 117;
                }
            break;

            case 117:
                if (global.dialogo_terminado) {
                    scr_dialogo("El Elfo", "¡Detente, maldito! ¡Detente!");
                    global.prologo_phase = 118;
                }
            break;

            case 118:
                if (global.dialogo_terminado) {
                    scr_dialogo("El Guardián", "Tu destino no es detenerte. Es comprender.");
                    global.prologo_phase = 9999; // FIN DEL PRÓLOGO COMPLETO
                }
            break;

            case 9999:
                // Secuencia cinemática completa
                if (!variable_instance_exists(id, "cinematic_timer")) {
                    cinematic_timer = 0;
                    cinematic_alpha = 0;
                    cinematic_phase = 1; // 1=cinematica1, 2=cinematica2, 3=fade
                    
                    // Congelar al jugador durante la cinemática
                    if (instance_exists(o_player)) {
                        o_player.can_move = false;
                    }
                }
                
                cinematic_timer++;
                
                // FASE 1: Mostrar s_cinematica1 (3 segundos = 180 frames)
                if (cinematic_timer <= 180) {
                    cinematic_phase = 1;
                }
                // FASE 2: Mostrar s_cinematica2 (3 segundos = 180 frames)
                else if (cinematic_timer <= 360) {
                    cinematic_phase = 2;
                }
                // FASE 3: Fade to black (2 segundos = 120 frames)
                else if (cinematic_timer <= 480) {
                    cinematic_phase = 3;
                    // Calcular alpha progresivo
                    cinematic_alpha = (cinematic_timer - 360) / 120;
                }
                // FASE 4: Transición a rm_pradera
                else if (cinematic_timer == 481) {
                    global.from_prologue = true; // PRIMERO establece el flag
                    room_goto(rm_pradera);       // LUEGO cambia de room
                }
            break;
        }
    break;

}
