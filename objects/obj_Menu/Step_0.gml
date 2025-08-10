if (!active) return; // Skip input/draw if menu inactive.

// Read current key states (held down or not)
var up = keyboard_check(ord("W"));
var down = keyboard_check(ord("S"));
var confirm = keyboard_check(vk_enter);

// Detect key pressed *this* frame (rising edge).
var up_pressed = up && !prev_up;
var down_pressed = down && !prev_down;
var confirm_pressed = confirm && !prev_confirm;

// Update previous states for next step.
prev_up = up;
prev_down = down;
prev_confirm = confirm;

// Store number of options in current menu.
option_length = array_length(option[menu_level]);

// Move through menu.
if (up_pressed)
{
    position -= 1;
    if (position < 0) position = option_length - 1;
}

if (down_pressed)
{
    position += 1;
    if (position >= option_length) position = 0;
}

if (confirm_pressed && current_time - last_confirm_time >= confirm_cooldown)
{
    // Record this confirm press time.
    last_confirm_time = current_time;

    var start_menu_level = menu_level;

    switch (menu_level) {
        case 0: // General menu.
            switch (position) {
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

        case 1: // Settings menu
            switch (position) {
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

    // Starts cursor at the top if menu changed.
    if (start_menu_level != menu_level) position = 0;
	
	// Prevents instant trigger press.
	last_confirm_time = current_time;

    // Update option length after changing menus.
    option_length = array_length(option[menu_level]);
}
