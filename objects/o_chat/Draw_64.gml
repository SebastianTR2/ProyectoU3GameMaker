/// DRAW GUI EVENT - o_chat
if (!variable_instance_exists(id, "chat") || is_undefined(chat)) exit;

var w = display_get_gui_width();
var h = display_get_gui_height();

// --- CONFIGURACIÓN DEL CUADRO ---
var margin_x = 60;  // margen horizontal
var margin_y = 40;  // margen inferior
var box_h = 180;    // altura del cuadro
var box_y = h - box_h - margin_y; // posición Y del cuadro

// --- DIBUJAR EL SPRITE DEL CUADRO ---
if (sprite_exists(s_cuadro_Dialogo_Prueba)) {
    var spr_w = sprite_get_width(s_cuadro_Dialogo_Prueba);
    var spr_h = sprite_get_height(s_cuadro_Dialogo_Prueba);
    
    var scale_x = (w - (margin_x * 2)) / spr_w; // ahora con márgenes laterales
    var scale_y = box_h / spr_h;
    
    draw_sprite_ext(
        s_cuadro_Dialogo_Prueba,
        0,
        margin_x, box_y,
        scale_x, scale_y,
        0,
        c_white,
        1
    );
} else {
    // Fondo alternativo si no existe el sprite
    draw_set_color(make_color_rgb(20, 20, 30));
    draw_rectangle(margin_x, box_y, w - margin_x, h - margin_y, false);
}

// --- CONFIGURAR FUENTE Y COLOR ---
draw_set_font(f_espanol);
draw_set_color(c_white);

// --- TEXTO DEL DIÁLOGO ---
var text_w = w - (margin_x * 2.5);  // ancho disponible para texto
var text_x = w / 2;
var text_y = box_y + (box_h / 2) - 15; // centrado vertical leve

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_ext(text_x, text_y, chat, -1, text_w);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// --- INDICADOR DE CONTINUAR ---
draw_set_color(c_yellow);
draw_text(w - margin_x - 100, box_y + box_h - 35, "[ESPACIO]");
