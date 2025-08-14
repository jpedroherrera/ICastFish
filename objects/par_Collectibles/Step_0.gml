if (!autopickup)
{
    // Distance check to player
    var item_position = instance_nearest(x, y, obj_Player);

	if (item_position != noone && point_distance(x, y, item_position.x, item_position.y) <= 24)
	{
        // CODE HERE TO SHOW PROMPT TO PICK UP.

        if (keyboard_check_pressed(ord("E")))
		{
            add_to_inventory();

			// Checks that child doesn't have special post_pickup.
			if (is_callable(post_pickup) && !has_specific_post_pickup)
			{
				post_pickup(obj_Player.id, {room: room, pickup_uid: uid });
			}
        }
    }
}
