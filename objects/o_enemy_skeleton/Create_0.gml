/// CREATE EVENT - o_enemy_skeleton
/// ==========================================
/// ENEMIGO ESQUELETO CUERPO A CUERPO
/// ==========================================

/// ESTADÍSTICAS
hp = 6;
hp_max = 6;
damage = 1;
spd = 1.2; // Velocidad de movimiento

/// ESTADOS
state = "idle"; // idle, chase, attack, dead
attack_hitbox_created = false; // Flag para rastrear si ya se creó el hitbox en este ataque
attack_duration_timer = 0; // Timer para la duración del ataque
attack_hitbox_ref = noone; // Referencia al hitbox del ataque

/// RANGOS Y TIMERS
hunt_range = 120;      // Distancia a la que detecta al jugador
attack_range = 40;     // Distancia para atacar
attack_cooldown = 90;  // Cooldown entre ataques (frames)
attack_timer = 0;      // Timer actual de cooldown
attack_duration = 20;  // Duración de la animación de ataque

/// VISUAL
sprite_index = s_skeleton_idle;
image_speed = 0.3;
image_xscale = 1; // 1 = derecha, -1 = izquierda

/// OTROS
xp_drop = 15; // Experiencia que otorga al morir

