function Item(_id, _name, _type, _stackable, _value, sprite) constructor {
	if (is_undefined(sprite)) sprite = noone; // Default.
 
    id    = _id;
    name  = _name;
    type  = _type;			// "weapon", "key", etc.
	stackable = _stackable; // Is stackable? (e.g., currency).
    value = _value;			// damage, price, etc.
	_sprite_index = sprite;

	// How many of this item we have.
	quantity = 0;
}
