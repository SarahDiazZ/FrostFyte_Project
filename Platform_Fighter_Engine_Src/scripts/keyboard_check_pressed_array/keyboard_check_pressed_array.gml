///@param {int/array} key		The key, or array of keys to check
/*
If a single key is given, it returns true if that key is pressed.
If an array of keys is given, it returns true if any of those keys are pressed.
*/
function keyboard_check_pressed_array() {
	var _key = argument[0];
	if (!is_array(_key))
		{
		return keyboard_check_pressed(_key);
		}
	else
		{
		for(var i = 0; i < array_length(_key); i++)
			{
			if (keyboard_check_pressed(_key[@ i]))
				{
				return true;
				}
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */