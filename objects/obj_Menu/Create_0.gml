// Initialize variables
active = true;			// Custom flag to ignore input/drawing if inactive.
continue_game = false;

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

// Current selected option.
position = 0;

// Text variables.
option_border = 12;
option_space = 16;
text_scale = 1;
zoom = 1;
max_width = 0;
max_height = 0;

// Constants for menu levels.
GENERAL = 0;
SETTINGS = 1;

// Initialize menu level.
menu_level = GENERAL;

// Menu structure (array of [text, function] pairs).
menu = [
    [ // GENERAL menu.
        ["Start Game", StartGame],
        ["Settings", OpenSettings],
        ["Quit Game", QuitGame]
    ],
    [ // SETTINGS menu.
        ["Window Size", AdjustWindowSize],
        ["Brightness", AdjustBrightness],
        ["Controls", ChangeControls],
        ["Back", GoBackToGeneral]
    ]
];

// Calculate option_length for the current menu.
option_length = array_length(menu[menu_level]);


// Function to select a menu option.
function selectOption(_level, _index)
{
    var func = menu[_level][_index][1]; // Get function reference.
    if (is_method(func) || is_callable(func)) {
        func(); // Call the function.
    }
}


// General menu option functions.
function StartGame() {room_goto(rm_GeneralRoom);}

function ContinueGame() {continue_game = true;}

function OpenSettings() {menu_level = SETTINGS;}

function QuitGame() {game_end();}


// Settings menu option functions.
function AdjustWindowSize() {show_message("Adjusting window size...");}

function AdjustBrightness() {show_message("Adjusting brightness...");}

function ChangeControls() {show_message("Changing controls...");}

function GoBackToGeneral() {menu_level = GENERAL;}


// Dynamically calculate menu width and height.
function MenuHeightAndWidth()
{
    max_width = 0;
    max_height = 0;
	// Set the font for measurement.
    draw_set_font(global.font_main);

    for (var i = 0; i < option_length; i++)
	{
        var option_text = menu[menu_level][i][0];
        var option_width = string_width(option_text);
        var option_height = string_height(option_text);

        max_width = max(max_width, option_width);
        max_height = max(max_height, option_height);
    }

    width = max_width + option_border * 4;
    height = option_border * 2 + max_height * option_length + option_space * (option_length - 1);
}


// Function to draw the menu.
function drawMenu(x, y, zoom, text_scale)
{
	// Draw menu background.
    draw_sprite_ext(sprite_index, image_index, x, y, width / sprite_width, height / sprite_height, 0, c_white, 1);
    
    // Draw options.
    draw_set_font(global.font_main);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);

    for (var i = 0; i < option_length; i++)
	{
        var color = (position == i) ? c_yellow : c_white;
        var option_y = y - height / 2 + option_border + max_height / 2 + (max_height + option_space) * i;
		var option_text = menu[menu_level][i][0];

		draw_text_transformed_color(x, option_y, option_text, zoom * text_scale, zoom * text_scale, 0, color, color, color, color, 1);
    }
}


// Title screen state.
stateTitleScreen = function()
{
	// Changes menu options.
	menu[0][0] = ["Start Game", StartGame];

    MenuHeightAndWidth();
    
    // Center menu.
    x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2;
    y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2;
    
    // Draw menu background.
    drawMenu(x, y, zoom, text_scale);
}

// In-game state.
stateInGame = function()
{
	// Changes menu option
	menu[0][0] = ["Continue Game", ContinueGame];

    MenuHeightAndWidth();
    
    // Center menu.
    if (instance_exists(obj_Player))
	{
        x = obj_Player.x;
        y = obj_Player.y;
    } else 
	{
        x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2;
        y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2;
    }
    
    // Define text scale factor.
    text_scale = 0.5;
    var base_view_width = 640;
    zoom = base_view_width / camera_get_view_width(view_camera[0]);
    
    // Draw menu.
	drawMenu(x, y, zoom, text_scale);
}

// Initialize state machine.
state = stateTitleScreen;
