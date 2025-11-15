/// STEP EVENT — o_npc_base
/// Detecta proximidad del jugador y activa el diálogo

// Buscar y actualizar referencia constantemente (seguro contra room_goto)
if (!instance_exists(player_ref)) {
    if (instance_exists(o_player)) {
        player_ref = instance_nearest(x, y, o_player);
    }
} else if (!instance_exists(o_player)) {
    player_ref = noone;
}


// Si el jugador existe
if (instance_exists(player_ref)) {

    // Calcular distancia entre NPC y jugador
    var dist = point_distance(x, y, player_ref.x, player_ref.y);
    show_e = (dist <= interaction_radius);

    // Mostrar ícono de interacción y escuchar tecla E
    if (show_e && keyboard_check_pressed(ord("E"))) {

        // --- Verificar que no haya diálogo activo ni menús abiertos ---
        if (!global.dialogue_active && instance_number(o_chat) == 0 && instance_number(o_chat_decision) == 0) {

            // Registrar NPC actual y lanzar diálogo
            global.npc_talking = id;
            scr_start_npc_dialogo(dialog_id);

            dialog_played = true;
            global.dialogue_active = true;
        }
    }

} else {
    show_e = false;
}
