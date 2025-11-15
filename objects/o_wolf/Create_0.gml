/// CREATE EVENT - o_wolf

// === ESTADÍSTICAS BÁSICAS ===
hp = 45;  // Más resistente que el enemigo básico
hp_max = 45;
spd = 1.2;  // Más rápido que el enemigo básico
damage = 15;  // Daño de mordida
attack_damage = 15; // ← daño de ataque usado al golpear al jugador


// === ESTADOS Y COMPORTAMIENTO ===
state = "idle";  // idle, hunting, attacking, dead
hunt_range = 150;  // Distancia a la que detecta al jugador
attack_range = 20;  // Distancia para atacar
attack_cooldown = 60;
attack_timer = 0;  // Tiempo entre ataques


// === COMPORTAMIENTO DE MANADA ===
pack_leader = true;  // Hacer que sea líder para que ataque
pack_members = [];  // Array de otros lobos en la manada
formation_offset = 0;  // Offset para formación

// === ATAQUES ESPECIALES ===
double_bite_timer = 0;  // Para mordida doble
pounce_timer = 0;  // Para salto con derribo
pounce_cooldown = 120;  // Cooldown del salto

// === RESISTENCIAS Y DEBILIDADES ===
fire_weakness = 1.5;  // 50% más daño de fuego
cold_resistance = 0.7;  // 30% menos daño de frío
area_weakness = 1.3;  // 30% más daño de área

// === VISUAL ===
glow_timer = 2;  // Para el brillo del pelaje
glow_intensity = 0.3;

