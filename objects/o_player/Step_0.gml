/// STEP EVENT - o_player
/// 
/// SISTEMA DE ESTADOS PRINCIPAL
///
	
if (invulnerable_timer > 0) invulnerable_timer--;

// TUTORIAL SPAWN
if (room == rm_Trampa_Subteranea && !instance_exists(o_tutorial_controller)) {
    // Asegurarse de que la capa existe, sino usar depth
    if (layer_exists("Instances"))
        instance_create_layer(0, 0, "Instances", o_tutorial_controller);
    else
        instance_create_depth(0, 0, -100, o_tutorial_controller);
}

// Control según modo
switch (global.control_type)
{
    case "topdown": scr_player_topdown(); break;
    // case "lateral": scr_player_lateral(); break; // REMOVED as requested
    case "cinematic":
        can_move = false;
        attacking = false;
        exit;
    break;
}
if (global.control_type == "topdown")
{
	
	
    if (state == "idle")
    {
        switch(sprite_facing)
        {
            case 0: sprite_index = s_playerIdle; image_xscale = 1; break;  // abajo
            case 1: sprite_index = s_playerIdle; image_xscale = -1; break; // izquierda
            case 2: sprite_index = s_playerIdle; image_xscale = 1; break;  // derecha
            case 3: sprite_index = s_playerIdle; image_xscale = 1; break;  // arriba
        }
    }
    else if (state == "walk")
    {
        switch(sprite_facing)
        {
            case 0: sprite_index = s_playerWalk; image_xscale = 1; break;
            case 1: sprite_index = s_playerWalk; image_xscale = -1; break;
            case 2: sprite_index = s_playerWalk; image_xscale = 1; break;
            case 3: sprite_index = s_playerWalk; image_xscale = 1; break;
        }
    }
}
// -----Cambios Fernando para Saltar
var jump = keyboard_check_pressed(vk_space);
	//Jumping
	if (jump && zSpeed == 0) {
		zSpeed = jump_power;
	}
	//Gravity
	if (z != zFloor) {
		zSpeed += grav;
	}
	//Snap to the ground
	if (z + zSpeed > zFloor) {
		zSpeed = 0;
		z = zFloor;
	}

	//Collisions
	if (PlaceMeeting3D(x + xSpeed, y, o_solid3)) {
		while(!PlaceMeeting3D(x + sign(xSpeed), y, o_solid3)) {
			x += sign(xSpeed);
		}
		xSpeed = 0;
	}
	if (PlaceMeeting3D(x, y + ySpeed, o_solid3)) {
		while(!PlaceMeeting3D(x, y + sign(ySpeed), o_solid3)) {
			y += sign(ySpeed);
		}
		ySpeed = 0;
	}

	//Tile collisions
	if (TileMeeting3D(x + xSpeed, y, tiles)) {
		xSpeed = 0;
	}
	if (TileMeeting3D(x, y + ySpeed, tiles)) {
		ySpeed = 0;
	}

	//Zfloor snapping
	if (instance_place(x, y, o_solid3)) {
		var block = instance_place(x, y, o_solid3);
	
		if (block.z >= z) {
			zFloor = block.z;
		}
		else {
			zFloor = 0;
		}
	}
	else {
		for(var i = 0; i < array_length(tiles); ++i) {
			if (tilemap_get_at_pixel(tiles[i], x, y + (i + 1) * - 16)) {
				zFloor = (i + 1) * - 16;
				break;
			}
			else {
				zFloor = 0;
			}
		}
	}

	//Collide with bottom of block
	if (instance_place(x, y, o_solid3)) {
		var block = instance_place(x, y, o_solid3);
		if (block && block.z > z + zSpeed && zFloor >= block.z) {
			if (zSpeed <= 0 && z > block.z) {
				zSpeed = grav;
			}
		}
	}



	//Move us along the axis' by our speeds
	x += xSpeed;
	y += ySpeed;
	z += zSpeed;


// ACTUALIZAR ESTADO Y STAMINA

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


// ATAQUE Y MAGIA (con dirección)

if (!attacking && state != "block" && state != "cast")
{
    if ((keyboard_check_pressed(ord("J")) || mouse_check_button_pressed(mb_left)) && attack_timer <= 0)
    {
        state = "attack";
        attacking = true;
        attack_timer = attack_cooldown;
        
        // Crear hitbox delante del jugador - MÉTODO MANUAL
        var offset = 40;
        var xx = x;
        var yy = y;
        
        // Calcular posición según dirección
        switch (sprite_facing)
        {
            case 0: yy += offset; break; // abajo
            case 1: xx -= offset; break; // izquierda
            case 2: xx += offset; break; // derecha
            case 3: yy -= offset; break; // arriba
        }
        
        show_debug_message("=== ATAQUE FÍSICO ===");
        show_debug_message("Jugador en: " + string(x) + ", " + string(y));
        show_debug_message("Dirección: " + string(sprite_facing) + " (0=abajo, 1=izq, 2=der, 3=arriba)");
        show_debug_message("Hitbox creado en: " + string(xx) + ", " + string(yy));
        
        var w = instance_create_layer(xx, yy, "Instances", weapon_equipped);
        w.image_xscale = (sprite_facing == 1) ? -1 : 1;
    }
}

// === MAGIA / DISTANCIA ===
if (keyboard_check_pressed(ord("M")) && mana >= 10 && state != "attack")
{
    state = "cast";
    mana -= 10;

    //  Crea la bola de fuego con dirección según sprite_facing
    var angle = 0; // dirección base
    var offset = 25; // distancia desde el jugador

    switch (sprite_facing)
    {
        case 0: angle = 270;  break;  // abajo
        case 1: angle = 180; break;  // izquierda (natural del sprite)
        case 2: angle = 0;   break;  // derecha
        case 3: angle =  90; break;  // arriba
    }

    // Crea la bola de fuego ligeramente delante del jugador
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
// ==========================================
// ORIENTACIÓN Y SPRITES (NUEVO SISTEMA)
// ==========================================

// Mapeo de variables locales para coincidir con el código del usuario
var speed_mov = (abs(mx) > 0 || abs(my) > 0); // Si hay movimiento
var att = attacking; // Estado de ataque
// var ori = sprite_facing * 90; // Asumiendo que sprite_facing (0,1,2,3) se alinea con 0, 90, 180, 270. 
// PERO el usuario usa 'ori' como variable directa. Vamos a usar 'sprite_facing' convertido a grados si 'ori' no existe, 
// o definir 'ori' basado en la dirección actual.
// En el código original: case 0: yy += offset; break; // abajo. 
// El usuario: case 0: Right.
// HAY UNA DISCREPANCIA EN LA DIRECCIÓN.
// Original: 0=Abajo, 1=Izq, 2=Der, 3=Arr
// Usuario: 0=Der, 90=Arr, 180=Izq, 270=Aba (Estándar GameMaker)

// Vamos a adaptar 'sprite_facing' al estándar del usuario para el switch
var current_ori = 0;
switch(sprite_facing) {
    case 0: current_ori = 270; break; // Abajo
    case 1: current_ori = 180; break; // Izq
    case 2: current_ori = 0; break;   // Der
    case 3: current_ori = 90; break;  // Arr
}

// Sobreescribir con la variable 'ori' si existe y es válida, o usar la calculada
var ori_to_use = current_ori;
if (variable_instance_exists(id, "ori")) ori_to_use = ori;

switch(ori_to_use)
{
	case 0: // DERECHA
		if(speed_mov == 0)
		{
			if(att)
			{
				sprite_index = s_playerAttack; // Mapeado de s_att_right
			}
			else
			{
				sprite_index = s_playerIdle; // Mapeado de s_stand_right
			}
		}
		else
		{
			sprite_index = s_playerWalk; // Mapeado de s_walk_right
		}
		image_xscale = 1;
		
        if (instance_exists(o_inter_mask)) {
		    o_inter_mask.x = x + 36;
		    o_inter_mask.y = y + 10;
        }
	break;
	
	case 90: // ARRIBA
		if(speed_mov == 0)
		{
			if(att)
			{
				sprite_index = s_playerAttack; // Mapeado de s_att_up (Placeholder)
			}
			else
			{
				sprite_index = s_playerArriba; // Mapeado de s_stand_up
			}
		}
		else
		{
			sprite_index = s_playerArriba; // Mapeado de s_walk_up
		}
		image_xscale = 1;
		
        if (instance_exists(o_inter_mask)) {
		    o_inter_mask.x = x;
		    o_inter_mask.y = y - 33;
        }
	break;
	
	case 180: // IZQUIERDA
		if(speed_mov == 0)
		{
			if(att)
			{
				sprite_index = s_playerAttack; // Mapeado de s_att_right
			}
			else
			{
				sprite_index = s_playerIdle; // Mapeado de s_stand_right
			}
		}
		else
		{
			sprite_index = s_playerWalk; // Mapeado de s_walk_right
		}
		image_xscale = -1;
		
        if (instance_exists(o_inter_mask)) {
		    o_inter_mask.x = x - 36;
		    o_inter_mask.y = y + 10;
        }
	break;
	
	case 270: // ABAJO
		if(speed_mov == 0)
		{
			if(att)
			{
				sprite_index = s_playerAttack; // Mapeado de s_att_down (Placeholder)
			}
			else
			{
				sprite_index = s_playerAbajo; // Mapeado de s_stand_down
			}
		}
		else
		{
			sprite_index = s_playerAbajo; // Mapeado de s_walk_down
		}
		image_xscale = 1;
		
        if (instance_exists(o_inter_mask)) {
		    o_inter_mask.x = x;
		    o_inter_mask.y = y + 53;
        }
	break;
}

if (instance_exists(o_inter_mask)) {
    o_inter_mask.image_angle = ori_to_use;
}


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
    blocking = true;
}
else if (state == "block")
{
    // al soltar, volver al estado según movimiento
    state = (abs(mx) > 0 || abs(my) > 0) ? "walk" : "idle";
    blocking = false;
    image_alpha = 1; // Restaurar opacidad normal
}

// ==========================================
// INTERACCIÓN
// ==========================================
if (keyboard_check_pressed(ord("E")) && can_interact)
{
    // Usamos collision_circle para detectar objetos cercanos sin necesidad de estar "dentro" de ellos (útil para sólidos)
    var _radius = 64; // Aumentado a 64 para mejor detección
    var obj = collision_circle(x, y, _radius, o_interactable, false, true);
    
    if (obj != noone) 
    {
        with (obj) 
        {
            // Llamar al evento Other 10 (User Event 0)
            event_perform(ev_other, ev_user0);
        }
    }
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
    xp_next = round(xp_next * 1.5); // Curva de experiencia un poco más exigente
    attr_points += 1; // 1 punto por nivel
    
    // Mensaje
    level_up_message = "¡Has subido a Nivel " + string(level) + "!\nTienes " + string(attr_points) + " punto(s) para asignar.";
    level_up_timer = 240; // 4 segundos
    
    // Restaurar stats al subir de nivel (opcional, común en RPGs)
    hp = hp_max;
    mana = mana_max;
    stamina = stamina_max;
    
    show_debug_message("Subiste a nivel " + string(level));
}

if (level_up_timer > 0) level_up_timer--;

// ==========================================
// MENÚ DE ATRIBUTOS
// ==========================================
if (keyboard_check_pressed(ord("C")))
{
    menu_open = !menu_open;
    if (menu_open) {
        can_move = false;
        global.game_paused = true;
    } else {
        can_move = true;
        global.game_paused = false;
    }
}

if (keyboard_check_pressed(vk_escape) && menu_open)
{
    menu_open = false;
    can_move = true;
    global.game_paused = false;
}

if (menu_open)
{
    // Navegación
    if (keyboard_check_pressed(vk_up))
    {
        menu_selected--;
        if (menu_selected < 0) menu_selected = array_length(menu_options) - 1;
    }
    
    if (keyboard_check_pressed(vk_down))
    {
        menu_selected++;
        if (menu_selected >= array_length(menu_options)) menu_selected = 0;
    }
    
    // Asignar puntos
    if (keyboard_check_pressed(vk_enter))
    {
        if (attr_points > 0)
        {
            attr_points--;
            switch(menu_selected)
            {
                case 0: attr_int++; break;
                case 1: attr_str++; break;
                case 2: attr_spd++; break;
                case 3: attr_vit++; break;
            }
            
            // Recalcular stats inmediatos
            // Vitalidad: 1 Vit = 5 HP
            hp_max = 100 + (attr_vit * 5); 
            
            // Inteligencia: 1 Int = 2 Mana
            mana_max = 50 + (attr_int * 2);
            
            // Fuerza: 1 Str = 1 Daño
            damage = 10 + attr_str;
            
            // Velocidad: Base 3 + (Spd * 0.1)
            move_speed = 3 + (attr_spd * 0.1);
            run_speed = 5 + (attr_spd * 0.15);
        }
    }
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
