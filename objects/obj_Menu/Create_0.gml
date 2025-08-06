// Declaring necessary variables.
width = 64;
height = 104;

up_key = 0;
down_key = 0;
confirm_key = 0;

option_border = 8;
option_space = 16;

position = 0; // Which option the user is hovering over.

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
