// --------------------------------------------
// 1) NO HAGAS NADA SI EL PRÓLOGO NO ESTÁ ACTIVO
// --------------------------------------------
if (global.prologo_block == 0) exit;

timer += 1;


// =====================================================================
// 2) CONTROL POR BLOQUES - cada trigger activa uno de estos bloques
// =====================================================================
switch (global.prologo_block) {

    
    // ---------------------------------------------------------------
    // BLOQUE 1 → fase 1 a 1.1   (Elfo + Gato Robot diálogo inicial)
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
                    scr_dialogo("Gato Robot", "Sí. El mapa marca este punto exacto.");
                    global.prologo_phase = 999; // FIN DE BLOQUE
                }
            break;

            case 999:
                // esperamos trigger 2
            break;
        }
    break;



    // ---------------------------------------------------------------
    // BLOQUE 2 → fase 1.2 a 1.6  (Elfo siente el poder)
    // ---------------------------------------------------------------
    case 2:

        switch (global.prologo_phase) {

            case 999:
                global.prologo_phase = 1.2;
            break;

            case 1.2:
                if (global.dialogo_terminado) {
                    scr_dialogo("Elfo", "No me gusta. Esto parece una tumba.");
                    global.prologo_phase = 1.3;
                }
            break;

            case 1.3:
                if (global.dialogo_terminado) {
                    scr_dialogo("Gato Robot", "Debajo hay una cámara sellada.");
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
                    global.prologo_phase = 1999; // FIN DE BLOQUE 2
                }
            break;

            case 1999:
                // Espera Trigger 3
            break;
        }
    break;



    // ---------------------------------------------------------------
    // BLOQUE 3 → fase 2 a 10 (Guardián → portal → cinemáticas)
    // ---------------------------------------------------------------
    // --------------------------------------------
// 1) NO HAGAS NADA SI EL PRÓLOGO NO ESTÁ ACTIVO
// --------------------------------------------
if (global.prologo_block == 0) exit;

timer += 1;


// =====================================================================
// 2) CONTROL POR BLOQUES - cada trigger activa uno de estos bloques
// =====================================================================
switch (global.prologo_block) {

    
    // ---------------------------------------------------------------
    // BLOQUE 1 → fase 1 a 1.1   (Elfo + Gato Robot diálogo inicial)
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
                    scr_dialogo("Gato Robot", "Sí. El mapa marca este punto exacto.");
                    global.prologo_phase = 999; // FIN DE BLOQUE
                }
            break;

            case 999:
                // esperamos trigger 2
            break;
        }
    break;



    // ---------------------------------------------------------------
    // BLOQUE 2 → fase 1.2 a 1.6  (Elfo siente el poder)
    // ---------------------------------------------------------------
    case 2:

        switch (global.prologo_phase) {

            case 999:
                global.prologo_phase = 1.2;
            break;

            case 1.2:
                if (global.dialogo_terminado) {
                    scr_dialogo("Elfo", "No me gusta. Esto parece una tumba.");
                    global.prologo_phase = 1.3;
                }
            break;

            case 1.3:
                if (global.dialogo_terminado) {
                    scr_dialogo("Gato Robot", "Debajo hay una cámara sellada.");
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
                    global.prologo_phase = 1999; // FIN DE BLOQUE 2
                }
            break;

            case 1999:
                // Espera Trigger 3
            break;
        }
    break;



    // ---------------------------------------------------------------
    // BLOQUE 3 → fase 2 a 10 (Guardián → portal → cinemáticas)
    // ---------------------------------------------------------------
    case 3:

        switch (global.prologo_phase) {

            case 1999:
                global.prologo_phase = 2;
            break;

            // Aquí va TODO tu switch ORIGINAL desde case 2 hasta 10
            // (lo pegamos aquí sin modificar)
            // ...
        }
    break;

}


}
