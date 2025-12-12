/// scr_story_register_auto_triggers()

//8. Auto-triggers y zonas
//8.1 Registro de auto-triggers

function scr_story_register_auto_triggers() {

    var list = global.story_auto_triggers;

    // Ejemplo: llegada a Ciudad Costera (solo si historia está en fase X)
    var t_ciudad = {
        id: "llegada_ciudad_costera",
        once: true,
        fired: false,

        condition: function() {
            // Debe existir o_player y o_trigger_ciudad en la room
            if (!instance_exists(o_player)) return false;
            if (!instance_exists(o_trigger_ciudad)) return false;

            var p = o_player;
            var trig = instance_nearest(p.x, p.y, o_trigger_ciudad);

            if (place_meeting(p.x, p.y, trig) && global.story_phase == 20) {
                return true;
            }
            return false;
        },

        action: function() {
            // Lanzar cinemática de llegada a ciudad
            ds_queue_enqueue(global.story_cinematic_queue, scr_cinematic_llegada_ciudad);
            // Avanzar fase
            global.story_phase = 21;
        }
    };

    ds_list_add(list, t_ciudad);

    // Aquí puedes añadir muchos más triggers (200, 300... da igual)
}

//8.2 Ejemplo directo en un objeto trigger Si prefieres algo más directo:

// STEP de un objeto o_trigger_ciudad
//if (place_meeting(x, y, o_player) && global.story_phase == 20) {
//    scr_cinematic_llegada_ciudad();
//    global.story_phase = 21;
//}

//El sistema de auto_triggers te permite tener todo en un solo lugar, sin ensuciar los objetos.