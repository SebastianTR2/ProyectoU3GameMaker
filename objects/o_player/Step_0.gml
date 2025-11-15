/// STEP EVENT - o_player
/// ==========================================
/// SISTEMA DE ESTADOS PRINCIPAL
/// ==========================================

if (invulnerable_timer > 0) invulnerable_timer--;

// Control según modo
switch (global.control_type)
{
    case "topdown": scr_player_topdown(); break;
    case "lateral": scr_player_lateral(); break;
    case "cinematic":
        can_move = false;
        attacking = false;
        exit;
    break;
}

// ==========================================
// ACTUALIZAR ESTADO Y STAMINA
// ==========================================
if (abs(mx) > 0 || abs(my) > 0)
    state = "walk";
else if (!attacking && state != "block" && state != "cast")
    state = "idle";

if (stamina < stamina_max) stamina += stamina_regen;
if (is_running && stamina > 0) stamina -= stamina_drain;
stamina = clamp(stamina, 0, stamina_max);

// === MANA ===
if (mana < mana_max)
{
    mana += mana_regen; // regeneración constante
}
mana = clamp(mana, 0, mana_max);

// ==========================================
// ATAQUE Y MAGIA (con dirección)
// ==========================================
if (!attacking && state != "block" && state != "cast")
{
    if ((keyboard_check_pressed(ord("J")) || mouse_check_button_pressed(mb_left)) && attack_timer <= 0)
    {
        state = "attack";
        attacking = true;
        attack_timer = attack_cooldown;
        
        var w = instance_create_layer(x, y, "Instances", weapon_equipped);
        switch (sprite_facing)
        {
            case 0: w.direction = 270; break; // abajo
            case 1: w.direction = 180; break; // izquierda
            case 2: w.direction = 0;   break; // derecha
            case 3: w.direction = 90;  break; // arriba
        }
        w.image_xscale = (sprite_facing == 1) ? -1 : 1;
    }
}

// === MAGIA / DISTANCIA ===
if (keyboard_check_pressed(ord("M")) && mana >= 10 && state != "attack")
{
    state = "cast";
    mana -= 10;

    // 🔥 Crea la bola de fuego con dirección según sprite_facing
    var angle = 0; // dirección base
    var offset = 25; // distancia desde el jugador

    switch (sprite_facing)
    {
        case 0: angle = 90;  break;  // abajo
        case 1: angle = 180; break;  // izquierda (natural del sprite)
        case 2: angle = 0;   break;  // derecha
        case 3: angle = 270; break;  // arriba
    }

    // 🟠 Crea la bola de fuego ligeramente delante del jugador
    var xx = x + lengthdir_x(offset, angle);
    var yy = y + lengthdir_y(offset, angle);
    var m = instance_create_layer(xx, yy, "Instances", magic_equipped);

    m.direction = angle;
    m.speed = 7;
    m.image_angle = angle; // rota el sprite para apuntar correctamente
    m.image_xscale = (sprite_facing == 2) ? -1 : 1; // invierte al mirar derecha
}

// ==========================================
// CAMBIO DE SPRITE SEGÚN ACCIÓN
// ==========================================
switch (state)
{
    case "attack":
        sprite_index = s_playerAttack;
        image_speed = 1; // velocidad de animación normal
    break;

    case "cast":
        sprite_index = s_playerMagia;
        image_speed = 1;
    break;

    case "walk":
        sprite_index = s_playerWalk;
        image_speed = 1;
    break;

    default:
        sprite_index = s_playerIdle;
        image_speed = 0.3; // idle más lento
    break;
}

//if (global.story_phase == 1) show_tutorial();


if (attack_timer > 0)
{
    attack_timer--;
    if (attack_timer <= 0) attacking = false;
}

// ==========================================
// BLOQUEO / DEFENSA
// ==========================================
var want_block = keyboard_check(ord("K")) && stamina > 0;

if (want_block)
{
    state = "block";
    stamina = max(0, stamina - 0.5); // drenaje tenue mientras mantenga
}
else if (state == "block")
{
    // al soltar, volver al estado según movimiento
    state = (abs(mx) > 0 || abs(my) > 0) ? "walk" : "idle";
}

// ==========================================
// INTERACCIÓN
// ==========================================
if (keyboard_check_pressed(ord("E")) && can_interact)
{
    var obj = instance_place(x, y, o_interactable);
    if (obj != noone) with (obj) scr_interact();
}

// ==========================================
// AFINIDAD MÁGICA CAMBIABLE
// ==========================================
if (keyboard_check_pressed(ord("1"))) affinity = "fire";
if (keyboard_check_pressed(ord("2"))) affinity = "ice";
if (keyboard_check_pressed(ord("3"))) affinity = "lightning";
if (keyboard_check_pressed(ord("4"))) affinity = "dark";

// ==========================================
// SUBIR NIVEL AUTOMÁTICO
// ==========================================
if (xp >= xp_next)
{
    level++;
    xp -= xp_next;
    xp_next = round(xp_next * 1.3);
    hp_max += 10;
    stamina_max += 5;
    mana_max += 5;
    show_debug_message("Subiste a nivel " + string(level));
}

// ==========================================
// CLAMP DE VARIABLES (evita valores negativos o exceso)
// ==========================================
hp = clamp(hp, 0, hp_max);
stamina = clamp(stamina, 0, stamina_max);
mana = clamp(mana, 0, mana_max);

// ==========================================
// MUERTE DEL JUGADOR
// ==========================================
if (hp <= 0 && dead == 0)
{
    scr_player_die();
}
