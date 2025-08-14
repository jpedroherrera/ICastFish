// Inventory() -> returns a struct with methods and data.
function Inventory() constructor
{
    items = []; // Array of item structs.

    add_item = function(item)
	{
        // Reject anything that isn't a struct with at least an id and name.
        if (!is_struct(item)) return;
        if (!variable_struct_exists(item, "id"))  return;
        if (!variable_struct_exists(item, "name")) return;

        // Ensure optional members exist.
        if (!variable_struct_exists(item, "_sprite_index")) item._sprite_index = noone;

        if (!has_item(item.id))
        {
            array_push(items, item);
        }
    }

    has_item = function(_id)
	{
        var item_array_length = array_length(items);
	    for (var i = 0; i < item_array_length; i++)
		{
	        var it = items[i];

            // If it's a struct, check the .id field.
			if (is_struct(it) && variable_struct_exists(it, "id") && it.id == _id) return true;
	    }
	    return false;
    };

    remove_item = function(item)
	{
        var i = arr_index_of(items, item);
        if (i != -1) {
            // delete by rebuilding array segment.
            array_delete(items, i, 1); // if not available, you can manual shift.
            return true;
        }
        return false;
    };

	function sanitize()
    {
        for (var i = array_length(items) - 1; i >= 0; i--)
        {
            var it = items[i];
            if (!is_struct(it)) { array_delete(items, i, 1); continue; }
            if (!variable_struct_exists(it, "id"))   { array_delete(items, i, 1); continue; }
            if (!variable_struct_exists(it, "name")) { array_delete(items, i, 1); continue; }
            if (!variable_struct_exists(it, "_sprite_index")) it._sprite_index = noone;
            if (!variable_struct_exists(it, "type")) it.type = "misc";
            if (!variable_struct_exists(it, "value")) it.value = 0;
        }
    }

    count = function(item)
	{
        var counter = 0;
		var item_array_length = array_length(items);

		for (var i = 0; i < item_array_length; i++) {if (items[i] == item) counter++};

        return counter;
    };

    list = function()
	{
        return items; // returns a copy/reference.
    };
}
