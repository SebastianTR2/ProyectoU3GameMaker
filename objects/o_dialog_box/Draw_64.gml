if (!active) exit;

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

// Dynamic size: 60% width, 30% height (or min 600x300)
var _w = max(600, _gui_w * 0.6);
var _h = max(300, _gui_h * 0.35); // Slightly taller
var _x = (_gui_w - _w) / 2;
var _y = (_gui_h - _h) / 2;

// Background
draw_set_color(c_black);
draw_set_alpha(0.9);
draw_rectangle(_x, _y, _x+_w, _y+_h, false);
draw_set_alpha(1);

// Border (thick)
draw_set_color(c_white);
draw_rectangle(_x, _y, _x+_w, _y+_h, true);
draw_rectangle(_x+1, _y+1, _x+_w-1, _y+_h-1, true); // Double border effect

// Font Setup
if (font_exists(f_espanol)) draw_set_font(f_espanol);
var _scale = 1; 
if (_gui_w > 1280) _scale = 2; // Scale up for 1080p+ 
if (_gui_w > 2000) _scale = 3; // 4K support?

draw_set_halign(fa_center);
draw_set_valign(fa_top);

// Title at top
draw_set_color(c_yellow);
draw_text_transformed(_x + _w/2, _y + 30, title, _scale * 1.2, _scale * 1.2, 0);

// Main Text (Moved down to avoid overlap)
draw_set_color(c_white);
draw_set_halign(fa_left);
var _margin = 40;
var _text_w_limit = (_w - (_margin*2)) / _scale; 
draw_text_ext_transformed(_x + _margin, _y + 100, text, 25, _text_w_limit, _scale, _scale, 0);

// OPTIONS MENU (Vertical List)
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (variable_instance_exists(id, "options") && array_length(options) > 0) {
    var _opt_count = array_length(options);
    var _btn_h = 40 * _scale;
    var _start_y = _y + _h - (_btn_h * _opt_count) - 40;
    
    for (var i = 0; i < _opt_count; i++) {
        var _opt_y = _start_y + (i * _btn_h);
        var _txt = options[i];
        
        if (selected_option == i) {
            draw_set_color(c_yellow);
            _txt = "> " + _txt + " <";
        } else {
            draw_set_color(c_gray);
        }
        
        draw_text_transformed(_x + _w/2, _opt_y, _txt, _scale, _scale, 0);
    }
} else {
    // Single prompt (Enter)
     var _btn_y = _y + _h - 60;
    draw_set_color(c_white);
    draw_text_transformed(_x + _w/2, _btn_y, "[ Presiona ENTER ]", _scale, _scale, 0);
}

// Reset
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
