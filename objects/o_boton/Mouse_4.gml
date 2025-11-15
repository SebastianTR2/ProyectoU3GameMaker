if (hover) {
    audio_play_sound(snd_click, 1, false);

    switch (action)
    {
        case "newgame": room_goto(rm_prologue); break;
        case "continue": show_message("Continue aún no implementado"); break;
        case "options": show_message("Continue aún no implementado"); break;
        case "credits": show_message("Continue aún no implementado"); break;
        case "quit": game_end(); break;
    }
}
