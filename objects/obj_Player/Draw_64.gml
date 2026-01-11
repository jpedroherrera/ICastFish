// Healthbar
var percentage_hp = ((hp/max_hp)*100);

draw_healthbar(
	10,				// x1
	10,				// y1
	300,			// x2
	30,				// y2
	percentage_hp,	// amount
	c_black,		// backcol
	c_red,			// mincol
	c_lime,			// maxcol
	0,				// direction
	true,			// showback
	true			// showborder
);

// Health Number (debug maybe || unsure if this will be a permanent feature)
// Display the score variable with a label
draw_text(350, 20, "Health: " + string(percentage_hp));

// Magica Bar
var percentage_magica = ((max_magica/magica)*100);

draw_healthbar(
	10,					// x1
	40,					// y1
	300,				// x2
	60,				// y2
	percentage_magica,	// amount
	c_black,			// backcol
	c_teal,				// mincol
	c_navy,				// maxcol
	0,					// direction
	true,				// showback
	true				// showborder
);