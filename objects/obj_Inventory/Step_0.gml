if (!active) return;

// Toggle inventory with TAB key.
if (keyboard_check_pressed(vk_tab))
{
    visible = !visible;
}

if (visible)
{
    var inv_items = getFilteredItems();
    var inv_size = array_length(inv_items);

    // Read key states.
    var up = keyboard_check(ord("W"));
    var down = keyboard_check(ord("S"));
    var left = keyboard_check(ord("A"));
    var right = keyboard_check(ord("D"));
    var confirm = keyboard_check(vk_enter);

    var up_pressed = up && !prev_up;
    var down_pressed = down && !prev_down;
    var left_pressed = left && !prev_left;
    var right_pressed = right && !prev_right;
    var confirm_pressed = confirm && !prev_confirm;

    prev_up = up;
    prev_down = down;
    prev_left = left;
    prev_right = right;
    prev_confirm = confirm;

    // Navigate selection.
    if (up_pressed)
    {
        position -= 1;
        if (position < 0) position = inv_size - 1;
        if (position < scroll_index) scroll_index = position;
    }

    if (down_pressed)
    {
        position += 1;
        if (position >= inv_size) position = 0;
        if (position >= scroll_index + max_visible_items) scroll_index = position - max_visible_items + 1;
    }

    // Change category with left/right arrows.
    if (left_pressed)
    {
        menu_level -= 1;
        if (menu_level < ALL_ITEMS) menu_level = CONSUMABLES;
        position = 0; scroll_index = 0;
    }
    if (right_pressed)
    {
        menu_level += 1;
        if (menu_level > array_length(category_names)-1) menu_level = ALL_ITEMS;
        position = 0; scroll_index = 0;
    }

    // Use or inspect item.
    if (confirm_pressed && current_time - last_confirm_time >= confirm_cooldown)
    {
        last_confirm_time = current_time;
        if (position < inv_size)
        {
            var item = inv_items[position];
            show_message("Using or inspecting " + item.name);
        }
    }
};
