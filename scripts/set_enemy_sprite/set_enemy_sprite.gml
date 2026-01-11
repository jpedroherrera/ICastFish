/* NOTE: Requires sprite array with elligable sprites following this convention:

// RIGHT, UP, LEFT, DOWN, DIAGLD, DIAGLU, DIAGRD, DIAGRU are defined in the macros script.
sprite[RIGHT] = sprite right walk;
sprite[UP] = sprite up walk;
sprite[LEFT] = sprite left walk;
sprite[DOWN] = sprite down walk;
sprite[DIAGLD] = sprite diagonal left down walk;
sprite[DIAGLU] = sprite diagonal left up walk;
sprite[DIAGRD] = sprite diagonal right down walk;
sprite[DIAGRU] = sprite diagonal right up walk;
sprite[RIGHT + 8] = sprite right idle;  // Offset by 8 to store idle sprites.
sprite[UP + 8] = sprite up idle;
sprite[LEFT + 8] = sprite left idle;
sprite[DOWN + 8] = sprite down idle;
sprite[DIAGLD + 8] = sprite diagonal left down idle;
sprite[DIAGLU + 8] = sprite diagonal left up idle;
sprite[DIAGRD + 8] = sprite diagonal right down idle;
sprite[DIAGRU + 8] = sprite diagonal right up idle;

face = DOWN;
*/

// This function handles all enemy sprites.
function set_enemy_sprite(caller, x, y, horizontal_speed, vertical_speed, target_x, target_y) {
	// This sets the enemy sprite to face the direction it is moving.
    if (horizontal_speed != 0 || vertical_speed != 0) {
        var move_dir = point_direction(x, y, target_x, target_y);
        // Round to nearest 45° for 8-directional movement.
        move_dir = round(move_dir / 45) * 45;
        
        switch (move_dir) {
            case 0:   // Right
                face = RIGHT;
                break;
            case 45:  // Right + Up
                face = DIAGRU;
                break;
            case 90:  // Up
                face = UP;
                break;
            case 135: // Left + Up
                face = DIAGLU;
                break;
            case 180: // Left
                face = LEFT;
                break;
            case 225: // Left + Down
                face = DIAGLD;
                break;
            case 270: // Down
                face = DOWN;
                break;
            case 315: // Right + Down
                face = DIAGRD;
                break;
        }

        caller.sprite_index = sprite[face];
    }
    else {
        // Not moving: Use idle sprites
		if (horizontal_speed == 0 && vertical_speed == 0) {
			var move_dir = point_direction(x, y, target_y, target_y);
			 move_dir = round(move_dir / 45) * 45;
			 
			 switch(move_dir) {
				case 0:   // Right
                face = RIGHT;
                break;
            case 45:  // Right + Up
                face = DIAGRU;
                break;
            case 90:  // Up
                face = UP;
                break;
            case 135: // Left + Up
                face = DIAGLU;
                break;
            case 180: // Left
                face = LEFT;
                break;
            case 225: // Left + Down
                face = DIAGLD;
                break;
            case 270: // Down
                face = DOWN;
                break;
            case 315: // Right + Down
                face = DIAGRD;
                break;	
			 }
        caller.sprite_index = sprite[face + 8]; // Set idle sprite (offset by 8)
		}
    }
}