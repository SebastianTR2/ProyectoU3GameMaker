// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_die(){
	/// @description scr_player_die()
	/// Maneja la muerte del jugador
	
	dead = 1;
	can_move = false;
	state = "dead";
	
	// Reiniciar HP para el respawn
	hp = hp_max;
	
	// Marcar como muerto globalmente
	global.player_dead = true;
	
	// Reiniciar a la última sala guardada o checkpoint
	room_restart();
}
