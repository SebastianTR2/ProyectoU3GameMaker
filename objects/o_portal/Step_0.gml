// FASE 1: Animación normal del portal
if (!absorbiendo) {
    if (image_index >= image_number - 1) {
        absorbiendo = true;
        image_index = 0;
        image_speed = 0.5;
    }
}

// FASE 2: Absorción
if (absorbiendo) {

    // Escalar para cubrir pantalla
    image_xscale += 0.05;
    image_yscale += 0.05;

    // Absorber ELFO
    if (instance_exists(o_elfo_cinematica)) {
        o_elfo_cinematica.x = lerp(o_elfo_cinematica.x, x, 0.1);
        o_elfo_cinematica.y = lerp(o_elfo_cinematica.y, y, 0.1);
        o_elfo_cinematica.image_alpha -= 0.03;
    }

    // Absorber GATO (o_npc_mika)
    if (instance_exists(o_npc_mika)) {
        o_npc_mika.x = lerp(o_npc_mika.x, x, 0.1);
        o_npc_mika.y = lerp(o_npc_mika.y, y, 0.1);
        o_npc_mika.image_alpha -= 0.03;
    }

    // Cuando cubra la pantalla → cambiar a pradera
    if (image_xscale > 15) {
        room_goto(rm_pradera);
    }
}
