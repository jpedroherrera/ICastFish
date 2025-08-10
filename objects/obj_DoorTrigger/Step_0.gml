//Spawns an interactive prompt when player collision, but only does it one time 
//in order to save on resources

if place_meeting(x, y, obj_Player) && instance_stop = 1
{
	instance_stop = 0;
	instance_create_layer(x + 27, y - 10, "Instances_1", obj_InteractPrompt)
}

if instance_exists(obj_InteractPrompt) && !place_meeting(x, y, obj_Player)
{
	instance_destroy(obj_InteractPrompt)
	instance_stop = 1;
}