if (!active || !visible) return;

// Panel position relative to player.
var panel_x, panel_y;

if (instance_exists(obj_Player)) {
    panel_x = display_get_gui_width()/2 - width * zoom/2;
	panel_y = display_get_gui_height()/2 - height * zoom/2;
}

// Get inventory items.
var inv_items = getFilteredItems();
var inv_size = array_length(inv_items);

// Compute dynamic panel height
var content_height = max(inv_size * option_space * zoom + 32 * zoom, min_height * zoom);

// Draw panel sprite.
draw_sprite_ext(sprite_index, image_index, panel_x + width * zoom / 2, panel_y + content_height / 2, zoom*10, (content_height / height)*10, 0, c_white, 1);

// Draw header.
draw_set_font(font_main);
draw_set_color(c_white);
draw_set_halign(fa_left);
var header_text = category_names[menu_level] + " (A/D to change)";
draw_text_transformed(panel_x + option_border * zoom, panel_y + option_border * zoom, header_text, zoom, zoom, 0);

// Draw items.
var start_y = panel_y + 32 * zoom; // Space below header.

if (inv_size > 0) {
	for (var i = scroll_index; i < min(scroll_index + max_visible_items, inv_size); i++) {
	    var item = inv_items[i];
	    var y_pos = start_y + (i - scroll_index) * option_space * zoom;
	    var highlight = (i == position);

	    // Draw highlight rectangle (covers sprite + name).
	    if (highlight) {
	        draw_set_color(make_color_rgb(255, 255, 180)); // Pastel yellow.
	        draw_set_alpha(0.4);
	        draw_rectangle(panel_x, y_pos, panel_x + width * zoom, y_pos + option_space * zoom, false);
	        draw_set_alpha(1); // Reset alpha.
	    }

	    // Draw item sprite if it exists.
	    if (is_struct(item)) {
	        // Draw sprite centered in slot
	        if (variable_struct_exists(item, "_sprite_index") && item._sprite_index != noone && sprite_exists(item._sprite_index)) {
	            var spr_w = sprite_get_width(item._sprite_index);
	            var spr_h = sprite_get_height(item._sprite_index);

	            var sprite_center_x = panel_x + (width * zoom) / 2;
	            var sprite_center_y = y_pos + (option_space * zoom / 2);

	            draw_sprite_ext(item._sprite_index, 0, sprite_center_x, sprite_center_y-10, zoom, zoom, 0, c_white, 1);

				// Draw text over sprite, centered
	            if (variable_struct_exists(item, "name")) {
					var display_name = item.name;

				    // Show quantity for currency
				    if (item.stackable == true) {
				        display_name += " x" + string(item.quantity); // e.g., "Coin x10"
				    }

	                draw_set_color(c_white);
	                draw_set_halign(fa_center);
	                draw_text_transformed(sprite_center_x, sprite_center_y + 10, display_name, zoom, zoom, 0);
	                draw_set_halign(fa_left); // reset
	            }
			}
	    }
	}
}
