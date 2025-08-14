function post_pickup(_player = noone, _extra = undefined) // Checks for paramaters but doesn't require them.
{
    // _player: instance of the player (optional)
    // _extra: struct, array, number, etc. with extra info (optional)

    // If a valid player was passed
    if (instance_exists(_player))
	{
        state = "orbit";
        orbit_target = _player;
        orbit_angle = point_direction(_player.x, _player.y, mouse_x, mouse_y);
    }

    // If extra data was provided, use it.
    if (is_struct(_extra) && variable_struct_exists(_extra, "message"))
	{
        show_debug_message(_extra.message);
    }
}
