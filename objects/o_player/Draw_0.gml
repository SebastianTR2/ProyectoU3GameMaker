/// DRAW EVENT - o_player
draw_sprite(sprite_index, image_index, x, y + z);;
// === ANIMACIÓN SEGÚN CONTROL Y ESTADO ===


/// @description Draw Ourselves

/*No sé de quien es esto pero para el salto no lo necesito asi que xd
depth = -bbox_bottom + z * 2;
*/
//Shadow
draw_sprite(s_playershadow, 0, x, y + zFloor);


// === DIBUJAR PERSONAJE ===
//draw_self();

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

