///@category Control Stick
///@param {int} stick					Either <Lstick> or <Rstick>
///@param {real} [direction]			The direction to check for, from the DIR enum
///@param {real} [buffer_time]			How far back to check
///@param {int} [stick_check_type]		The type of checking to use, from the enum STICK_CHECK_TYPE
/*
Returns true if the given control stick was tilted.
You can specify which direction to check for and how many frames back to count.
There are 2 possible stick check types:
	- Current : Checks the current direction of the control stick, even if the tilt was in the past
	- Backwards: Checks the direction of the control stick on the exact frame it was tilted
*/
function stick_tilted() {
	//Get the index of the sticks on the input buffer
	var _stick = argument[0];
	var _dir = argument_count > 1 ? argument[1] : undefined;
	var _time = (_stick == Lstick ? control_tilted_l : control_tilted_r);
	var _buff = argument_count > 2 ? argument[2] : 0;
	var _type = argument_count > 3 ? argument[3] : stick_check_type;
	if (_time <= _buff)
		{
		if (argument_count > 1)
			{
			//Stick check type
			if (_type == STICK_CHECK_TYPE.backwards)
				{
				//Check direction of the stick on the frame it was tilted
				if (stick_direction(_stick, _dir, _time))
					{
					return true;
					}
				}
			else if (_type == STICK_CHECK_TYPE.current)
				{
				//Check direction of the stick on the current frame
				if (stick_direction(_stick, _dir, 0))
					{
					return true;
					}
				}
			return false;
			}
		else
			{
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */