// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_interact(){
	/// @description scr_interact()
	/// Función base para interacción con objetos
	/// Los objetos hijos sobrescribirán esto
	
	show_debug_message("Interactuando con: " + object_get_name(object_index));
}
