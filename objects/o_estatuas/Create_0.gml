// Initialize Statue
image_speed = 0;

// Generate unique key for persistence
// Using room name and coordinates to identify this specific instance
var _key = room_get_name(room) + "_" + string(x) + "_" + string(y);

my_god_id = get_statue_god_id(_key); // Assigns or retrieves unique God ID

// Optional: Change sprite based on god if we had sprites
// if (my_god_id != -1) sprite_index = ...
