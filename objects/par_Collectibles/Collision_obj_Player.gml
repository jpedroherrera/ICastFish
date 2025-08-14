if (autopickup)
{
    add_to_inventory();
	
	// Checks that child doesn't have special post_pickup.
	if (is_callable(post_pickup) && !has_specific_post_pickup && !has_been_picked_up)
	{
		post_pickup(other, {room: room, pickup_uid: uid });
		has_been_picked_up = true;
	}
}
