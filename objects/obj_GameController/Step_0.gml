// Pause the game and handle other things related to being paused.
if keyboard_check_pressed(vk_backspace) && global.paused == false
{
	global.paused = true;
}
else if keyboard_check_pressed(vk_backspace) && global.paused == true
{
	global.paused = false;	
}

// Paused menu vignette.
with obj_MenuVignette
{
	if global.paused == true
	{
		visible = true;
	}	
	else visible = false;
	
}