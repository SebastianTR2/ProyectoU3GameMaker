/// CREATE EVENT - o_player
/// ==========================================
/// CONFIGURACIÓN BASE
/// ==========================================
 //scr_init_globals();
if (!variable_global_exists("control_type")) global.control_type = "topdown";

global.previous_room = noone; // se usará para saber de dónde venimos
global.player_respawn = false;

/// MOVIMIENTO
move_speed = 3;
run_speed = 5;
current_speed = move_speed;
grav = 0.5;
jump_power = 8;
fall_speed_max = 10;
grounded = false;
is_jumping = false;
sprite_facing = 0; // 0=abajo, 1=izq, 2=der, 3=arriba

/// ENERGÍA
hp = 100;
hp_max = 100;
stamina = 100;
stamina_max = 100;
stamina_regen = 0.3;
stamina_drain = 0.8;
mana = 50;
mana_max = 50;

/// COMBATE
damage = 10;
attack_cooldown = 15;
attack_timer = 0;
attacking = false;
invulnerable_timer = 0;
defense = 2;
affinity = "fire"; // elemento inicial
//weapon_equipped = o_attack_sword;
//magic_equipped = o_magic_fire;


// === VARIABLES DE INVULNERABILIDAD ===
invi = 0;           // indica si el jugador está invulnerable
invi_time = 30;     // duración de la invulnerabilidad (en frames)


/// EXPERIENCIA
level = 1;
xp = 0;
xp_next = 100;

/// ESTADOS
state = "idle"; 
dead = 0; // 0 = vivo, 1 = muerto
can_move = true;
is_running = false;

/// CONTROL GLOBAL
ready = true;
can_interact = true;

/// SONIDOS (solo si existen)
//snd_hit = noone;
//snd_attack = noone;
//snd_jump = noone;
//snd_dodge = noone;

/// VARIABLES TEMPORALES
mx = 0;
my = 0;

/// GUARDADO TEMP
save_slot = "save_1.sav";


// === POSICIÓN DE REAPARICIÓN ===
spawn_x = x;
spawn_y = y;

// === FADE ===
fade_alpha = 0;
is_fading = false;

// === SISTEMA GLOBAL DE CHECKPOINT ===
if (!variable_global_exists("checkpoint")) global.checkpoint = room;
if (!variable_global_exists("player_respawn")) global.player_respawn = false;
if (!variable_global_exists("player_dead")) global.player_dead = false;

// === MANA ===
mana = 50;
mana_max = 50;
mana_regen = 0.2;  // 🔹 velocidad de regeneración (ajustable)




// --- POSICIÓN TEMPORAL DE ENTRADA ---
if (variable_global_exists("temp_spawn_x")) {
    x = global.temp_spawn_x;
    y = global.temp_spawn_y;

    // ⚙️ Limpia la variable para que no vuelva a aplicarse
    global.temp_spawn_x = undefined;
    global.temp_spawn_y = undefined;
}
