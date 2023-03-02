///@category Control Stick
///@param {int} stick				Either <Lstick> or <Rstick>
///@param {bool} [tilt]				Whether to check if the stick was tilted or not
///@param {bool} [flick]			Whether to check if the stick was flicked or not
///@param {real} [dir]				The direction to check, from the DIR enum
///@param {real} [spd]				The minimum speed
///@param {real} [dist]				The minimum distance
///@param {int} [frames_back]		The number of frames back to check
///@param {bool} [single_frame]		Whether only a single frame should be checked, or every frame back
/*
Returns the frame number in which all of the conditions were met. If no frame is found, it returns -1.
This is essentially a combination of all the other stick functions, and an advanced version of <stick_find_frame>.
*/
function stick_find_frame() {
	var _stick = argument[0];

	//Get correct variables for each stick
	var _array, _tilt, _flick;
	if (_stick == Lstick)
		{
		_array = control_states_l;
		_tilt = control_tilted_l;
		_flick = control_flicked_l;
		}
	else
		{
		_array = control_states_r;
		_tilt = control_tilted_r;
		_flick = control_flicked_r;
		}

	//Figure out what has to be checked
	var _check_tilt = argument_count > 1 ? argument[1] : false;
	var _check_flick= argument_count > 2 ? argument[2] : false;
	var _check_dir  = argument_count > 3 ? argument[3] : undefined;
	var _check_spd  = argument_count > 4 ? argument[4] : undefined;
	var _check_dist = argument_count > 5 ? argument[5] : undefined;
	var _frames     = argument_count > 6 ? argument[6] : buffer_time_standard;
	var _single     = argument_count > 7 ? argument[7] : false;
	var _index = 0;

	//Check if the control stick meets all of the given requirements in the past frames
	var _start = (_single) ? _frames : 0;
	var _end = (_single) ? _frames : _frames;
	for(var i = _start; i <= _end; i++)
		{
		//Get the control state for that frame
		_index = (i * CONTROL_STICK.LENGTH);
	
		if (_check_tilt)
			{
			if (_tilt > i) continue;
			}
		
		if (_check_flick)
			{
			if (_flick != i) continue;
			}
	
		if (!is_undefined(_check_dir))
			{
			if (!stick_direction(_stick, _check_dir, i)) continue;
			}
	
		if (!is_undefined(_check_spd))
			{
			if (_array[@ CONTROL_STICK.spd + _index] < _check_spd) continue;
			}
	
		if (!is_undefined(_check_dist))
			{
			if (point_distance(0, 0, _array[@ CONTROL_STICK.xval + _index], _array[@ CONTROL_STICK.yval + _index]) < _check_dist) continue;
			}
		
		return i;
		}
		
	return -1;
}
/* Copyright 2023 Springroll Games / Yosi */