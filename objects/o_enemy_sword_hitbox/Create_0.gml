/// CREATE EVENT - o_enemy_sword_hitbox
/// ==========================================
/// Hitbox de ataque del esqueleto
/// Golpea solo una vez al jugador
/// ==========================================

damage = 1;
lifespan = 25; // Duración del hitbox en frames (aumentado para cubrir toda la animación)
owner = noone; // Se asignará desde el esqueleto
has_hit = false; // Flag para asegurar que solo golpee una vez
attack_type = "physical";

