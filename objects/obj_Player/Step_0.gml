// Player Movement inputs
up = keyboard_check(ord("W"));
left = keyboard_check(ord("A"));
down = keyboard_check(ord("S"));
right = keyboard_check(ord("D"));
jump = keyboard_check(vk_space);
dodge = keyboard_check(vk_shift);

// Run current state (free movement, ladder, or menu).

// Pause the character's animation and interactability.
if global.paused == true
{
	image_speed = 0;
	exit;	
}
else image_speed = 1;

// Run the state machine everys step.
state();

// Invincibility
if (invincibility) {
    invincibility_timer -= 1;
    if (invincibility_timer <= 0) {
        invincibility = false;
        invincibility_timer = 0;
    }
}

// Health
if (hp <= 0) {
	game_end();
}
