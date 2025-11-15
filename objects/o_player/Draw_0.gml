/// DRAW EVENT - o_player

// === ANIMACIÓN SEGÚN CONTROL Y ESTADO ===
if(global.control_type=="topdown"){
    if(state=="idle"){
        switch(sprite_facing){
            case 0: sprite_index=s_playerIdle; image_xscale=1; break; // abajo
            case 1: sprite_index=s_playerIdle; image_xscale=-1; break; // izquierda
            case 2: sprite_index=s_playerIdle; image_xscale=1; break; // derecha
            case 3: sprite_index=s_playerIdle; image_xscale=1; break; // arriba
        }
    }else if(state=="walk"){
        switch(sprite_facing){
            case 0: sprite_index=s_playerWalk; image_xscale=1; break;
            case 1: sprite_index=s_playerWalk; image_xscale=-1; break;
            case 2: sprite_index=s_playerWalk; image_xscale=1; break;
            case 3: sprite_index=s_playerWalk; image_xscale=1; break;
        }
    }
}
else // === LATERAL ===
{
    if (!is_jumping)
        sprite_index = (xSpeed == 0) ? s_player : s_player;
    else
        sprite_index = s_player;
}

// === DIBUJAR PERSONAJE ===
draw_self();

// === BARRAS ===
var offset_y = -50;

// Clamp de ratios (evita valores negativos)
var hp_ratio = clamp(hp / hp_max, 0, 1);
var stamina_ratio = clamp(stamina / stamina_max, 0, 1);
var mana_ratio = clamp(mana / mana_max, 0, 1);

// Vida
draw_set_color(c_red);
draw_rectangle(x - 20, y + offset_y, x - 20 + (hp_ratio * 40), y + offset_y + 4, false);

// Stamina
draw_set_color(c_lime);
draw_rectangle(x - 20, y + offset_y + 6, x - 20 + (stamina_ratio * 40), y + offset_y + 10, false);

// Maná
draw_set_color(c_aqua);
draw_rectangle(x - 20, y + offset_y + 12, x - 20 + (mana_ratio * 40), y + offset_y + 16, false);

draw_set_color(c_white);

// === INFORMACIÓN DE NIVEL Y AFINIDAD ===
draw_text(x - 25, y + offset_y - 10, "Lv." + string(level) + " | " + string(affinity));

// === EFECTO DE DESVANECER (FADE OUT / REAPARECER) ===
if (is_fading)
{
    fade_alpha += 0.03;
    if (fade_alpha > 1) fade_alpha = 1;

    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
    draw_set_color(c_white);

    // --- Cuando el fade llega a negro ---
    if (fade_alpha >= 1)
    {
        is_fading = false;
        fade_alpha = 0;

        // Reaparecer desde checkpoint o spawn original
        if (global.player_respawn)
        {
            x = global.player_respawn_x;
            y = global.player_respawn_y;
        }
        else
        {
            x = spawn_x;
            y = spawn_y;
        }

        // Restaurar estado
        hp = hp_max;
        stamina = stamina_max;
        mana = mana_max;
        dead = 0;
        can_move = true;
        state = "idle";

        show_debug_message("Jugador reaparecido correctamente.");
    }
}
