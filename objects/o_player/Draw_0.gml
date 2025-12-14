/// DRAW EVENT - o_player
draw_sprite(sprite_index, image_index, x, y + z);
// === ANIMACIÓN SEGÚN CONTROL Y ESTADO ===


/// @description Draw Ourselves

/*No sé de quien es esto pero para el salto no lo necesito asi que xd
depth = -bbox_bottom + z * 2;
*/
//Shadow
draw_sprite(s_playershadow, 0, x, y + zFloor);


// === DIBUJAR PERSONAJE ===
//draw_self();

// ====================================================
// === BARRAS DE STATS FLOTANTES (DEBAJO DEL JUGADOR) ===
// ====================================================
var bar_offset_y = 10; // Distancia DEBAJO del jugador
var bar_width = 80;  // Más ancho para que quepa el texto
var bar_height = 10; // Más alto para que quepa el texto
var bar_gap = 2; // Espacio entre barras
var text_scale = 0.6; // Escala del texto para que quepa mejor

// Centrar las barras horizontalmente sobre el jugador
var bar_x = x - bar_width/2;

// --- BARRA DE VIDA (primera, arriba) ---
var hp_y = y + bar_offset_y;
var hp_ratio = clamp(hp / hp_max, 0, 1);

// Fondo barra vida
draw_set_color(c_black);
draw_rectangle(bar_x - 1, hp_y - 1, bar_x + bar_width + 1, hp_y + bar_height + 1, false);

// Barra vida (roja)
draw_set_color(c_red);
draw_rectangle(bar_x, hp_y, bar_x + (bar_width * hp_ratio), hp_y + bar_height, false);

// Borde barra vida
draw_set_color(c_white);
draw_rectangle(bar_x, hp_y, bar_x + bar_width, hp_y + bar_height, true);

// Texto HP (DENTRO de la barra, centrado con borde negro)
if (font_exists(f_espanol)) draw_set_font(f_espanol);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var hp_text = string(max(0, floor(hp))) + "/" + string(hp_max);

// Borde negro (sombra) para el texto
draw_set_color(c_black);
draw_text_transformed(x - 1, hp_y + bar_height/2, hp_text, text_scale, text_scale, 0);
draw_text_transformed(x + 1, hp_y + bar_height/2, hp_text, text_scale, text_scale, 0);
draw_text_transformed(x, hp_y + bar_height/2 - 1, hp_text, text_scale, text_scale, 0);
draw_text_transformed(x, hp_y + bar_height/2 + 1, hp_text, text_scale, text_scale, 0);

// Texto blanco encima
draw_set_color(c_white);
draw_text_transformed(x, hp_y + bar_height/2, hp_text, text_scale, text_scale, 0);

// --- BARRA DE MANÁ (debajo de vida) ---
var mana_y = hp_y + bar_height + bar_gap;
var mana_ratio = clamp(mana / mana_max, 0, 1);

// Fondo barra maná
draw_set_color(c_black);
draw_rectangle(bar_x - 1, mana_y - 1, bar_x + bar_width + 1, mana_y + bar_height + 1, false);

// Barra maná (azul)
draw_set_color(c_aqua);
draw_rectangle(bar_x, mana_y, bar_x + (bar_width * mana_ratio), mana_y + bar_height, false);

// Borde barra maná
draw_set_color(c_white);
draw_rectangle(bar_x, mana_y, bar_x + bar_width, mana_y + bar_height, true);

// Texto Maná (DENTRO de la barra, centrado con borde negro)
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var mana_text = string(max(0, floor(mana))) + "/" + string(mana_max);

// Borde negro (sombra) para el texto
draw_set_color(c_black);
draw_text_transformed(x - 1, mana_y + bar_height/2, mana_text, text_scale, text_scale, 0);
draw_text_transformed(x + 1, mana_y + bar_height/2, mana_text, text_scale, text_scale, 0);
draw_text_transformed(x, mana_y + bar_height/2 - 1, mana_text, text_scale, text_scale, 0);
draw_text_transformed(x, mana_y + bar_height/2 + 1, mana_text, text_scale, text_scale, 0);

// Texto blanco encima
draw_set_color(c_white);
draw_text_transformed(x, mana_y + bar_height/2, mana_text, text_scale, text_scale, 0);

// --- BARRA DE ESTAMINA (a la izquierda, centrada verticalmente) ---
var stamina_bar_width = 6; // Barra vertical delgada
var stamina_bar_height = (bar_height * 2) + bar_gap; // Misma altura total que HP+Mana
var stamina_x = bar_x - 10; // A la izquierda de las barras principales
var stamina_y = hp_y; // Empieza al mismo nivel que HP
var stamina_ratio = clamp(stamina / stamina_max, 0, 1);

// Fondo barra estamina (vertical)
draw_set_color(c_black);
draw_rectangle(stamina_x - 1, stamina_y - 1, stamina_x + stamina_bar_width + 1, stamina_y + stamina_bar_height + 1, false);

// Barra estamina (verde, se llena de abajo hacia arriba)
draw_set_color(c_lime);
var stamina_fill_height = stamina_bar_height * stamina_ratio;
draw_rectangle(stamina_x, stamina_y + stamina_bar_height - stamina_fill_height, 
               stamina_x + stamina_bar_width, stamina_y + stamina_bar_height, false);

// Borde barra estamina
draw_set_color(c_white);
draw_rectangle(stamina_x, stamina_y, stamina_x + stamina_bar_width, stamina_y + stamina_bar_height, true);

// Reset drawing settings
draw_set_font(-1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);



// === INDICADOR DE INTERACCIÓN ===
if (can_interact)
{
    var _radius = 64; // Aumentado a 64
    var _nearby_obj = collision_circle(x, y, _radius, o_interactable, false, true);
    
    if (_nearby_obj != noone)
    {
        // Dibujar tecla E encima del jugador
        if (sprite_exists(s_keyboard_E))
        {
            draw_sprite(s_keyboard_E, 0, x, y - 40);
        }
    }
}


// ====================================================
// === EFECTO DE DESVANECER (FADE OUT / REAPARECER) ===
// ====================================================
if (is_fading)
{
    fade_alpha += 0.03;
    if (fade_alpha > 1) fade_alpha = 1;

    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
    draw_set_color(c_white);

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

        // Restaurar stats
        hp = hp_max;
        stamina = stamina_max;
        mana = mana_max;
        dead = 0;
        can_move = true;
        state = "idle";

        show_debug_message("Jugador reaparecido correctamente.");
    }
}

// ==========================================
// DRAW UI (NIVEL Y MENU)
// ==========================================
// Usar coordenadas de vista para que el menú siga a la cámara
var cx = camera_get_view_x(view_camera[0]);
var cy = camera_get_view_y(view_camera[0]);
var cw = camera_get_view_width(view_camera[0]);
var ch = camera_get_view_height(view_camera[0]);

if (variable_global_exists("font_custom")) draw_set_font(global.font_custom); // Probar fallback si existe
else if (font_exists(f_espanol)) draw_set_font(f_espanol);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// LEVEL UP MESSAGE
if (level_up_timer > 0)
{
    // Efecto de parpadeo
    if (level_up_timer % 20 < 10) draw_set_color(c_yellow); else draw_set_color(c_white);
    
    // Dibujar texto con borde negro para legibilidad
    var msg = level_up_message;
    draw_set_color(c_black);
    draw_text_transformed(cx + cw/2 + 2, cy + ch*0.15 + 2, msg, 1.2, 1.2, 0);
    
    if (level_up_timer % 20 < 10) draw_set_color(c_yellow); else draw_set_color(c_white);
    draw_text_transformed(cx + cw/2, cy + ch*0.15, msg, 1.2, 1.2, 0);
    
    draw_set_color(c_white);
}

// ATTRIBUTE MENU
if (menu_open)
{
    // Background Overlay
    draw_set_alpha(0.8);
    draw_set_color(c_black);
    draw_roundrect(cx + cw*0.2, cy + ch*0.2, cx + cw*0.8, cy + ch*0.8, false);
    draw_set_alpha(1);
    
    // Panel Border
    draw_set_color(c_white);
    draw_roundrect(cx + cw*0.2, cy + ch*0.2, cx + cw*0.8, cy + ch*0.8, true);
    
    // Title
    draw_set_color(c_yellow);
    draw_text_transformed(cx + cw/2, cy + ch*0.28, "=== ATRIBUTOS ===", 1.2, 1.2, 0);
    
    // Stats List
    var start_y = cy + ch*0.4;
    var step_y = 35; // Espaciado vertical
    
    for (var i = 0; i < array_length(menu_options); i++)
    {
        var txt = menu_options[i] + ": ";
        var val = 0;
        switch(i) {
            case 0: val = attr_int; break;
            case 1: val = attr_str; break;
            case 2: val = attr_spd; break;
            case 3: val = attr_vit; break;
        }
        
        var color = c_white;
        var prefix = "";
        
        if (menu_selected == i) {
            color = c_aqua; // Color de selección
            prefix = ">> ";
            
            // Dibujar rectángulo de selección
            draw_set_alpha(0.3);
            draw_set_color(c_white);
            draw_rectangle(cx + cw*0.3, start_y + (i * step_y) - 15, cx + cw*0.7, start_y + (i * step_y) + 15, false);
            draw_set_alpha(1);
        }
        
        draw_set_color(color);
        draw_text(cx + cw/2, start_y + (i * step_y), prefix + txt + string(val));
    }
    
    // Available Points
    if (attr_points > 0) draw_set_color(c_lime); else draw_set_color(c_gray);
    draw_text(cx + cw/2, start_y + (4.5 * step_y), "Puntos disponibles: " + string(attr_points));
    
    // Instructions
    draw_set_color(c_ltgray);
    draw_text_transformed(cx + cw/2, cy + ch*0.75, "Mover: [Flechas] | Asignar: [Enter] | Cerrar: [Esc]", 0.8, 0.8, 0);
}

// Reset defaults
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white)

