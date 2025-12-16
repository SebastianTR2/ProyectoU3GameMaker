/// STEP EVENT - o_enemy_arrow
/// ==========================================
/// Movimiento y detección de colisión con el jugador
/// ==========================================

// Movimiento de la flecha
x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);

// Rotar la flecha según su dirección
image_angle = direction;

// Verificar colisión con el jugador
if (place_meeting(x, y, o_player)) {
    var player = instance_place(x, y, o_player);
    if (player != noone) {
        // Aplicar daño al jugador usando el script centralizado
        scr_player_take_damage(owner, damage, "ranged");
        show_debug_message("Flecha golpeó al jugador por " + string(damage) + " de daño");
        instance_destroy();
        exit;
    }
}

// Verificar colisión con sólidos
if (place_meeting(x, y, o_solid) || place_meeting(x, y, o_solid2) || place_meeting(x, y, o_solid3)) {
    instance_destroy();
    exit;
}

// Reducir vida útil
life--;
if (life <= 0) {
    instance_destroy();
}

