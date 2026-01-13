// Check if equipped. NOTE: for now only checks if it exists in inventory as there is currently no way to unequip.
if (global.Inv.has_type("weapon")) {
	equipped = true;
}

// Shoot spell on mouseclick.
if (equipped) {
	if(mouse_check_button(mb_left)) {
		// Attack 1
		var attack = instance_create_layer(obj_Player.x, obj_Player.y, id.layer, obj_Fireball);
		with (attack) {
			speed = obj_Fireball.projectile_speed;
			direction = point_direction(x, y, mouse_x, mouse_y);
	};
	} else if (mouse_check_button(mb_right)) {
		// Attack 2?
	}
}