/// DRAW GUI EVENT — o_chat_decision

var w = display_get_gui_width();
var h = display_get_gui_height();

// --- CONFIGURACIÓN DEL CUADRO ---
var margin_x = 60;
var margin_y = 40;
var box_h = 180;
var box_y = h - box_h - margin_y;

// --- DIBUJAR EL SPRITE DEL CUADRO (igual que en o_chat) ---
if (sprite_exists(s_cuadro_Dialogo_Prueba)) {
    var spr_w = sprite_get_width(s_cuadro_Dialogo_Prueba);
    var spr_h = sprite_get_height(s_cuadro_Dialogo_Prueba);
    var scale_x = (w - (margin_x * 2)) / spr_w;
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
    draw_set_color(make_color_rgb(20, 20, 30));
    draw_rectangle(margin_x, box_y, w - margin_x, h - margin_y, false);
}

// --- CONFIGURAR FUENTE Y COLOR ---
draw_set_font(f_espanol);
draw_set_color(c_white);

// --- TÍTULO ---
var text_w = w - (margin_x * 2.5);
var text_x = w / 2;
var text_y = box_y + 25;

draw_set_halign(fa_center);
draw_text(text_x, text_y, text);
draw_set_halign(fa_left);

// --- DIBUJAR OPCIONES ---
for (var i = 0; i < ds_list_size(options); i++) {
    var opt_text = string(i + 1) + ". " + options[| i];
    var opt_x = margin_x + 120;
    var opt_y = box_y + 70 + (i * 28);
    
    if (i == selected)
        draw_set_color(c_yellow);
    else
        draw_set_color(c_white);
    
    draw_text(opt_x, opt_y, opt_text);
}

// --- INDICADOR ---
draw_set_color(c_yellow);
draw_text(w - margin_x - 350,box_y + box_h - 35, "[^ v] Seleccionar   [ESPACIO] Confirmar");
