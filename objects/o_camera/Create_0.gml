/// @description Set up game camera

//A z-axis game needs a custom camera to follow the player when they
//jump, since that jump is not based on the y axis, an ordinary
//camera will not move up.
view_enabled = true;
global.Cameras = undefined;

#macro CameraWidth 640
#macro CameraHeight 360
#macro CameraScale 2
#macro CameraSpeed 0.1

window_set_fullscreen(true);
z = 10;

var width = CameraWidth, height = CameraHeight, scale = CameraScale;

view_visible[0] = true;
	
global.Cameras[0] = camera_create_view(0, 0, width, height);
camera_set_view_border(global.Cameras[0], width, height);
view_set_camera(0, global.Cameras[0]);
	
view_xport[0] = 0;
view_yport[0] = 0;
view_wport[0] = width * scale; // 1280
view_hport[0] = height * scale; // 720
			
// window_set_size(width * scale, height * scale);
surface_resize(application_surface, width * scale, height * scale);

// Restore original massive GUI resolution for the UI elements
display_set_gui_size(5600, 2800);