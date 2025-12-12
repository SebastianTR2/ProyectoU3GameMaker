/// STEP EVENT - o_sword
/// ==========================================
/// DETECTAR COLISIÓN CON ENEMIGOS
/// ==========================================

show_debug_message("Espada en posición: " + string(x) + ", " + string(y));

// Verificar colisión con enemigos
var enemy = instance_place(x, y, o_enemy_body);
if (enemy != noone)
{
    show_debug_message("¡Espada golpeó enemigo!");
    scr_enemy_take_damage(enemy, damage, attack_type);
    instance_destroy();
}
else
{
    show_debug_message("Espada NO detectó enemigos");
}

// Reducir duración
lifespan--;
if (lifespan <= 0) 
{
    show_debug_message("Espada destruida por tiempo");
    instance_destroy();
}
