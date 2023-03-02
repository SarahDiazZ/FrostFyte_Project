///@param {int} list			The list index
///@param {any} value			The value to re-add
///@param {bool} [start]		Whether to re-add the value to the start or the end
/*
Deletes a value from the list and adds it back to the end or the start.
If the value is not originally in the list, it is still added.
*/
function ds_list_re_add() {
	var _id = argument[0],
		_value = argument[1],
		_start = argument_count > 2 ? argument[0] : false;

	ds_list_delete(_id, ds_list_find_index(_id, _value));
	if (_start)
		{
		ds_list_insert(_id, 0, _value);
		}
	else
		{
		ds_list_add(_id, _value);
		}
}
/* Copyright 2023 Springroll Games / Yosi */