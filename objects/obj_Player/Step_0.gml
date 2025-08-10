// Player Movement inputs
up = keyboard_check(ord("W"));
left = keyboard_check(ord("A"));
down = keyboard_check(ord("S"));
right = keyboard_check(ord("D"));
jump = keyboard_check(vk_space);

// Run current state (free movement, ladder, or menu).
state();

// Check for door interaction.
if place_meeting(x, y, obj_DoorTrigger) && keyboard_check_pressed(ord("E")) && room == rm_GeneralRoom
{
	room_goto(rm_HouseInterior)
}

if place_meeting(x, y, obj_DoorTrigger) && keyboard_check_pressed(ord("E")) && room == rm_HouseInterior
{
	room_goto(rm_GeneralRoom);	
}
