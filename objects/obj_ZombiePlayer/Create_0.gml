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

// Handles generic enemy movement.
stateFree = function()
{
	
	
	set_enemy_sprite(self, x, y, phy_speed_x, phy_speed_y, xprevious, yprevious);
}