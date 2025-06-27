var percentage_hp = ((_max_hp/_hp)*100);

draw_healthbar(
	10,				// x1
	10,				// y1
	300,			// x2
	50,				// y2
	percentage_hp,	// amount
	c_black,		// backcol
	c_red,			// mincol
	c_lime,			// maxcol
	0,				// direction
	true,			// showback
	true			// showborder
);