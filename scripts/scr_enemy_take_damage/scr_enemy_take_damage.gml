function scr_enemy_take_damage(enemy_id, dmg, attack_type){
	/// @description scr_enemy_take_damage(enemy_id, dmg, attack_type)
	/// Aplica daño a un enemigo
	
	with (enemy_id)
	{
		hp -= dmg;
		show_debug_message("Enemigo " + object_get_name(object_index) + " recibió " + string(dmg) + " de daño. HP: " + string(hp));
		
		// Efecto visual de daño (flash)
		image_blend = c_red;
		alarm[0] = 5; // Restaurar color en 5 frames
		
		// Crear número de daño flotante
		var dmg_num = instance_create_layer(x, y - sprite_height/2, "Instances", o_damage_number);
		dmg_num.damage_text = string(round(dmg * 10) / 10); // Mostrar con 1 decimal
		dmg_num.color = c_red; // Rojo para daño a enemigos
		
		// Verificar muerte
		if (hp <= 0)
		{
			state = "dead";
		}
	}
}
