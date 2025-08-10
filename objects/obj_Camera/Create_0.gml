// Track the player object
target = obj_Player;
look_ahead = 50; // Pixels to look ahead in the direction the player is facing
look_ahead_offset = 0; // Current smooth offset; will interpolate over time
zoom = 2;           // Current zoom level (1 = normal, 2 = zoomed in, 0.5 = zoomed out)
zoom_target = 1;    // The zoom level we’re moving toward
zoom_speed = 0.05;  // How quickly we move toward zoom_target
zoom_init = 2;		//Set our initial zoom, fixes weird startup zoom level (in theory)
zoom_fix = 1;
dir = 0;
// Initial camera dimensions (logical screen size)
var view_w = 640;
var view_h = 360;

// Create a new camera and assign it to Viewport 0
camera = camera_create_view(0, 0, view_w, view_h, 0, -1, -1, -1, -1);
view_camera[0] = camera;

