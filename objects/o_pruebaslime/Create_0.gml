/// CREATE EVENT - o_slime
/// ================================================
/// CONFIGURACIÓN INICIAL DEL SLIME COMBATE / IA
/// ================================================

// === ESTADÍSTICAS BÁSICAS ===
hp = 35;
hp_max = 35;
spd = 1.0;
damage = 10;
attack_cooldown = 60;
attack_timer = 0;

// === IA ===
state = "idle";       // idle, hunting, attacking, dead
hunt_range = 120;     // rango de detección del jugador
attack_range = 20;    // distancia para atacar

// === VISUAL ===
sprite_idle   = s_slime_idle;
sprite_move   = s_slime_walk;
sprite_attack = s_slime_attack;
sprite_dead   = s_slime_dead;

// === PARTICULAS ===
slime_color = make_color_rgb(80, 255, 120);

// === EFECTOS DE SONIDO (opcional) ===
// snd_slime_move  = snd_slime_step;
// snd_slime_hit   = snd_slime_attack;
// snd_slime_die   = snd_slime_pop;
