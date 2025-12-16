/// CREATE EVENT - o_enemy_wolf
/// ==========================================
/// ENEMIGO LOBO CON ATAQUE DE EMBESTIDA (DASH)
/// ==========================================

/// ESTADÍSTICAS
hp = 6;
hp_max = 6;
damage = 1; // Daño del dash
spd = 1.5; // Velocidad normal de movimiento
dash_speed = 4.0; // Velocidad durante el dash (muy rápido)

/// ESTADOS
state = "idle"; // idle, walk, dash, recover, dead

/// RANGOS Y TIMERS
hunt_range = 150;        // Distancia a la que detecta al jugador
dash_range = 80;         // Distancia para iniciar dash
dash_duration = 30;      // Duración del dash en frames
dash_cooldown = 180;     // Cooldown entre dashes (frames)
dash_timer = 0;          // Timer de cooldown
recover_duration = 60;   // Duración del estado recover (frames)
recover_duration_timer = 0; // Timer de recuperación
dash_duration_timer = 0; // Timer de duración del dash
dash_hitbox_created = false; // Flag para rastrear si ya se creó el hitbox
dash_direction = 0;      // Dirección del dash
dash_hitbox_ref = noone; // Referencia al hitbox del dash

/// VISUAL
sprite_index = s_wolf_idle;
image_speed = 0.3;
image_xscale = 1; // 1 = derecha, -1 = izquierda

/// OTROS
xp_drop = 15; // Experiencia que otorga al morir

