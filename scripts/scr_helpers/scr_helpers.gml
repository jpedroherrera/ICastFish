// Returns index of value in array or -1 if not found.
function arr_index_of(_arr, _val) {
    var n = array_length(_arr);
    for (var i = 0; i < n; i++)
	{
        if (_arr[i] == _val) return i;
    }
    return -1;
}


// Returns true if value exists in array.
function arr_contains(_arr, _val) {
    return arr_index_of(_arr, _val) != -1;
}


// Append value to array.
function arr_push(_arr, _val) {
    var i = array_length(_arr);
    _arr[i] = _val;
    return _arr; // arrays are values; return the new array for chaining.
}


// Creates UID.
function pickup_make_uid(_room_index, _x, _y, _item_id) {
    var rname = room_get_name(_room_index);
    return string(rname) + "@" + string(floor(_x)) + "," + string(floor(_y)) + "@" + string(_item_id);
}


// Finds vallue between two numbers, approaching the target value at a specified amount.
function approach(val, target, amount) {
    return (val < target) ? min(val + amount, target) : max(val - amount, target);
}