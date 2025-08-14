// Initialize variables.
active = true;				// Ignore input/drawing if inactive.
visible = false;			// Tracks whether inventory is visible.

// Panel size (can scale with zoom).
width = 300;				// Default panel width.
height = 400;				// Default panel height.
min_height = 120;			// Minimum panel height in pixels (before zoom).
option_border = 12;			// Padding inside panel.
option_space = 64;			// Spacing per item.
item_text_offset = 4;		// Pixels below the sprite for item name.
text_scale = 1;				// Base text scale.
zoom = 1;					// Dynamic zoom factor.
depth = -100;				// Ensures that it isn't affected by depth sorting.

// Cursor/selection variables.
position = 0;				// Current selected item.
scroll_index = 0;			// Scroll offset.
max_visible_items = floor(height / option_space); // Number of items visible on screen.

// Input edge detection.
prev_up = false;
prev_down = false;
prev_left = false;
prev_right = false;
prev_confirm = false;
last_confirm_time = 0;
confirm_cooldown = 200;      // ms between inputs.

// Font.
font_main = global.font_main;

// Category / submenu system.
ALL_ITEMS = 0;
WEAPONS = 1;
CONSUMABLES = 2;
VALUABLES = 3
menu_level = ALL_ITEMS;        // Default category.

// Category names for display.
category_names = [
    "All Items",		// ALL_ITEMS (includes all items in inventory).
    "Weapons",			// WEAPONS (e.g., staff).
    "Consumables",		// CONSUMABLES (e.g., potions).
	"Valuables"			// VALUABLES (e.g., currency).
];


// Functions
function drawInventoryItem(item, _x, _y, _highlight)
{
    if (_highlight)
    {
        draw_set_color(c_yellow);
        draw_rectangle(_x, _y, _x + width * zoom, _y + option_space * zoom, false);
    }

    draw_set_color(c_white);
    draw_set_font(font_main);

    var item_text = item.name + " (Type: " + string(item.type) + ", Value: " + string(item.value) + ")";
    draw_text_transformed(_x + 8 * zoom, _y + 4 * zoom, item_text, zoom, zoom, 0);

    if (is_undefined(item._sprite_index) == false && item._sprite_index != noone)
    {
        draw_sprite_ext(item._sprite_index, 0, _x + width * zoom - 24 * zoom, _y + 16 * zoom, zoom, zoom, 0, c_white, 1);
    }
}


// Draw panel background using sprite.
function drawPanel(_x, _y)
{
    draw_sprite_ext(sprite_index, image_index, _x + width * zoom / 2, _y + height * zoom / 2, zoom, zoom, 0, c_white, 1);
}


// Function to filter inventory by category.
function getFilteredItems()
{
    var source = global.Inv.items;
    var out = [];
    var source_length = array_length(source);

    for (var i = 0; i < source_length; i++)
    {
        var item = source[i];

        // Keep only valid structs with a 'type'.
        if (!is_struct(item)) continue;
        if (!variable_struct_exists(item, "type")) continue;

        switch (menu_level)
        {
            case WEAPONS:
                if (item.type == "weapon") array_push(out, item);
                break;

            case CONSUMABLES:
                if (item.type == "consumable") array_push(out, item);
                break;

			case VALUABLES:
				if (item.type == "currency" || item.type = "valuables") array_push(out, item);
				break;

            default: // All items section.
                array_push(out, item);
                break;
        }
    }

    return out;
}


// State functions.
stateInventory = function()
{
    if (!visible) return;

    // Position panel in center of screen or over player.
    var panel_x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2 - width * zoom / 2;
    var panel_y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2 - height * zoom / 2;

    // Draw panel background.
    drawPanel(panel_x, panel_y);

    // Draw header text: category + hint.
    draw_set_font(font_main);
    draw_set_color(c_white);
    var header_text = category_names[menu_level] + " (Left/Right to change)";
    draw_text_transformed(panel_x + 8 * zoom, panel_y + 8 * zoom, header_text, zoom, zoom, 0);

    // Draw items with space below header.
    var inv_items = getFilteredItems();
    var inv_size = array_length(inv_items);
    var start_y = panel_y + 32 * zoom; // offset for header

    for (var i = scroll_index; i < min(scroll_index + max_visible_items, inv_size); i++)
    {
        var item = inv_items[i];
        var y_pos = start_y + (i - scroll_index) * option_space * zoom;
        var highlight = (i == position);

        drawInventoryItem(item, panel_x, y_pos, highlight);
    }
}
