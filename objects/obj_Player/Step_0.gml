// Player Movement inputs
up = keyboard_check(ord("W"));
left = keyboard_check(ord("A"));
down = keyboard_check(ord("S"));
right = keyboard_check(ord("D"));
jump = keyboard_check(vk_space);

// Run current state (free movement, ladder, or menu).
state();
