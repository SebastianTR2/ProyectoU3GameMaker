/// scr_story_register_core_decisions()

// Sistema de decisiones 5.1 Estructura de decisión
// Cada decisión se define como un struct con: 

function scr_story_register_core_decisions() {

    // Ejemplo: Decisión en Palacio de las Pesadillas (matar o perdonar al líder bandido)

    var dec_bandido = {
        id: "bandido_palacio",
        title: "¿Qué hacer con el líder bandido?",
        options: [
            { text: "Ejecutarlo aquí mismo", script_name: "scr_decision_bandido_matar" },
            { text: "Capturarlo y entregarlo vivo", script_name: "scr_decision_bandido_perdonar" }
        ]
    };

    ds_map_set(global.story_decisions, dec_bandido.id, dec_bandido);

    // Puedes registrar muchas más aquí...
}
