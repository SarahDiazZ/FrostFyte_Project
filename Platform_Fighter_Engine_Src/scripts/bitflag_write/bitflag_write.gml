///@param {int} number		The bitflag number
///@param {int} pos			The position in the bitflag
///@param {int} [value]		The value to set the position in the bitflag to, should be either 0 or 1
/*
Sets a specific position in a bitflag to the given value, which can be either 0 or 1.
You can also use the constants false and true, which are the same as 0 and 1 in GML.
*/
function bitflag_write() {

	var _num = argument[0],
		_pos = argument[1],
		_val = argument_count > 2 ? argument[2] : 1;
	
	if (_val)
		{
		return _num | (1 << _pos);
		}
	else
		{
		return _num & ~(1 << _pos);
		}
}
/* Copyright 2023 Springroll Games / Yosi */