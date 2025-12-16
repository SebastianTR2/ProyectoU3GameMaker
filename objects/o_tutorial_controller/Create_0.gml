/// CREATE EVENT
tut_step = 0; // 0: Start, 1: Stats, 2: Key Spawn, 3: Done
timer = 0;
xp_start = 0;
key_spawned = false; // Nueva variable para controlar si ya se spawneó la llave

if (instance_exists(o_player)) {
    xp_start = o_player.xp;
}
