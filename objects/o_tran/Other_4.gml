/// @description Spawn Player
// Este evento se ejecuta al iniciar la room.
// Buscamos si este o_tran es el destino correcto basado en global.previous_room.

if (global.previous_room == target)
{
    // --- 0. Asegurar existencia del Jugador ---
    // Si el jugador no es persistente y no está en la room, lo creamos.
    if (!instance_exists(o_player))
    {
        // Intentamos crearlo en la capa "Instances" o "Player"
        var _layer = layer_get_id("Instances");
        if (layer_exists(layer_get_id("Player"))) _layer = layer_get_id("Player");
        
        instance_create_layer(x, y, _layer, o_player);
        show_debug_message("INFO [o_tran]: o_player creado automáticamente.");
    }

    if (instance_exists(o_player))
    {
        // --- 1. Calcular Posición Ideal ---
        // Usamos la posición de este objeto + offsets configurables
        // Se asume que el sprite del o_tran está centrado o se ajusta aquí.
        // El original usaba +48, ajustaremos para que sea el centro del objeto + offset.
        
        // Si las variables offset no existen (por si el usuario borró el Create), definirlas temp
        var _off_x = variable_instance_exists(id, "offset_x") ? offset_x : 0;
        var _off_y = variable_instance_exists(id, "offset_y") ? offset_y : 0;
        var _exit_ori = variable_instance_exists(id, "exit_ori") ? exit_ori : -1;

        var _spawn_x = x + _off_x;
        var _spawn_y = y + _off_y;
        
        // Si no se definieron offsets (0,0), usar un default inteligente para replicar el +48 original si se desea,
        // o mejor, usar +16/32 para centrar. El original usaba +48 y luego +/-96.
        // Vamos a intentar respetar la lógica original si los offsets son 0.
        if (_off_x == 0 && _off_y == 0) {
             // Lógica legacy mejorada:
             // El original ponía x+48, y+48.
             _spawn_x += 48;
             _spawn_y += 48;
             
             // Y luego sumaba 96 según orientación.
             // Si tenemos 'ori' (legacy) o 'exit_ori' (nuevo).
             var _ori_temp = variable_instance_exists(id, "ori") ? ori : -1;
             
             switch(_ori_temp)
             {
                case 0: _spawn_x += 96; break;
                case 90: _spawn_y -= 96; break;
                case 180: _spawn_x -= 96; break;
                case 270: _spawn_y += 96; break;
             }
        }

        // --- 2. Validación de Colisiones (Anti-Stuck) ---
        // Verificar si la posición ideal está dentro de una pared (o_solid)
        if (place_meeting(_spawn_x, _spawn_y, o_solid)) {
            show_debug_message("WARNING [o_tran]: Posición de spawn bloqueada. Buscando punto cercano...");
            
            var _found_safe = false;
            var _check_dist = 32; // Distancia a buscar
            
            // Intentar 4 direcciones básicas
            if (!place_meeting(_spawn_x + _check_dist, _spawn_y, o_solid)) { _spawn_x += _check_dist; _found_safe = true; }
            else if (!place_meeting(_spawn_x - _check_dist, _spawn_y, o_solid)) { _spawn_x -= _check_dist; _found_safe = true; }
            else if (!place_meeting(_spawn_x, _spawn_y + _check_dist, o_solid)) { _spawn_y += _check_dist; _found_safe = true; }
            else if (!place_meeting(_spawn_x, _spawn_y - _check_dist, o_solid)) { _spawn_y -= _check_dist; _found_safe = true; }
            
            if (!_found_safe) {
                show_debug_message("CRITICAL [o_tran]: No se encontró punto seguro de spawn.");
            }
        }

        // --- 3. Aplicar Posición ---
        o_player.x = _spawn_x;
        o_player.y = _spawn_y;

        // --- 4. Aplicar Orientación ---
        if (_exit_ori != -1) {
            if (variable_instance_exists(o_player, "facing")) o_player.facing = _exit_ori;
            else if (variable_instance_exists(o_player, "direction")) o_player.direction = _exit_ori;
            
            // Actualizar sprite del jugador inmediatamente si es necesario
            // o_player.sprite_facing = ... (si usa esa variable)
        }
    }
}