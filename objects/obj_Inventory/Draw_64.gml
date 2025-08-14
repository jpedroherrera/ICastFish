if (!active || !visible)
{
    draw_set_color(c_red);
    draw_text(32,32,"Inventory invisible or inactive");
    return;
}

// Panel position relative to player.
var panel_x, panel_y;

if (instance_exists(obj_Player))
{
    // Panel follows player.
    panel_x = (obj_Player.x - camera_get_view_x(view_camera[0])) - width*zoom/2;
    panel_y = (obj_Player.y - camera_get_view_y(view_camera[0])) - height*zoom/2;
}
else
{
    // Fallback: center of GUI.
    panel_x = display_get_gui_width()/2 - width*zoom/2;
    panel_y = display_get_gui_height()/2 - height*zoom/2;
}


var inv_items = getFilteredItems();
var inv_size = array_length(inv_items);

// Compute dynamic panel height
var content_height = max(inv_size * option_space * zoom + 32*zoom, min_height * zoom);
var panel_height_draw = content_height;

// Draw panel sprite.
draw_sprite_ext(sprite_index, image_index, panel_x + width*zoom/2, panel_y + panel_height_draw/2, zoom, panel_height_draw/height, 0, c_white, 1);

// Draw header.
draw_set_font(font_main);
draw_set_color(c_white);
var header_text = category_names[menu_level] + " (Left/Right to change)";
draw_text_transformed(panel_x + option_border*zoom, panel_y + option_border*zoom, header_text, zoom, zoom, 0);

// Draw items.
var start_y = panel_y + 32*zoom; // Space below header.

for (var i = scroll_index; i < min(scroll_index + max_visible_items, inv_size); i++)
{
    var item = inv_items[i];
    var y_pos = start_y + (i - scroll_index) * option_space * zoom;
    var highlight = (i == position);

    // Draw highlight rectangle (covers sprite + name).
    if (highlight)
    {
        draw_set_color(c_yellow);
        draw_rectangle(panel_x, y_pos, panel_x + width*zoom, y_pos + option_space*zoom, false);
    }

    // Draw item sprite if it exists.
    if (is_struct(item))
    {
        if (struct_has_member(item, "_sprite_index") && item._sprite_index != noone)
		{
		    draw_sprite_ext(item._sprite_index, 0, panel_x + 16*zoom, y_pos + 16*zoom, zoom, zoom, 0, c_white, 1);
		}

	    // Draw item name below sprite.
	    if (struct_has_member(item, "name"))
        {
            draw_set_color(c_white);
            draw_text_transformed(panel_x + 16*zoom, y_pos + 32*zoom + item_text_offset, item.item_name, zoom, zoom, 0);
        }
    }
}
