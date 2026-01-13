// Dash gauge position in relation to player.
x = obj_Player.x + 8;
y = obj_Player.y - 10;

// Poorly made way to execute the charging effect of the dash gauge. Subject to change.
if obj_Player.dodge_timer >= 96
{
	image_index = 0;
}
if obj_Player.dodge_timer <= 95 && obj_Player.dodge_timer >= 72
{
	image_index = 1;	
}
if obj_Player.dodge_timer <= 71 && obj_Player.dodge_timer >= 48
{
	image_index = 2;	
}
if obj_Player.dodge_timer <= 47 && obj_Player.dodge_timer >= 24
{
	image_index = 3;
}
if obj_Player.dodge_timer <= 23 && obj_Player.dodge_timer >= 0
{
	image_index = 4;	
}

// Make the gauge disappear after a short while after being charged.
if obj_Player.dodge_timer < 0
{
	visibility_timer --;	
}
else if obj_Player.dodge_timer >= 0
{
	visibility_timer = visibility_timer_max;	
}

if visibility_timer <= 0
{
	visible = false;	
}
else visible = true;