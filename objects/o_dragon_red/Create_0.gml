/// CREATE EVENT — o_dragon_red (versión adaptada)

/// === ESTADÍSTICAS ===
hp = 800;
hp_max = 800;
spd = 1.2;
damage = 40;
fire_damage = 50;

state = "ground"; // ground, fire_breath, tail, dead
phase = "ground"; // puedes ampliarlo a "air" más adelante

hunt_range = 400;
attack_range = 120;
attack_cooldown = 90;
attack_timer = 0;

// === FASES (placeholder, por si luego agregas vuelo) ===
can_fly = false;
fly_timer = 0;
fly_cooldown = 300;
is_flying = false;

// === ELEMENTOS ===
ice_weakness = 1.8;
fire_resistance = 0.2;
projectile_resistance = 0.6;

// === VISUAL  ===
sprite_idle_ground = s_dragon_reposo;
sprite_fire_breath = s_dragon_attack;
sprite_tail        = s_dragon_attack;
sprite_fly         = s_dragon_jump_reposo; 
sprite_slam        = s_dragon_attack;
sprite_dead        = s_dragon_reposo;

// === OTROS ===
xp_drop = 500;
//if (audio_exists(snd_dragon_roar)) roar_sound
