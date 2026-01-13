if global.paused == true
{
	exit;	
}

// Movement.
x += horizontal_movement;
y += vertical_movement;

vertical_movement += _gravity;

// Image opacity.
image_alpha -= fade_speed;

if (image_alpha <= 0) instance_destroy();