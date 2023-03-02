///@category Control Stick
///@param {int} stick					Either <Lstick> or <Rstick>
///@param {real} [direction]			The direction to check for, from the DIR enum
///@param {real} [buffer_time]			How far back to check
///@param {bool} [delete_input]			Whether to "delete" the flick input or not
///@param {int} [stick_check_type]		The type of checking to use, from the enum STICK_CHECK_TYPE
/*
Returns true if the given control stick was flicked.
You can specify which direction to check for, how many frames back to count, and whether the flick should be deleted or not.
There are 2 possible stick check types:
	- Current : Checks the current direction of the control stick, even if the flick was in the past
	- Backwards: Checks the direction of the control stick on the exact frame it was flicked
*/
function stick_flicked() {
	//Get the index of the sticks on the input buffer
	var _stick = argument[0];
	var _dir = argument_count > 1 ? argument[1] : undefined;
	var _time = (_stick == Lstick ? control_flicked_l : control_flicked_r);
	var _buff = argument_count > 2 ? argument[2] : stick_flick_buff;
	var _del = argument_count > 3 ? argument[3] : true;
	var _type = argument_count > 4 ? argument[4] : stick_check_type;
	if (_time <= _buff)
		{
		if (argument_count > 1)
			{
			//Stick check type
			if (_type == STICK_CHECK_TYPE.backwards)
				{
				//Check direction of the stick on the exact frame it was flicked
				if (stick_direction(_stick, _dir, _time))
					{
					if (_stick == Lstick) 
						{
						if (_del) then control_flicked_l = buffer_time_max;
						}
					else 
						{
						if (_del) then control_flicked_r = buffer_time_max;
						}
					return true;
					}
				}
			else if (_type == STICK_CHECK_TYPE.current)
				{
				//Check direction of the stick on the current frame
				if (stick_direction(_stick, _dir, 0))
					{
					if (_stick == Lstick) 
						{
						if (_del) then control_flicked_l = buffer_time_max;
						}
					else 
						{
						if (_del) then control_flicked_r = buffer_time_max;
						}
					return true;
					}
				}
			return false;
			}
		else
			{
			if (_stick == Lstick) 
				{
				control_flicked_l = buffer_time_max;
				}
			else 
				{
				control_flicked_r = buffer_time_max;
				}
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */