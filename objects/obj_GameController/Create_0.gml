// Ensure singleton if someone accidentally placed two.
if (instance_exists(obj_GameController) && instance_number(obj_GameController) > 1)
{
    instance_destroy();
    exit;
}

// General Game Settings.
window_set_fullscreen(true);
window_set_cursor(cr_none);

// Player inventory.
// Inventory variables.
global.Inv = new Inventory();	// from scr_inventory.gml.
global.Inv.sanitize();			// Ensures a clean inventory.
global.Collected = [];          // Array of pickup UIDs.
