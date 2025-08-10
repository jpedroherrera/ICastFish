visible = true;        // Show menu initially.
active = true;         // Custom flag to ignore input/drawing if inactive.

	// Declaring necessary variables.
// Menu size variables.
width = 64;
height = 104;

// Menu cursor variables.
up_key = 0;
down_key = 0;
confirm_key = 0;

// Edge detection.
prev_up = false;
prev_down = false;
prev_confirm = false;

last_confirm_time = 0;
confirm_cooldown = 200;

// Which option the user is hovering over.
position = 0;

// Text variables.
option_border = 12;
option_space = 16;

text_scale = 1;
zoom = 1;

max_width = 0;
max_height = 0;

// Menu levels.
GENERAL = 0;
SETTINGS = 1;

menu_level = GENERAL;

// Menus.
// General menu options.
option[GENERAL, 0] = "Start Game";
option[GENERAL, 1] = "Settings";
option[GENERAL, 2] = "Quit Game";

// Settings menu options.
option[SETTINGS, 0] = "Window Size";
option[SETTINGS, 1] = "Brightness";
option[SETTINGS, 2] = "Controls";
option[SETTINGS, 3] = "Back";

option_length = array_length(option[menu_level]);



// Dynamically get width and height of menu.
function MenuHeightAndWidth()
{
	for (var i = 0; i < option_length; i++)
	{
		var option_width = string_width(option[menu_level, i]);
		var option_height = string_height(option[menu_level, i]);
	    max_width = max(max_width, option_width);
	    max_height = max(max_height, option_height);
	}

	width = max_width + option_border*4;
	height = option_border * 2 + max_height * option_length + option_space * (option_length - 1);
}


// Function to toggle menu visibility and state.
function toggleMenu(is_on) {
    active = is_on;
    visible = is_on;
    position = 0;
    menu_level = GENERAL;
    option_length = array_length(option[menu_level]);
    
    // Set the state function for drawing and input based on context:
    if (is_on) {
        state = stateInGame;
        // Reset last_confirm_time to prevent immediate input.
        last_confirm_time = current_time;
    } else {
        state = stateTitleScreen;
    }
}


// Title screen state.
stateTitleScreen = function()
{
	MenuHeightAndWidth();

	// Center menu.
	x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2;
	y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2;

	// Draw menu background.
	draw_sprite_ext(sprite_index, image_index, x, y, width/sprite_width, height/sprite_height, 0, c_white, 1);

	// Draw the options.
	for (var i = 0; i < option_length; i++)
	{
	    var color = c_white;
	    if (position == i) color = c_yellow;
    
	    var option_y = y - height / 2 + option_border + max_height / 2 + (max_height + option_space) * i;
	    draw_text_transformed_color(x, option_y, option[menu_level, i], zoom * text_scale, zoom * text_scale, 0, color, color, color, color, 1);
	}
}


// In-game state.
stateInGame = function ()
{
	MenuHeightAndWidth();

	// Center menu.
    if (instance_exists(obj_Player))
    {
        x = obj_Player.x;
        y = obj_Player.y;
    }
    else
    {
        x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2;
        y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2;
    }

	// Draw menu background.
	draw_sprite_ext(sprite_index, image_index, x, y, width/sprite_width, height/sprite_height, 0, c_white, 1);

	// Define text scale factor (adjust this to change font size).
	text_scale = 0.5;
	
	// Get zoom factor.
	var base_view_width = 640;
	zoom = base_view_width / camera_get_view_width(view_camera[0]);

	// Draw the options.
	for (var i = 0; i < option_length; i++)
	{
	    var color = c_white;
	    if (position == i) color = c_yellow;
    
	    var option_y = y - height / 2 + option_border + max_height / 2 + (max_height + option_space) * i;
	    draw_text_transformed_color(x, option_y, option[menu_level, i], zoom * text_scale, zoom * text_scale, 0, color, color, color, color, 1);
	}
}

state = stateTitleScreen;
