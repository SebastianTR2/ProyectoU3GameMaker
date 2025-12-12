if (hover) {
    audio_play_sound(snd_click, 1, false);

    switch (action)
    {
        case "newgame": room_goto(rm_Entrada_Exterior); break;  
		//rm_Pueblo_Roll  rm_pradera  rm_Entrada_Exterior  
		// rm_mundo_abierto
		
        case "continue": show_message("Continue aún no implementado"); break;
        case "options": show_message("opciones aún no implementado"); break;
        case "credits": show_message("creditos aún no implementado"); break;
        case "quit": game_end(); break;
    }
}
