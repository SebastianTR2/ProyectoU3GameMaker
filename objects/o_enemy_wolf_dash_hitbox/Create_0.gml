/// CREATE EVENT - o_enemy_wolf_dash_hitbox
/// ==========================================
/// Hitbox temporal durante el dash del lobo
/// Golpea solo una vez y se mueve con el lobo
/// ==========================================

damage = 1;
lifespan = 30; // Duración del hitbox en frames (se destruye cuando el dash termina)
owner = noone; // Se asignará desde el lobo
has_hit = false; // Flag para asegurar que solo golpee una vez
attack_type = "melee";

