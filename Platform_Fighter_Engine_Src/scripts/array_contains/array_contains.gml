///@param {array} array		The array to check
///@param {any} value		The value
/*
Returns true if the given value is in the array.
*/
function array_contains() {
	var _a = argument[0];
	var _v = argument[1];
	var _l = array_length(_a);
	for(var i = 0; i < _l; i++)
		{
		if (_a[@ i] == _v)
			{
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */