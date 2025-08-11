if (!active) return; // Skip input if menu inactive.

// Read current key states (held down or not)
var up = keyboard_check(ord("W"));
var down = keyboard_check(ord("S"));
var confirm = keyboard_check(vk_enter);

// Detect key pressed *this* frame.
var up_pressed = up && !prev_up;
var down_pressed = down && !prev_down;
var confirm_pressed = confirm && !prev_confirm;

// Update previous states for next step.
prev_up = up;
prev_down = down;
prev_confirm = confirm;

// Store number of options in current menu.
option_length = array_length(menu[menu_level]);

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

// Handle menu selection
if (confirm_pressed && current_time - last_confirm_time >= confirm_cooldown)
{
    // Record confirm press time.
    last_confirm_time = current_time;

    // Store current menu level.
    var start_menu_level = menu_level;

    // Call the selected function.
    selectOption(menu_level, position);
    
    // Update option_length if menu level changed.
    if (start_menu_level != menu_level) {
        position = 0; // Reset cursor to top.
        option_length = array_length(menu[menu_level]);
    }
}