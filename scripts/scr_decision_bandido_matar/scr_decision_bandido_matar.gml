/// scr_decision_bandido_matar()

//5.4 Scripts de opciones (aplicar consecuencias)
//Ejemplo concreto: matar o perdonar al líder bandido.

function scr_decision_bandido_matar() {

    // Cambia ruta moral a "rebelde", karma quizás "caos"
    scr_route_set_moral("rebelde");
    scr_route_set_karma("caos");

    // Marca flag permanente
    ds_map_set(global.story_flags, "bandido_palacio_muerto", true);

    // Opcional: reputación temidos
    ds_map_set(global.story_flags, "reputacion", "temidos");

    // Avanza fase histórica
    global.story_phase = 30; // ejemplo: 30 = post Palacio de las Pesadillas

    // Actualiza misiones relacionadas
    scr_complete_mission("M_palacio_pesadillas");

    // Lanzar diálogo/cinemática
    // scr_cinematic_reaccion_bandido_muerto();
    ds_queue_enqueue(global.story_cinematic_queue, scr_cinematic_reaccion_bandido_muerto);
}

/// scr_decision_bandido_perdonar()
function scr_decision_bandido_perdonar() {

    scr_route_set_moral("guardian");
    scr_route_set_karma("luz");

    ds_map_set(global.story_flags, "bandido_palacio_perdonado", true);
    ds_map_set(global.story_flags, "reputacion", "admirados");

    global.story_phase = 30; // misma fase, pero otra ruta

    scr_complete_mission("M_palacio_pesadillas");

    ds_queue_enqueue(global.story_cinematic_queue, scr_cinematic_reaccion_bandido_vivo);
}
