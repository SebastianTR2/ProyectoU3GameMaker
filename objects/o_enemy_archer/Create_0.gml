/// CREATE EVENT - o_enemy_archer
/// ==========================================
/// ENEMIGO ARQUERO A DISTANCIA
/// ==========================================

/// ESTADÍSTICAS
hp = 6;
hp_max = 6;
damage = 1; // Daño por flecha
spd = 1.0; // Velocidad de movimiento

/// ESTADOS
state = "idle"; // idle, chase, shoot, dead
arrow_fired = false; // Flag para rastrear si ya disparó en este ataque
shoot_duration_timer = 0; // Timer para la duración del disparo

/// RANGOS Y TIMERS
hunt_range = 200;        // Distancia a la que detecta al jugador
shoot_range_min = 80;    // Distancia mínima para disparar
shoot_range_max = 150;   // Distancia máxima para disparar
flee_range = 60;          // Si el jugador está más cerca, alejarse
attack_cooldown = 120;   // Cooldown entre disparos (frames)
attack_timer = 0;        // Timer actual de cooldown
shoot_duration = 15;     // Duración de la animación de disparo

/// VISUAL
sprite_index = s_archer_idle;
image_speed = 0.3;
image_xscale = 1; // 1 = derecha, -1 = izquierda
visible = true; // Asegurar que sea visible

/// OTROS
xp_drop = 15; // Experiencia que otorga al morir

