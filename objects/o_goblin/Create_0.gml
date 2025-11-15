// === ESTADÍSTICAS BÁSICAS ===
hp = 80;
hp_max = 80;
spd = 1.4;
damage = 10;
ranged_damage = 8;

state = "idle"; // idle, chase, attack_melee, attack_ranged, taunt, dead
hunt_range = 200;
attack_range = 40;
ranged_range = 160;
attack_cooldown = 90;
attack_timer = 0;

// === HABILIDADES ===
has_projectile = true;  // puede lanzar bombas
projectile_type = o_enemy_bomb; // objeto que deberás crear (similar a proyectil mágico)
taunt_cooldown = 240;
taunt_timer = 0;

// === ELEMENTOS ===
fire_weakness = 1.5;
light_weakness = 1.4;
dark_resistance = 0.6;

// === VISUAL ===
sprite_idle = s_goblin_idle;
sprite_walk = s_goblin_walk;
sprite_attack_melee = s_goblin_attack;
sprite_attack_ranged = s_goblin_bomb;
sprite_taunt = s_goblin_taunt;
sprite_dead = s_goblin_dead;

// === OTROS ===
xp_drop = 25;
