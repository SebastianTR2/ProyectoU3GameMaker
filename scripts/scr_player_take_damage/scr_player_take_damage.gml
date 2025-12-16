// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_take_damage(attacker, dmg, attack_type) {
	/// @description scr_player_take_damage(attacker, dmg, attack_type)
	/// Aplica daño al jugador, considerando invulnerabilidad, defensa y bloqueo
	/// @param {instance} attacker - Instancia del atacante (puede ser noone)
	/// @param {real} dmg - Cantidad de daño base
	/// @param {string} attack_type - Tipo de ataque ("physical", "magic", etc.)
	
	// Verificar que el jugador existe
	if (!instance_exists(id)) {
		show_debug_message("ERROR: scr_player_take_damage llamado pero el jugador no existe");
		return;
	}
	
	// Verificar invulnerabilidad - si está invulnerable, no recibe daño
	if (invulnerable_timer > 0) {
		show_debug_message("Jugador invulnerable, daño ignorado");
		return;
	}
	
	// Verificar si el jugador está muerto
	if (dead == 1 || hp <= 0) {
		return;
	}
	
	// Calcular daño final
	var final_dmg = dmg;
	
	// Aplicar defensa (reducir daño según el valor de defense)
	if (variable_instance_exists(id, "defense")) {
		final_dmg = max(1, final_dmg - defense); // Mínimo 1 de daño
	}
	
	// Aplicar bloqueo (si está bloqueando, reducir daño adicionalmente)
	if (blocking && variable_instance_exists(id, "block_reduction")) {
		final_dmg = final_dmg * block_reduction; // Reducir según block_reduction (ej: 0.5 = 50%)
		show_debug_message("Jugador bloqueando, daño reducido a: " + string(final_dmg));
	}
	
	// Aplicar daño
	hp -= final_dmg;
	
	// Mostrar mensaje de debug
	show_debug_message("Jugador recibió " + string(round(final_dmg * 10) / 10) + " de daño. HP: " + string(hp) + "/" + string(hp_max));
	
	// Efecto visual de daño (flash rojo)
	image_blend = c_red;
	alarm[0] = 5; // Restaurar color en 5 frames (Alarm_0 ya existe en o_player)
	
	// Activar invulnerabilidad temporal
	// Usar invulnerable_duration si existe, sino usar 60 frames por defecto
	if (variable_instance_exists(id, "invulnerable_duration")) {
		invulnerable_timer = invulnerable_duration;
	} else {
		invulnerable_timer = 60; // Duración por defecto: 1 segundo a 60 FPS
	}
	
	// Crear número de daño flotante (similar al sistema de enemigos)
	if (instance_exists(o_damage_number)) {
		var dmg_num = instance_create_layer(x, y - sprite_height/2, "Instances", o_damage_number);
		if (dmg_num != noone) {
			dmg_num.damage_text = string(round(final_dmg * 10) / 10); // Mostrar con 1 decimal
			dmg_num.color = c_red; // Rojo para daño al jugador
		}
	}
	
	// Verificar muerte
	if (hp <= 0) {
		hp = 0; // Asegurar que no sea negativo
		// La muerte se manejará en el Step del jugador
		show_debug_message("Jugador ha muerto");
	}
}

