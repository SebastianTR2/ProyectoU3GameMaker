/// CREATE EVENT — o_demon_minor

// === ESTADÍSTICAS ===
hp = 130;
hp_max = 130;
spd = 1.6;
damage = 15;
magic_damage = 18;

state = "idle"; // idle, chase, melee, fireball, jump, dead
hunt_range = 240;
attack_range = 40;
ranged_range = 200;
attack_cooldown = 70;
attack_timer = 0;

// === HABILIDADES ===
can_jump_attack = true;
jump_cooldown = 180;
jump_timer = 0;
fireball_type = o_demon_fireball;

// === ELEMENTOS ===
ice_weakness = 1.7;
light_weakness = 1.4;
fire_resistance = 0.6;
dark_resistance = 0.5;

// === VISUAL  ===
sprite_idle      = s_demonio_reposo;
sprite_move      = s_demonio_Jump;        
sprite_attack    = s_attack_fire;         
sprite_jump      = s_demonio_Jump;        
sprite_fireball  = s_attack_fire;    
sprite_dead      = s_demonio_reposo;     

// === OTROS ===
xp_drop = 45;
