// Create surface if it doesn't exist.
if (surface_exists(lighting_surface) == false)
{
	lighting_surface = surface_create(room_width, room_height);
}


// Drawing the surface.
surface_set_target(lighting_surface);

draw_clear_alpha(c_black, 0.6);

with (obj_LightingCutout)
{
	var wobble_amount_x = image_xscale + random_range(-wobble, wobble);
	var wobble_amount_y = image_yscale + random_range(-wobble, wobble);
	
	gpu_set_blendmode(bm_subtract);
	draw_sprite_ext(sprite_index, image_index, x, y, wobble_amount_x, wobble_amount_y, 0, c_white, 1);
		
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(sprite_index, image_index, x, y, wobble_amount_x, wobble_amount_y, 0, color, intensity);
		
	gpu_set_blendmode(bm_normal);
}

var ember_wobble = 0.05;

with (obj_Ember)
{
	var wobble_amount_x = image_xscale + random_range(-ember_wobble, ember_wobble);
	var wobble_amount_y = image_yscale + random_range(-ember_wobble, ember_wobble);

	var ember_size = image_xscale*random_range(0.1, 0.5);
	
	gpu_set_blendmode(bm_subtract);
	draw_sprite_ext(spr_LightCutout, image_index, x, y, (ember_size*wobble_amount_x), (ember_size*wobble_amount_y), 0, c_white, 1);
		
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(spr_LightCutout, image_index, x, y, (ember_size*wobble_amount_x), (ember_size*wobble_amount_y), 0, c_orange, image_alpha);
		
	gpu_set_blendmode(bm_normal);
}

surface_reset_target();

draw_surface(lighting_surface, 0, 0);
