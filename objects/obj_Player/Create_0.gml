// Player Attributes
_hp = 100;
_max_hp = 100;
_magica = 100;
_max_magica = 100;

// Movement characteristics.
move_speed = 6;
accel = 0.7;
fric = 0.7;
_ladder_available = true;
_ladder_dismount_timer = 0;

// Combat characteristics.
_invincibility = false;
_invincibility_timer = fps;


// Approach Function
approach = function(val, target, amount)
{
    return (val < target) ? min(val + amount, target) : max(val - amount, target);
}


// Facing Direction Array -- refer to Macros Script
sprite[RIGHT] = spr_PlayerRightWalk;
sprite[UP] = spr_PlayerUpWalk;
sprite[LEFT] = spr_PlayerLeftWalk;
sprite[DOWN] = spr_PlayerDownWalk;
sprite[DIAGLD] = spr_PlayerDiagLUWalk;
sprite[DIAGLU] = spr_PlayerDiagLDWalk;
sprite[DIAGRD] = spr_PlayerDiagRDWalk;
sprite[DIAGRU] = spr_PlayerDiagRUWalk;
sprite[RIGHT + 8] = spr_PlayerRightIdle;  // Offset by 8 to store idle sprites
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
_up = 0;
_left = 0;
_down = 0;
_right = 0;
_jump = 0;
_hspd = 0;
_vspd = 0;
_input_x = 0;
_input_y = 0;


// Handles generic player movement.
stateFree = function()
{
	// Directional input.
    _input_x = _right - _left;
    _input_y = _down - _up;

    if (_input_x != 0 || _input_y != 0)
    {
		// Prevent faster movement when pressing both directions.
		var length = point_distance(0, 0, _input_x, _input_y);
        if (length > 0)
        {
            _input_x /= length;
            _input_y /= length;
        }

        // Apply acceleration.
        _hspd += _input_x * accel;
        _vspd += _input_y * accel;

        // Cap speed.
        var spd_length = point_distance(0, 0, _hspd, _vspd);
        if (spd_length > move_speed)
		{
            var factor = move_speed / spd_length;
            _hspd *= factor;
            _vspd *= factor;
        }
    }
    else
    {
		// Apply friction.
        _hspd = approach(_hspd, 0, fric);
        _vspd = approach(_vspd, 0, fric);
    }

	// Check for wall collision before applying movement.
    if (!place_meeting(x + _hspd, y + _vspd, par_Wall))
    {
        x += _hspd;
        y += _vspd;
    }
	
	//Set Sprite
    if (_hspd != 0 || _vspd != 0) {
        var move_dir = point_direction(0, 0, _hspd, _vspd);
        // Round to nearest 45° for 8-directional movement
        move_dir = round(move_dir / 45) * 45;
        
        switch (move_dir)
        {
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
        show_debug_message("Setting walking sprite: " + sprite_get_name(sprite_index));
    }
    else
    {
        // Not moving: Use idle sprites
        sprite_index = sprite[face + 8]; // Set idle sprite (offset by 8)
        show_debug_message("Setting idle sprite: " + sprite_get_name(sprite_index));
    }

	// Enter ladder climbing state if ladder is detected.
    if (place_meeting(x, y, obj_Ladder) && _ladder_available && (_up || _down))
    {
        _hspd = 0;
        _vspd = 0;
        state = stateLadder;
    }

	// Cooldown timer after dismounting a ladder.
    if (!_ladder_available)
    {
        _ladder_dismount_timer -= 1;
        if (_ladder_dismount_timer <= 0) _ladder_available = true;
    }
}

// Handles climbing movement on ladders.
stateLadder = function()
{
	sprite_index = spr_PlayerUpWalk;
    var climb_speed = 2;
    var _climb = (_down - _up) * climb_speed;
    y += _climb;

	// Slightly dampen vertical speed when idle on ladder.
    if (_climb == 0) 
	{
		_vspd *= 0.8;
		sprite_index = spr_PlayerUpIdle;
	}
	
	// Dismount ladder when jumping or exiting ladder area.
    if (_jump || !place_meeting(x, y, obj_Ladder))
    {
        _ladder_available = false;
        _ladder_dismount_timer = fps * 0.75;
        _vspd = 0;
        state = stateFree;
    }
}

state = stateFree;