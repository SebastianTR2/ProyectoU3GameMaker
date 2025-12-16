// === ESTADÍSTICAS BÁSICAS ===
hp = 100;
hp_max = 100;
spd = 1.3;
damage = 12;
ranged_damage = 10;

state = "idle"; // idle, chase, attack, ranged, dead
hunt_range = 220;
attack_range = 32;
ranged_range = 200;
attack_cooldown = 80;
attack_timer = 0;

// === VARIANTE DE ATAQUE ===
// Puede ser: "melee", "ranged", "lance"
attack_type = choose("melee", "ranged", "lance");

// === ELEMENTOS ===
fire_weakness = 1.5;
light_weakness = 1.4;
dark_resistance = 0.7;

// === VISUAL ===
sprite_idle = s_skeleton_idle;
sprite_walk = s_skeleton_walk;
sprite_attack_melee = s_skeleton_attack;
sprite_attack_ranged = s_skeleton_attack;
sprite_attack_lance = s_skeleton_attack;
sprite_dead = s_skeleton_dead;


// === OTROS ===
xp_drop = 35;
