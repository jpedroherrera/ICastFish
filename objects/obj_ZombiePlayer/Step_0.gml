// Run current state (free movement, ladder, or menu).

if global.paused == true
{
	image_speed = 0;
	exit;
}
state();