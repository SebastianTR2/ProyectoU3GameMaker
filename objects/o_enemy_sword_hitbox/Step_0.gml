/// STEP EVENT - o_enemy_sword_hitbox
/// ==========================================
/// Detecta colisión con el jugador y aplica daño una sola vez
/// ==========================================

// Si ya golpeó, no hacer nada más
if (has_hit) {
    lifespan--;
    if (lifespan <= 0) {
        instance_destroy();
    }
    exit;
}

// Verificar colisión con el jugador
var player = instance_place(x, y, o_player);
if (player != noone && !has_hit) {
    // Aplicar daño al jugador usando el script centralizado
    scr_player_take_damage(owner, damage, attack_type);
    has_hit = true; // Marcar como que ya golpeó
    show_debug_message("Esqueleto golpeó al jugador con " + string(damage) + " de daño");
}

// Reducir duración
lifespan--;
if (lifespan <= 0) {
    instance_destroy();
}

