/// @description Draw Interaction Prompt

// Solo mostrar si el jugador está cerca
if (player_near) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(c_white);
    draw_set_font(f_espanol); // Asegúrate de tener una fuente asignada
    
    // Dibujar texto encima del jugador o de la puerta
    var _txt = "Presiona E";
    
    // DEBUG: Mostrar info de la puerta
    if (global.debug_mode == true || true) { // Forzar debug por ahora
        if (room == rm_Trampa_Subteranea) {
            if (x > room_width/2) _txt += "\n[LOCKED DOOR (Right)]\nKey: " + string(global.has_tutorial_key);
            else _txt += "\n[EXIT DOOR (Left)]\nAuto-Transition";
        }
    }

    // Dibujar bg semitransparente para leer mejor
    var _w = string_width(_txt) + 10;
    var _h = string_height(_txt) + 5;
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(x - _w/2, y - 60 - _h, x + _w/2, y - 60, false);
    draw_set_alpha(1);
    
    draw_set_color(c_white);
    draw_text(x, y - 60, _txt);
    
    // Resetear configuración de dibujo
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_set_alpha(1);
}
