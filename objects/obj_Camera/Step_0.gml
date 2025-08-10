if (!instance_exists(target)) exit;

// === Get Facing Direction ===
if target.face = RIGHT || DIAGRD || DIAGRU {dir = -1}
if target.face = LEFT || DIAGLD || DIAGLU {dir = 1}

// === Zoom Control ===
//Zoom fix for weird startup zoom level being outside of zoom bounds (hopefully, not working yet)
if zoom_fix = 1
{
	zoom = zoom_init
}	

if mouse_wheel_down() || mouse_wheel_up()
{
	zoom_fix = 0	
}

if zoom_fix = 0
{
if (mouse_wheel_up()) 
{
    zoom_target = clamp(zoom_target + 0.1, 1.5, 2);
}
if (mouse_wheel_down()) 
{
    zoom_target = clamp(zoom_target - 0.1, 1.5, 2);
}
zoom = lerp(zoom, zoom_target, zoom_speed);
}


// === Calculate Current View Size Based on Zoom ===
if zoom_fix = 1
{
	var view_w = 640 / zoom_init
	var view_h = 360 / zoom_init
	
	var offset = (view_w / 12);
	var target_offset = offset * -dir;
	
	var cam_target_x = target.x + look_ahead_offset;
	var cam_target_y = target.y;
	
	var cam_x = lerp(camera_get_view_x(camera), cam_target_x - view_w / 2, 0.1);
	var cam_y = lerp(camera_get_view_y(camera), cam_target_y - view_h / 2, 0.1);
	
	camera_set_view_size(camera, view_w, view_h);
	camera_set_view_pos(camera, cam_x, cam_y);
}
if zoom_fix = 0
{
	var view_w = 640 / zoom;
	var view_h = 360 / zoom;
	
	var offset = (view_w / 12);
	var target_offset = offset * -dir;
	
	var cam_target_x = target.x + look_ahead_offset;
	var cam_target_y = target.y;
	
	var cam_x = lerp(camera_get_view_x(camera), cam_target_x - view_w / 2, 0.1);
	var cam_y = lerp(camera_get_view_y(camera), cam_target_y - view_h / 2, 0.1);
	
	camera_set_view_size(camera, view_w, view_h);
	camera_set_view_pos(camera, cam_x, cam_y);
	
	
}


/*
var view_w = 640 / zoom;
var view_h = 360 / zoom;
 === Calculate Offset Target Position Based on Facing ===
var offset = (view_w / 12); // try to get this as middle as possible
var target_offset = offset * -dir; // flip it so RIGHT shifts camera left

 Smooth interpolation of offset
look_ahead_offset = lerp(look_ahead_offset, target_offset, 0.1);

 === Center Camera on Player, then shift by offset ===
var cam_target_x = target.x + look_ahead_offset;
var cam_target_y = target.y;

 Smooth camera movement
var cam_x = lerp(camera_get_view_x(camera), cam_target_x - view_w / 2, 0.1);
var cam_y = lerp(camera_get_view_y(camera), cam_target_y - view_h / 2, 0.1);

 Apply to camera
camera_set_view_size(camera, view_w, view_h);
camera_set_view_pos(camera, cam_x, cam_y);
*/