// Player Attributes
_hp = 100;
_max_hp = 100;
_magica = 100;
_max_magica = 100;

// Player Characteristics
_acceleration = 4;
_invincibility = false;
_invincibility_timer = fps;
_ladder_available = true;
_ladder_dismount_timer = 0; // Initialize to 0 (no delay until dismount)

// State Machine
var _up;
var _left;
var _down;
var _right;
var _jump;
var _hspd;
var _vspd;

stateFree = function()
{
    _hspd = _right - _left;
    _vspd = _down - _up;

    if (_hspd != 0 || _vspd != 0)
    {
        var _spd = 4;
        var _dir = point_direction(0, 0, _hspd, _vspd);
        var _xadd = lengthdir_x(_spd, _dir);
        var _yadd = lengthdir_y(_spd, _dir);
    
        // Wall Collision Physics
        if (!place_meeting(x + _xadd, y + _yadd, par_Wall))
        {
            x += _xadd;
            y += _yadd;
        }
    }
    
    // Ladder Interaction
    if (place_meeting(x, y, obj_Ladder) && _ladder_available && _vspd != 0)
    {
        _hspd = 0;
        _vspd = 0;
        state = stateLadder;
    }

    // Handle Ladder Dismount Timer
    if (!_ladder_available)
    {
        _ladder_dismount_timer -= 1;
        if (_ladder_dismount_timer <= 0)
        {
            _ladder_available = true;
        }
    }
}

stateLadder = function()
{
    var _climb = (_down - _up) * _acceleration;
    y += _climb;

    if (_climb == 0)
    {
        _vspd *= 0.8;
    }
    
    // Exit Ladder State
    if (_jump != 0 || !place_meeting(x, y, obj_Ladder))
    {
        _ladder_available = false;
        _ladder_dismount_timer = fps * 0.75;
        _vspd = 0;
        state = stateFree;
    }
}

state = stateFree;