///@param {int} number		The bitflag number
///@param {int} pos			The position in the bitflag
/*
Returns the value of a bitflag at the given position. The value is either 0 or 1.
*/
function bitflag_read() {
	var _num = argument[0],
		_pos = argument[1];
	
	return (_num >> _pos) & 1;
}
/* Copyright 2023 Springroll Games / Yosi */