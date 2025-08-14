function Item(_id, _name, _type, _value, sprite) constructor
{
	if (is_undefined(sprite)) sprite = noone; // Default.
 
    id    = _id;
    name  = _name;
    type  = _type;  // "weapon", "key", etc.
    value = _value; // damage, price, etc.
	_sprite_index = sprite;
}
