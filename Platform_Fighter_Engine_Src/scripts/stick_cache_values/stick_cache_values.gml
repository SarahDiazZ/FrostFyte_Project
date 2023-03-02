///@category Control Stick
///@param {int}	stick						Either <Lstick> or <Rstick>
///@param {real} axish						The horizontal axis value
///@param {real} axisv						The vertical axis value
///@param {bool} count						Whether to count the frame numbers for all of the stick properties
///@param {real} [speed_multiplier]			The multiplier to use on the stick speed
/*
Calculates and stores control stick values for later use.
Only use when getting player inputs at the beginning of a frame.
*/
function stick_cache_values() {
	var _stick = argument[0];
	var _x = round_hundredth(argument[1]);
	var _y = round_hundredth(argument[2]);
	var _count = argument[3];
	var _spd_mult = argument_count > 4 ? argument[4] : 1.0;
	
	//Ensure that stick values are not outside the circle
	if (point_distance(0, 0, _x, _y) > 1)
		{
		var _dir = point_direction(0, 0, _x, _y);
		_x = lengthdir_x(1, _dir);
		_y = lengthdir_y(1, _dir);
		}

	var _array = (_stick == Lstick ? control_states_l : control_states_r);

	//Move up previous frame data
	if (_count)
		{
		if (_stick == Lstick)
			{
			control_tilted_l = min(++control_tilted_l, buffer_time_max);
			control_flicked_l = min(++control_flicked_l, buffer_time_max);
			}
		else if (_stick == Rstick)
			{
			control_tilted_r = min(++control_tilted_r, buffer_time_max);
			control_flicked_r = min(++control_flicked_r, buffer_time_max);
			}
		for(var m = (buffer_time_max * CONTROL_STICK.LENGTH) - 1; m >= CONTROL_STICK.LENGTH; m--)
			{
			_array[@ m] = _array[@ m - CONTROL_STICK.LENGTH];
			}
		}
		
	//Change the current data
	_array[@ CONTROL_STICK.xval] = _x;
	_array[@ CONTROL_STICK.yval] = _y;

	//Calculate speed for the current frame based on a previous frame
	var _index = (stick_check_frames * CONTROL_STICK.LENGTH);
	var _xp = _array[@ CONTROL_STICK.xval + _index];
	var _yp = _array[@ CONTROL_STICK.yval + _index];
	_array[@ CONTROL_STICK.spd] = (point_distance(_xp, _yp, _x, _y) * _spd_mult);
}
/* Copyright 2023 Springroll Games / Yosi */