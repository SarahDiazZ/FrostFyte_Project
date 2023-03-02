///@category Inputs
///@param {buffer} buffer		The index of the buffer to take inputs from for the input buffer
///@param {bool} [count]		Whether to count the frame numbers for the general input buffer
/*
Adds data from the given buffer to the calling player's input buffer, and calculates stick variables.
*/
function input_update() {
	var _b = argument[0];
	var _count = argument_count > 1 ? argument[1] : true;
	buffer_seek(_b, buffer_seek_start, 0);
	
	//Loop through the inputs
	var _flag = buffer_read(_b, buffer_u32);
	for(var i = 0; i < (INPUT.LENGTH * 2); i++)
		{
		if (bitflag_read(_flag, i))
			{
			input_buffer[@ i] = 0;
			}
		else
			{
			if (_count)
				{
				input_buffer[@ i] = min(input_buffer[@ i] + 1, buffer_time_max);
				}
			}
		}

	//Control stick data
	var _lx = (real(buffer_read(_b, buffer_s8)) / 100.0);
	var _ly = (real(buffer_read(_b, buffer_s8)) / 100.0);
	var _rx = (real(buffer_read(_b, buffer_s8)) / 100.0);
	var _ry = (real(buffer_read(_b, buffer_s8)) / 100.0);
	
	//ACS Modifiers
	var _min = acs[@ ACS.deadzone_l];
	var _range = (1 - _min) * acs[@ ACS.maximum_l];
	var _invert_x = acs[@ ACS.invert_x_l];
	var _invert_y = acs[@ ACS.invert_y_l];
	_lx = sign(_lx) * clamp((abs(_lx) - _min) / _range, 0, 1);
	if (_invert_x) then _lx *= -1;
	_ly = sign(_ly) * clamp((abs(_ly) - _min) / _range, 0, 1);
	if (_invert_y) then _ly *= -1;
	
	var _min = acs[@ ACS.deadzone_r];
	var _range = (1 - _min) * acs[@ ACS.maximum_r];
	var _invert_x = acs[@ ACS.invert_x_r];
	var _invert_y = acs[@ ACS.invert_y_r];
	_rx = sign(_rx) * clamp((abs(_rx) - _min) / _range, 0, 1);
	if (_invert_x) then _rx *= -1;
	_ry = sign(_ry) * clamp((abs(_ry) - _min) / _range, 0, 1);
	if (_invert_y) then _ry *= -1;
	
	stick_cache_values
		(
		scs[@ SCS.switch_sticks] ? Rstick : Lstick, 
		acs[@ ACS.rotate_l] ? _ly : _lx, 
		acs[@ ACS.rotate_l] ? _lx : _ly, 
		_count,
		acs[@ ACS.speed_l],
		);
	stick_cache_values
		(
		scs[@ SCS.switch_sticks] ? Lstick : Rstick, 
		acs[@ ACS.rotate_r] ? _ry : _rx, 
		acs[@ ACS.rotate_r] ? _rx : _ry, 
		_count,
		acs[@ ACS.speed_r],
		);
	
	var _dist = stick_get_distance(Lstick);
	if (_dist > stick_flick_amount &&
		stick_get_speed(Lstick) > stick_flick_speed && !scs[@ SCS.auto_walk] &&
		control_flicked_l > stick_flick_cooldown)
		{
		control_flicked_l = 0;
		}
	if (_dist > stick_tilt_amount)
		{
		control_tilted_l = 0;
		}
	
	var _dist = stick_get_distance(Rstick);
	if (_dist > rstick_flick_amount &&
		stick_get_speed(Rstick) > rstick_flick_speed &&
		control_flicked_r > stick_flick_cooldown)
		{
		input_buffer[@ right_stick_input] = 0;
		control_flicked_r = 0;
		}
	if (_dist > rstick_tilt_amount)
		{
		input_buffer[@ right_stick_input + INPUT.LENGTH] = 0;
		control_tilted_r = 0;
		}
		
	//Double Tap
	if (scs[@ SCS.double_tap])
		{
		//Running
		if (abs(stick_get_value(Lstick, DIR.horizontal, 0)) >= stick_flick_amount)
			{
			if (double_tap_run_frame < double_tap_buffer_time)
				{
				if (abs(stick_get_distance(Lstick, 1)) < stick_flick_amount)
					{
					control_flicked_l = 0;
					}
				}
			else
				{
				double_tap_run_frame = 0;
				}
			}
		else
			{
			double_tap_run_frame = min(++double_tap_run_frame, buffer_time_max);
			}
		//Fastfalling
		if (stick_get_value(Lstick, DIR.down, 0) >= stick_flick_amount)
			{
			if (double_tap_fastfall_frame < double_tap_buffer_time)
				{
				if (abs(stick_get_distance(Lstick, 1)) < stick_flick_amount)
					{
					control_flicked_l = 0;
					}
				}
			else
				{
				double_tap_fastfall_frame = 0;
				}
			}
		else
			{
			double_tap_fastfall_frame = min(++double_tap_fastfall_frame, buffer_time_max);
			}
		}
		
	//Run modifier
	if (input_buffer[@ INPUT.run + INPUT.LENGTH] == 0)
		{
		if (scs[@ SCS.auto_walk])
			{
			if (control_tilted_l == 0)
				{
				control_flicked_l = 0;
				}
			}
		else
			{
			if (control_flicked_l == 0)
				{
				control_flicked_l = buffer_time_max;
				control_tilted_l = 0;
				}
			}
		}
		
	//Tap Jump
	if (scs[@ SCS.tap_jump])
		{
		var _current = stick_get_value(Lstick, DIR.up, 0);
		var _previous = stick_get_value(Lstick, DIR.up, 1);
		if (_current >= stick_flick_amount)
			{
			if (_previous < stick_flick_amount)
				{
				if (stick_flicked(Lstick, DIR.up, 0, false))
					{
					//Only press the jump input if the stick was flicked, and don't count buffered flicks
					input_buffer[@ INPUT.jump] = 0;
					}
				}
			
			//Hold the jump input as long as the stick is tilted upwards
			input_buffer[@ INPUT.jump + INPUT.LENGTH] = 0;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */