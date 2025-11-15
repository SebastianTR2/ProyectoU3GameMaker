/// CREATE EVENT - o_chat

if (ds_queue_empty(global.list_chat)) {
    instance_destroy();
    exit;
}


// No capturamos ni desactivamos nada
chat = ds_queue_head(global.list_chat);
ds_queue_dequeue(global.list_chat);

camera_x = camera_get_view_x(view_camera[0]);
camera_y = camera_get_view_y(view_camera[0]);

// Fondo semitransparente opcional
bg_alpha = 0.6;



//s_screen = sprite_create_from_surface(application_surface,0,0,1250,720,0,0,0,0);
//instance_deactivate_all(true);

//camera_x = camera_get_view_x(view_camera[0]);
//camera_y = camera_get_view_y(view_camera[0]);

//if (!ds_queue_empty(global.list_chat)) {
//    chat = ds_queue_head(global.list_chat);
//    ds_queue_dequeue(global.list_chat);
//} else {chat = "";}
