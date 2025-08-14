// Check if orbit_target is valid.
// Find the player in the new room.
var new_player = instance_find(obj_Player, 0);

if (instance_exists(new_player))
{
    orbit_target = new_player;
}
