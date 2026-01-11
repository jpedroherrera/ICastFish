		// Parent event.
event_inherited();

		// Child event.
if (state == "orbit") {
	if (instance_exists(orbit_target)) {
		// Calculate angle from player to mouse
	    orbit_angle = point_direction(orbit_target.x, orbit_target.y, mouse_x, mouse_y);

	    // Position weapon at fixed radius along mouse angle
	    x = orbit_target.x + lengthdir_x(orbit_radius, orbit_angle);
	    y = orbit_target.y + lengthdir_y(orbit_radius, orbit_angle) + 5;

		// Face Outward.
	    image_angle = orbit_angle - 90;
	}
	else {
	// Clean up if player is gone.
	instance_destroy();
	}
}
