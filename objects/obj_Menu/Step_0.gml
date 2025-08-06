// Get inputs
up_key = keyboard_check_pressed(ord("W"));
down_key = keyboard_check_pressed(ord("S"));
confirm_key = keyboard_check_pressed(vk_enter);

// Store number of options in current menu.
option_length = array_length(option[menu_level]);

// Move through menu.
position += down_key - up_key;

if (position >= option_length) position = 0;
if (position < 0) position = option_length - 1;

if (confirm_key)
{
	var start_menu_level = menu_level;

	switch (menu_level)
	{
		case 0: // General menu.
			switch (position)
			{
				case 0: // Start game.
					room_goto(rm_GeneralRoom);
					break;

				case 1: // Settings.
					menu_level = SETTINGS;
					break;

				case 2: // Quit game.
					game_end();
					break;
			}
			break;

		case 1: // Settings
			switch (position)
			{
				case 0: // Window size.
					
					break;

				case 1: // Brightness.
					
					break;
				
				case 2: // Controls.
					
					break;

				case 3: // Back.
					menu_level = GENERAL;
					break;
			}
			break;
	}
	
	// Starts 'selector' at the top of the options list of the menu the user changed to.
	if (start_menu_level != menu_level) position = 0;
	
	// Correct option length.
	option_length = array_length(option[menu_level]);
}