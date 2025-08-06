// Player Movement
_up = keyboard_check(ord("W"));
_left = keyboard_check(ord("A"));
_down = keyboard_check(ord("S"));
_right = keyboard_check(ord("D"));
_jump = keyboard_check(vk_space);
menu_key = keyboard_check(vk_escape);

// Run State Machine
state();

// Open Menu
if (menu_key) instance_create_depth(x, y, -100, obj_Menu);
