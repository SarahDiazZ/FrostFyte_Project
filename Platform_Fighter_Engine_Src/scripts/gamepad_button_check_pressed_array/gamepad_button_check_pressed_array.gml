///@param {int} device				The device to check
///@param {int/array} button		The button, or array of buttons to check
/*
If a single button is given, it returns true if that button is pressed.
If an array of buttons is given, it returns true if any of those buttons are pressed.
*/
function gamepad_button_check_pressed_array() {
	var _device = argument[0];
	var _button = argument[1];
	if (!is_array(_button))
		{
		return gamepad_button_check_pressed(_device, _button);
		}
	else
		{
		for(var i = 0; i < array_length(_button); i++)
			{
			if (gamepad_button_check_pressed(_device, _button[@ i]))
				{
				return true;
				}
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */