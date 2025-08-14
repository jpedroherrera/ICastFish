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
global.Inv = new Inventory(); // from scr_inventory.gml.
global.Collected = [];          // array of pickup UIDs.
