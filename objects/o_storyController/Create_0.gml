/// CREATE EVENT de o_story_controller

scr_story_init_globals();

// Control interno del controlador
story_debug             = false;   // modo debug
story_tick              = 0;       // contador interno
story_auto_trigger_cooldown = 0;   // para no chequear triggers cada frame si no quieres

// Registra decisiones, misiones base y auto-triggers
scr_story_register_core_decisions();
scr_story_register_auto_triggers();
scr_story_register_main_quests();

// Opcional: establecer fase inicial (prólogo)
global.story_phase    = 0;   // 0 = PROLOGO
global.story_subphase = 0;
