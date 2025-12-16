/// DRAW GUI EVENT - o_chat
if (!variable_instance_exists(id, "chat") || is_undefined(chat)) exit;

// --- CONFIGURACIÓN DEL CUADRO (4K COMPATIBLE) ---
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var box_h = gui_h * 0.25;  // 25% de la altura
var margin_x = gui_w * 0.05; // 5% de margen lateral
var margin_y = gui_h * 0.05; // 5% margen inferior

var box_y = gui_h - box_h - margin_y; 

// --- DIBUJAR EL SPRITE DEL CUADRO ---
if (sprite_exists(s_cuadro_Dialogo_Prueba)) {
    var spr_w = sprite_get_width(s_cuadro_Dialogo_Prueba);
    var spr_h = sprite_get_height(s_cuadro_Dialogo_Prueba);
    
    // Escalar para llenar ancho menos márgenes
    var scale_x = (gui_w - (margin_x * 2)) / spr_w;
    var scale_y = box_h / spr_h;
    
    draw_sprite_ext(s_cuadro_Dialogo_Prueba, 0, margin_x, box_y, scale_x, scale_y, 0, c_white, 1);
} else {
    // Fondo alternativo
    draw_set_color(make_color_rgb(20, 20, 30));
    draw_rectangle(margin_x, box_y, gui_w - margin_x, gui_h - margin_y, false);
}

// --- CONFIGURAR FUENTE Y COLOR ---
// Usamos una escala de texto grande (4x) para la resolución alta (5600x2800)
var text_scale = 4;
if (gui_w < 2000) text_scale = 1; // Fallback para resoluciones bajas

draw_set_font(f_espanol); 
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// --- TEXTO DEL DIÁLOGO ---
var text_w = (gui_w - (margin_x * 3)); // Ancho total disponible
var text_x = margin_x * 1.5;           
var text_y = box_y + 60;   // Padding superior AUMENTADO para dejar espacio al título

// Ajustar separación y ancho relativo a la escala
var sep = 35 * text_scale; 
// IMPORTANTE: draw_text_ext_transformed el ancho límite ('w') es en píxeles reales de pantalla
var wrap_w = text_w; 

// Sombra
draw_set_color(c_black);
draw_text_ext_transformed(text_x + 3*text_scale, text_y + 3*text_scale, chat, sep, wrap_w, text_scale, text_scale, 0);

// Texto
draw_set_color(c_white);
draw_text_ext_transformed(text_x, text_y, chat, sep, wrap_w, text_scale, text_scale, 0);

// --- INDICADOR DE CONTINUAR ---
draw_set_color(c_yellow);
draw_text_transformed(gui_w - margin_x - (250 * text_scale), box_y + box_h - (40 * text_scale), "[E] o [ESPACIO]", text_scale, text_scale, 0);
