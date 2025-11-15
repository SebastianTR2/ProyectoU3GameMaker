/// DRAW EVENT — o_npc_base
// Dibujar sprite del NPC normalmente
if (sprite_index != -1) draw_self();

// --- Indicador “E” ---
var can_show = (!variable_global_exists("dialogue_active")) || (global.dialogue_active == false);

if (show_e && can_show) {
    draw_sprite(sprite_indicator, 0, x, y - sprite_get_height(sprite_index) - 8);
}
