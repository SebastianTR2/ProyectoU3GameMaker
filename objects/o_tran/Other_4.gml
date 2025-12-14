/// @description Spawn Player Logic

// Asegurar que las globales existan (seguridad)
if (!variable_global_exists("previous_entry")) global.previous_entry = noone;
if (!variable_global_exists("previous_room"))  global.previous_room = noone;

// Determinar si este o_tran es el responsable del spawn
var is_spawn_point = false;

// CASO 1: Transición Compleja (por entry_id)
if (global.previous_entry != noone && entry_id != noone) {
    if (global.previous_entry == entry_id) {
        is_spawn_point = true;
    }
}
// CASO 2: Transición Simple (por room previa)
else if (global.previous_entry == noone) {
    // Solo si no estamos buscando un entry específico y tenemos un target válido
    if (target_room != noone && global.previous_room == target_room) {
        // En modo simple, la puerta que lleva A la room anterior 
        // suele ser la puerta DE la que venimos
        // CORRECCIÓN LÓGICA:
        // En sistemas simples, al volver de RoomA a RoomB,
        // buscamos en RoomB el o_tran que apunta a RoomA.
        is_spawn_point = true;
    }
}

// --------------------------------------------------
// EJECUTAR SPAWN
// --------------------------------------------------
if (is_spawn_point) {
    
    // 1. Crear jugador si no existe
    if (!instance_exists(o_player)) {
        var _layer = layer_get_id("Instances");
        if (layer_exists(layer_get_id("Player"))) _layer = layer_get_id("Player");
        instance_create_layer(x, y, _layer, o_player);
        show_debug_message("INFO [o_tran]: Player creado en " + string(x) + "," + string(y));
    }

    // 2. Calcular posición
    var _spawn_x = x;
    var _spawn_y = y;

    // Si hay offsets definidos, usarlos
    if (offset_x != 0 || offset_y != 0) {
        _spawn_x += offset_x;
        _spawn_y += offset_y;
    } else {
        // Lógica Legacy (centro 48x48 + offset direccional)
        _spawn_x += 48; // Centro del tile (asumiendo 96x96 o ajuste manual)
        _spawn_y += 48;

        switch (ori) {
            case 0:   _spawn_x += 96; break; // Derecha
            case 90:  _spawn_y -= 96; break; // Arriba
            case 180: _spawn_x -= 96; break; // Izquierda
            case 270: _spawn_y += 96; break; // Abajo
        }
    }

    // 3. Anti-stuck (evitar paredes)
    if (instance_exists(o_solid) && place_meeting(_spawn_x, _spawn_y, o_solid)) {
        show_debug_message("WARNING [o_tran]: Spawn bloqueado en " + string(_spawn_x) + "," + string(_spawn_y));
        
        // Intentar pequeños ajustes
        var _dist = 32;
        if (!place_meeting(_spawn_x + _dist, _spawn_y, o_solid)) _spawn_x += _dist;
        else if (!place_meeting(_spawn_x - _dist, _spawn_y, o_solid)) _spawn_x -= _dist;
        else if (!place_meeting(_spawn_x, _spawn_y + _dist, o_solid)) _spawn_y += _dist;
        else if (!place_meeting(_spawn_x, _spawn_y - _dist, o_solid)) _spawn_y -= _dist;
    }

    // 4. Aplicar al jugador
    with (o_player) {
        x = _spawn_x;
        y = _spawn_y;
        
        // Orientación
        if (other.ori != -1) {
            if (variable_instance_exists(id, "facing")) facing = other.ori;
            else if (variable_instance_exists(id, "direction")) direction = other.ori;
        }
    }
}
