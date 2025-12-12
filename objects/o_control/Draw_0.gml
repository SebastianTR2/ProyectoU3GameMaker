/// DRAW – o_control

if (!instance_exists(o_player)) exit;

var cx = camera_get_view_x(view_camera[0]);
var cy = camera_get_view_y(view_camera[0]);

// -------------------------------------------------------
// DIBUJAR HUD
// -------------------------------------------------------
draw_sprite(s_HUD, 0, cx, cy);

// =======================================================
// RETRATO (centrado dentro del marco redondo)
// =======================================================
var portrait_x = cx + 60;
var portrait_y = cy + 60;

draw_sprite_ext(
    o_player.sprite_index,
    0,
    portrait_x,
    portrait_y,
    1.3, 1.3,
    0,
    c_white,
    1
);

// =======================================================
// BARRA DE VIDA (roja)
// -------------------------------------------------------
var hp_ratio = o_player.hp / o_player.hp_max;

var hp_x = cx + 150;
var hp_y = cy + 42;
var hp_w = 150;   // ANCHO EXACTO DEL HUECO

draw_set_color(c_red);
draw_rectangle(hp_x, hp_y, hp_x + hp_w * hp_ratio, hp_y + 18, false);

// =======================================================
// BARRA DE STAMINA (verde)
// -------------------------------------------------------
var st_ratio = o_player.stamina / o_player.stamina_max;

var st_x = cx + 150;
var st_y = cy + 102;
var st_w = 150;

draw_set_color(c_lime);
draw_rectangle(st_x, st_y, st_x + st_w * st_ratio, st_y + 18, false);

// =======================================================
// BARRA DE MANÁ (VERTICAL) – Marco largo vertical
// =======================================================

// Porcentaje de maná actual
var mn_ratio = clamp(o_player.mana / o_player.mana_max, 0, 1);

// Dimensiones del marco vertical
var mn_x = cx + 10;      // Ajustado a tu imagen
var mn_y_top = cy + 140;  // parte superior del marco
var mn_y_bottom = cy + 260; // parte inferior del marco
var mn_width = 28;       // grosor de la barra

// Altura total del hueco interno
var mn_height = mn_y_bottom - mn_y_top;

// Altura de la parte llena
var mn_fill = mn_height * mn_ratio;

// Dibujar de abajo hacia arriba
draw_set_color(c_aqua);
draw_rectangle(
    mn_x,
    mn_y_bottom - mn_fill,
    mn_x + mn_width,
    mn_y_bottom,
    false
);

