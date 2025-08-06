// Font settings.
draw_set_font(global.font_main);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

// Dynamically get width and height of menu.
var max_width = 0;
var max_height = 0;

for (var i = 0; i < option_length; i++)
{
	var option_width = string_width(option[menu_level, i]);
	var option_height = string_height(option[menu_level, i]);
    max_width = max(max_width, option_width);
    max_height = max(max_height, option_height);
}

width = max_width + option_border*2;
height = option_border * 2 + max_height * option_length + option_space * (option_length - 1);

// Center menu.
x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2 - width / 2;
y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2 - height / 2;

// Draw menu background.
draw_sprite_ext(sprite_index, image_index, x, y, width/sprite_width, height/sprite_height, 0, c_white, 1);

// Draw the options.
for (var i = 0; i < option_length; i++)
{
	var color = c_white;
	if (position == i) color = c_yellow;
	
	draw_text_color(x + option_border, y + option_border + (max_height + option_space) * i , option[menu_level, i], color, color, color, color, 1);
}