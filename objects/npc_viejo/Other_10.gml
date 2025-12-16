/// @description Dialogo del Viejo sobre Estatuas

// Si ya hay un chat abierto, no hacer nada
if (instance_exists(o_chat)) exit;

// Asegurar que existe la lista de chat
if (!variable_global_exists("list_chat")) {
    global.list_chat = ds_queue_create();
}

// Limpiar mensajes anteriores por seguridad
ds_queue_clear(global.list_chat);

// --- DIÁLOGO DRAMÁTICO ---
ds_queue_enqueue(global.list_chat, "VIEJO: ¡Alto ahí, viajero! Veo en tus ojos la sed de poder...");
ds_queue_enqueue(global.list_chat, "VIEJO: ¿Has visto las estatuas que adornan estas tierras? No son simple piedra.");
ds_queue_enqueue(global.list_chat, "VIEJO: Son efigies de los Antiguos, y otorgan bendiciones a aquellos lo suficientemente valientes para reclamarlas.");
ds_queue_enqueue(global.list_chat, "VIEJO: Pero escucha bien mi advertencia...");
ds_queue_enqueue(global.list_chat, "VIEJO: Los cielos son celosos. Ningún mortal puede soportar el peso de más de TRES bendiciones simultáneas.");
ds_queue_enqueue(global.list_chat, "VIEJO: Si intentas abarcar más, los Dioses te aplastarán bajo su propia codicia.");
ds_queue_enqueue(global.list_chat, "VIEJO: Tres poderes. Ni uno más. Elige con sabiduría qué dones aceptas y cuáles rechazas.");
ds_queue_enqueue(global.list_chat, "VIEJO: Ahora ve... y que el destino no te encuentre desprevenido.");

// Crear el objeto de chat
instance_create_depth(0, 0, -9999, o_chat);
