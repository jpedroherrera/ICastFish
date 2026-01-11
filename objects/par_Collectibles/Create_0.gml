// All collectibles have these defaults
persistent = false;					// Will be true for items that stay in room (like weapons). --> GML built-in
autopickup = true;					// Default auto pickup.
item_persistent = false;			// Should this item survive room changes? (child can override). --> logical flag
has_been_picked_up = false;			// Flag to not send more than one post_pickup message.
has_specific_post_pickup = false;	// Runs default post-pickup.

// Compute deterministic UID for THIS placed instance.
uid = pickup_make_uid(room, x, y, item_id);

// If we already took this pickup earlier, delete self immediately.
if (arr_contains(global.Collected, uid)) {
    // Only destroy if item is NOT supposed to persist
    if (!item_persistent) instance_destroy();
    exit;
}


// This adds an item to inventory.
function add_to_inventory() {
	// Creates an item struct.
    var item = new Item(item_id, item_name, item_type, item_is_stackable, item_value, item_sprite);
	item.quantity += 1;

	// Stackable logic.
    var inv_items = global.Inv.items;
    var added = false;

    // Loop through inventory
    for (var i = 0; i < array_length(inv_items); i++) {
        var inv_item = inv_items[i];

        // If item is same type and stackable
        if (inv_item.stackable == true && item.stackable == true) {
            // Increase quantity/value instead of adding new entry
            inv_item.quantity += item.quantity;
            added = true;
            break; // done
        }
    }

    // If not stacked, add as new entry
    if (!added) {
        global.Inv.add_item(item);
    }

    // Record collection so it won't respawn (for this run)
    global.Collected = arr_push(global.Collected, uid);

    // Decide if the instance should persist or be destroyed
    if (item_persistent) {
        persistent = true;  // survives room changes
    }
    else {
        instance_destroy(); // normal pickups get destroyed
    }
}
