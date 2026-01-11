// Player Attributes.
hp = 10;
max_hp = 10;

// Movement characteristics.
move_speed = 0.75;
acceleration = 0.7;
fric = 0.7;
ladder_available = false;
ladder_dismount_timer = 0;

// Combat characteristics.
invincibility = false;
invincibility_timer = fps;

// Facing Direction Array -- refer to Macros Script.
sprite[RIGHT] = spr_ZombiePlayerRightWalk;
sprite[UP] = spr_ZombiePlayerUpWalk;
sprite[LEFT] = spr_ZombiePlayerLeftWalk;
sprite[DOWN] = spr_ZombiePlayerDownWalk;
sprite[DIAGLD] = spr_ZombiePlayerDiagLDWalk;
sprite[DIAGLU] = spr_ZombiePlayerDiagLUWalk;
sprite[DIAGRD] = spr_ZombiePlayerDiagRDWalk;
sprite[DIAGRU] = spr_ZombiePlayerDiagRUWalk;
sprite[RIGHT + 8] = spr_ZombiePlayerRightIdle;  // Offset by 8 to store idle sprites.
sprite[UP + 8] = spr_ZombiePlayerUpIdle;
sprite[LEFT + 8] = spr_ZombiePlayerLeftIdle;
sprite[DOWN + 8] = spr_ZombiePlayerDownIdle;
sprite[DIAGLD + 8] = spr_ZombiePlayerDiagLDIdle;
sprite[DIAGLU + 8] = spr_ZombiePlayerDiagLUIdle;
sprite[DIAGRD + 8] = spr_ZombiePlayerDiagRDIdle;
sprite[DIAGRU + 8] = spr_ZombiePlayerDiagRUIdle;

face = DOWN;


// State-machine-related variables
horizontal_speed = 0;
vertical_speed = 0;
move_horizontally = 0;	// 0 for no movement, 1 for right, -1 for left.
move_vertically = 0;	// 0 for no movement, 1 for up, -1 for down.

// Handles generic enemy movement.
stateFree = function() {
	set_enemy_sprite(self, x, y, horizontal_speed, vertical_speed, obj_Player.x, obj_Player.y);
	
	if (instance_exists(obj_Player)) {

		if (obj_Player.x > x) {
			move_horizontally = 1;
		}
		else if (obj_Player.x = x) {
			move_horizontally = 0;
		}
		else {
			move_horizontally = -1;
		}
		
		if (obj_Player.y > y) {
			move_vertically = 1;
		}
		else if (obj_Player.y = y) {
			move_vertically = 0;
		}
		else {
			move_vertically = -1;
		}

        // Apply acceleration.
        horizontal_speed += move_horizontally * acceleration;
        vertical_speed += move_vertically * acceleration;

        // Cap speed.
        var speed_length = point_distance(0, 0, horizontal_speed, vertical_speed);
        if (speed_length > move_speed) {
            var factor = move_speed / speed_length;
            horizontal_speed *= factor;
            vertical_speed *= factor;
        }
    }
    else {
		// Apply friction.
        horizontal_speed = approach(horizontal_speed, 0, fric);
        vertical_speed = approach(vertical_speed, 0, fric);
    }

	// Check for wall collision before applying movement.
    if (!place_meeting(x + horizontal_speed, y + vertical_speed, par_Wall)) {
	    x += horizontal_speed;
        y += vertical_speed;
    }
}


state = stateFree;
