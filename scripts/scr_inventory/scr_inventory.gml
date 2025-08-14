// Inventory() -> returns a struct with methods and data.
function Inventory() constructor
{
    items = []; // can be strings or item structs.

    add_item = function(item)
	{
        var i = array_length(items);
        items[i] = item;
    }

    has_item = function(_id)
	{
        var n = array_length(items);
	    for (var i = 0; i < n; i++)
		{
	        // If it's a struct, check the .id field.
	        if (is_struct(items[i]) && items[i].id == _id) return true;

			// Fallback for string storage.
	        if (items[i] == _id) return true;
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

    count = function(item)
	{
        var c = 0, n = array_length(items);
        for (var i = 0; i < n; i++) {if (items[i] == item) c++};
        return c;
    };

    list = function()
	{
        return items; // returns a copy/reference.
    };
}
