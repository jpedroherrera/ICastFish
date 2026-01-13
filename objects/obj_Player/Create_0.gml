show_debug_log(true);

// Player Attributes.
hp = 100;
max_hp = 100;
magica = 100;
max_magica = 100;

// Movement characteristics.
move_speed = 1.5;
acceleration = 0.7;
fric = 0.7;
ladder_available = false;
ladder_dismount_timer = 0;
dodge_timer_max = 120;
dodge_timer = dodge_timer_max;
dodge_amount = 30;

// Combat characteristics.
invincibility = false;
invincibility_timer = 0;
has_weapon_equipped = false;

// Inventory.
menu_or_inventory = "";



// This functions handles menu and inventory toggles.
function check_menu_or_inventory_toggle() {
	// Check for menu toggle.
    if (keyboard_check_pressed(vk_escape)) {
		state = stateMenu;
		menu_or_inventory = "menu";
		return; // Skip movement this frame.
    }
	
	// Check for inventory toggle.
    if (keyboard_check_pressed(vk_tab)) {
		// Force idle animation before switching states
	    sprite_index = sprite[face + 8]; 

		state = stateMenu;
		menu_or_inventory = "inventory";
		return; // Skip movement this frame.
    }
	}


// This function checks for ladder interactability.
function check_for_ladder_interaction() {
	// Enter ladder climbing state if ladder is detected.
    if (place_meeting(x, y, obj_Ladder) && ladder_available && (up || down)) {
        horizontal_speed = 0;
        vertical_speed = 0;
        state = stateLadder;
    }

	// Cooldown timer after dismounting a ladder.
    if (!ladder_available) {
        ladder_dismount_timer -= 1;
        if (ladder_dismount_timer <= 0) ladder_available = true;
    }
}


// This function handles all player sprites.
function set_player_sprite() {
	// This sets the player sprite to always face the mouse.
    if (input_x != 0 || input_y != 0) {
        var move_dir = point_direction(x, y, mouse_x, mouse_y);
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

        sprite_index = sprite[face];
    }
    else {
        // Not moving: Use idle sprites
		if (input_x == 0 && input_y == 0) {
			var move_dir = point_direction(x, y, mouse_x, mouse_y);
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
        sprite_index = sprite[face + 8]; // Set idle sprite (offset by 8)
		}
    }
}


// This function handles door interaction.
function check_for_door_interaction() {
	// Check for door interaction.
	if (place_meeting(x, y, par_Door) && keyboard_check_pressed(ord("E"))) {
		var door_instance = instance_place(x, y, par_Door);

		if (door_instance != noone) {
		    // Get the instance ID (unique to this specific instance)
		    var door_instance_id = door_instance; // e.g., inst_2B1FDDAB
    
		    // Get the object type/index (what kind of object it is)
		    var object_type = door_instance.object_index; // e.g., obj_DoorToHouseInterior

			room_goto(object_type.destination);
		}
	}
}


// Facing Direction Array -- refer to Macros Script.
sprite[RIGHT] = spr_PlayerRightWalk;
sprite[UP] = spr_PlayerUpWalk;
sprite[LEFT] = spr_PlayerLeftWalk;
sprite[DOWN] = spr_PlayerDownWalk;
sprite[DIAGLD] = spr_PlayerDiagLDWalk;
sprite[DIAGLU] = spr_PlayerDiagLUWalk;
sprite[DIAGRD] = spr_PlayerDiagRDWalk;
sprite[DIAGRU] = spr_PlayerDiagRUWalk;
sprite[RIGHT + 8] = spr_PlayerRightIdle;  // Offset by 8 to store idle sprites.
sprite[UP + 8] = spr_PlayerUpIdle;
sprite[LEFT + 8] = spr_PlayerLeftIdle;
sprite[DOWN + 8] = spr_PlayerDownIdle;
sprite[DIAGLD + 8] = spr_PlayerDiagLDIdle;
sprite[DIAGLU + 8] = spr_PlayerDiagLUIdle;
sprite[DIAGRD + 8] = spr_PlayerDiagRDIdle;
sprite[DIAGRU + 8] = spr_PlayerDiagRUIdle;

face = DOWN;

    // State Machine
// Movement and state-related input flags and speed vectors.
up = 0;
left = 0;
down = 0;
right = 0;
jump = 0;
menu_key = 0;
horizontal_speed = 0;
vertical_speed = 0;
input_x = 0;
input_y = 0;


// Handles generic player movement.
stateFree = function() {
	// Directional input.
    input_x = right - left;
    input_y = down - up;

    if (input_x != 0 || input_y != 0) {
		// Prevent faster movement when pressing both directions.
		var length = point_distance(0, 0, input_x, input_y);
        if (length > 0) {
            input_x /= length;
            input_y /= length;
        }

        // Apply acceleration.
        horizontal_speed += input_x * acceleration;
        vertical_speed += input_y * acceleration;

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
	
	//Subtract from dodge_timer to make dodging available
	dodge_timer --;
	
	//Check for input & dodge if timer is below zero, then reset timer
	if dodge && dodge_timer <= 0 {
		//spawn a good ol poof effect that destroys itself after it plays it's animation.
		instance_create_layer(xprevious, yprevious, "MainInstances", obj_Poof);
		dodge_timer = dodge_timer_max;
		//apply direction to the dodge.
		if keyboard_check(ord("W")) {y -= dodge_amount;}
		if keyboard_check(ord("S")) {y += dodge_amount;}
		if keyboard_check(ord("A")) {x -= dodge_amount;}
		if keyboard_check(ord("D")) {x += dodge_amount;}
	}
	
	set_player_sprite();

	check_for_door_interaction();

	check_for_ladder_interaction();

	check_menu_or_inventory_toggle();
}

// Handles climbing movement on ladders.
stateLadder = function() {
	sprite_index = spr_PlayerUpWalk;
    var climb_speed = 2;
    var _climb = (down - up) * climb_speed;
    y += _climb;

	// Slightly dampen vertical speed when idle on ladder.
    if (_climb == 0) {
		vertical_speed *= 0.8;
		sprite_index = spr_PlayerUpIdle;
	}
	
	// Dismount ladder when jumping or exiting ladder area.
    if (jump || !place_meeting(x, y, obj_Ladder)) {
        ladder_available = false;
        ladder_dismount_timer = fps * 0.75;
        vertical_speed = 0;
        state = stateFree;
    }

	check_menu_or_inventory_toggle();
}

stateMenu = function()
{
	if (menu_or_inventory == "menu") {
		var menu_inst = instance_find(obj_Menu, 0);

		if (menu_inst == noone) {
			// Create menu instance if none exists
			menu_inst = instance_create_depth(x, y, -100, obj_Menu);
		}

		menu_inst.active = true;
		menu_inst.state = menu_inst.stateInGame; // Set to in-game state

	    horizontal_speed = 0;
	    vertical_speed = 0;

	    obj_Camera.zoom = lerp(obj_Camera.zoom, 2, 0.1);
	
		// Close menu on Escape key press
	    if (keyboard_check_pressed(vk_escape) || obj_Menu.continue_game == true) {
	        if (menu_inst != noone) {
	            menu_inst.active = false;
	        }

			obj_Menu.continue_game = false;

			menu_or_inventory = "";

	        state = stateFree;
	        return;
	    }
	}
	else { // i.e., menu_or_inventory == "inventory"
		horizontal_speed = 0;
	    vertical_speed = 0;
		
		if (keyboard_check_pressed(vk_tab)) {
			menu_or_inventory = "";
			
			state = stateFree;
			return;
		}
	}
}


state = stateFree;
