///@param {int} number		The bitflag number
/*
Returns a string of 0s and 1s that represents the bitflag number.
*/
function bitflag_to_string() {
	var _str = "";
	var _num = argument[0];

	while(_num >= 1)
		{
		_str = string(_num % 2) + _str;
		_num /= 2;
		}
	
	return _str;
}
/* Copyright 2023 Springroll Games / Yosi */