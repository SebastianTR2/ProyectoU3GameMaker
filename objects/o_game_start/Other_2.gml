
// Globales ---------------------------

global.previous_room = 0;
global.checkpoint = 0;
global.player_respawn = 0;


/// ==============================================
/// SISTEMA GLOBAL DE PARTÍCULAS
/// ==============================================

// Creamos el sistema principal (una sola vez)
global.ps_main = part_system_create();
part_system_depth(global.ps_main, -1000); // detrás de todo

// ----------------------------------------------
// 💥 PARTICULA DE IMPACTO (roja/amarilla)
global.p_hit = part_type_create();
part_type_shape(global.p_hit, pt_shape_square);
part_type_size(global.p_hit, 0.04, 0.07, 0, 0);
part_type_color2(global.p_hit, 65535, 4227327);
part_type_alpha3(global.p_hit, 1, 1, 0);
part_type_speed(global.p_hit, 0.70, 1.50, -0.05, 0);
part_type_direction(global.p_hit, 0, 359, 0, 0);
part_type_blend(global.p_hit, 1);
part_type_life(global.p_hit, 18, 30);

// ----------------------------------------------
// 💥 PEQUEÑA EXPLOSIÓN
global.p_boom = part_type_create();
part_type_sprite(global.p_boom, s_boom, 1, 1, 0);
part_type_life(global.p_boom, 24, 24);
part_type_blend(global.p_boom, 1);

// ----------------------------------------------
// 💥 EXPLOSIÓN GRANDE
global.p_boom_large = part_type_create();
part_type_sprite(global.p_boom_large, s_boom, 1, 1, 0);
part_type_scale(global.p_boom_large, 1.75, 1.75);
part_type_life(global.p_boom_large, 24, 24);
part_type_blend(global.p_boom_large, 1);

// ----------------------------------------------
// 🔥 CHISPAS ROJAS (golpe fuerte)
global.p_dj = part_type_create();
part_type_shape(global.p_dj, pt_shape_square);
part_type_size(global.p_dj, 0.05, 0.15, -0.005, 0);
part_type_color3(global.p_dj, 16774462, 16752384, 16711680);
part_type_speed(global.p_dj, 1.5, 3, 0, 0);
part_type_direction(global.p_dj, 225, 315, 0, 0);
part_type_life(global.p_dj, 25, 25);
part_type_blend(global.p_dj, 1);

// ----------------------------------------------
// 🔥 CHISPAS ANARANJADAS (impacto extendido)
global.p_dj2 = part_type_create();
part_type_shape(global.p_dj2, pt_shape_square);
part_type_size(global.p_dj2, 0.09, 0.18, -0.005, 0);
part_type_color3(global.p_dj2, 16776106, 16761177, 16740721);
part_type_speed(global.p_dj2, 2.50, 4, 0, 0);
part_type_direction(global.p_dj2, 265, 275, 0, 0);
part_type_life(global.p_dj2, 25, 25);
part_type_blend(global.p_dj2, 1);

// ----------------------------------------------
// ⚡ RAYOS / TRAZAS
global.p_tracer = part_type_create();
part_type_shape(global.p_tracer, pt_shape_flare);
part_type_size(global.p_tracer, 0.18, 0.18, -0.007, 0);
part_type_color3(global.p_tracer, 912895, 33023, 255);
part_type_alpha3(global.p_tracer, 1, 1, 1);
part_type_blend(global.p_tracer, 1);
part_type_life(global.p_tracer, 10, 10);

// ----------------------------------------------
// ✨ CHISPAS GENERALES (usadas por bloqueos y slime)
global.p_spark = part_type_create();
part_type_shape(global.p_spark, pt_shape_disk);
part_type_size(global.p_spark, 0.18, 0.29, -0.007, 0);
part_type_color3(global.p_spark, 65535, 33023, 255);
part_type_speed(global.p_spark, 2, 3.2, 0, 0);
part_type_direction(global.p_spark, 45, 135, 0, 0);
part_type_gravity(global.p_spark, 0.20, 270);
part_type_blend(global.p_spark, 1);
part_type_life(global.p_spark, 45, 45);

// ----------------------------------------------
// ⚡ CHISPAS LÁSER
global.p_spark_laser = part_type_create();
part_type_shape(global.p_spark_laser, pt_shape_square);
part_type_size(global.p_spark_laser, 0.05, 0.08, 0, 0);
part_type_color2(global.p_spark_laser, 16777088, 16731392);
part_type_alpha3(global.p_spark_laser, 1, 1, 0);
part_type_speed(global.p_spark_laser, 0.8, 1.5, -0.07, 0);
part_type_direction(global.p_spark_laser, 0, 359, 0, 0);
part_type_blend(global.p_spark_laser, 1);
part_type_life(global.p_spark_laser, 25, 38);

// ----------------------------------------------
// 💚 PARTICULAS EXCLUSIVAS PARA SLIME
 global.p_slime = part_type_create();
    part_type_shape(global.p_slime, pt_shape_flare);
    part_type_size(global.p_slime, 0.1, 0.2, -0.005, 0);
    part_type_color3(global.p_slime, make_color_rgb(50, 255, 100), make_color_rgb(0, 180, 70), make_color_rgb(0, 120, 50));
    part_type_alpha3(global.p_slime, 1, 0.8, 0);
    part_type_speed(global.p_slime, 0.2, 1, 0, 0);
    part_type_direction(global.p_slime, 0, 359, 0, 0);
    part_type_gravity(global.p_slime, 0.05, 270);
    part_type_life(global.p_slime, 20, 35);
    part_type_blend(global.p_slime, 1);

show_debug_message("✅ Sistema de partículas global inicializado");


