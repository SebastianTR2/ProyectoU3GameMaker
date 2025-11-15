// === ESTADÍSTICAS ===
hp = 500;
hp_max = 500;
spd = 1.8;
damage = 35;
magic_damage = 40;

state = "idle"; // idle, chase, slash, parry, echo, timecut, dead
hunt_range = 280;
attack_range = 50;
attack_cooldown = 75;
attack_timer = 0;

// === HABILIDADES ===
can_echo = true;
echo_cooldown = 300;
echo_timer = 0;

can_parry = true;
parry_cooldown = 90;
parry_timer = 0;

can_timecut = true;
timecut_cooldown = 360;
timecut_timer = 0;

// === EFECTOS ===
echo_object = o_guardian_echo;
timecut_effect_time = 10; // frames de ralentización
timecut_radius = 80;

// === ELEMENTOS ===
light_weakness = 1.6;
combo_resistance = 0.7;
dark_resistance = 0.5;

// === VISUAL ===
sprite_idle       = s_guardian_reposo; 
sprite_walk       = s_guardian_reposo;  
sprite_slash      = s_guardian_attack;  
sprite_parry      = s_guardian_attack; 
sprite_echo       = s_guardian_attack;  
sprite_timecut    = s_guardian_attack;  
sprite_dead       = s_guardian_reposo;  

// === SONIDOS ===
//snd_parry = snd_guardian_parry;
//snd_slash = snd_guardian_slash;
//snd_timecut = snd_guardian_timecut;

// === OTROS ===
xp_drop = 250;
