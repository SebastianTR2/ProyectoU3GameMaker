// === ESTADÍSTICAS BÁSICAS ===
hp = 300;
hp_max = 300;
spd = 1.1;
damage = 25;
magic_damage = 35;

state = "idle"; // idle, chase, aoe, charge, summon, dead
hunt_range = 280;
attack_range = 60;
attack_cooldown = 90;
attack_timer = 0;

// === HABILIDADES ===
can_charge = true;
charge_cooldown = 200;
charge_timer = 0;

can_summon = true;
summon_cooldown = 240;
summon_timer = 0;

aoe_radius = 48;
fire_trail = o_fire_trail;
dark_orb = o_dark_orb;

// === ELEMENTOS ===
water_weakness = 1.7;
electric_weakness = 1.4;
fire_resistance = 0.5;
poison_resistance = 0.6;

// === VISUAL ===
sprite_idle   = s_demonio_mediano_reposo;
sprite_walk   = s_demonio_mediano_reposo;
sprite_attack = s_demonio_mediano_attack;
sprite_charge = s_demonio_mediano_attack;
sprite_summon = s_demonio_mediano_attack;
sprite_dead   = s_demonio_mediano_reposo;


// === OTROS ===
xp_drop = 100;
