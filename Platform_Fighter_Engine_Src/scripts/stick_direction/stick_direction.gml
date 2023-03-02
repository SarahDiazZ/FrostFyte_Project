///@category Control Stick
///@param {int} stick			Either <Lstick> or <Rstick>
///@param {real} direction		The direction to check for, from the DIR enum
///@param {int} [frame]			The frame to check on
/*
Returns true if the stick was pointed in the given direction on the given frame.
By default, it checks frame 0, the current frame.
The threshold for directions is determined by the <stick_direction_sens>.
*/
function stick_direction() {
	var _frame = argument_count > 2 ? argument[2] : 0;
	var _stick_dir = stick_get_direction(argument[0], _frame);
	switch(argument[1])
		{
		case DIR.horizontal:
			if (abs(angle_difference(0, _stick_dir)) < stick_direction_sens ||
				abs(angle_difference(180, _stick_dir)) < stick_direction_sens)
				{
				return true;
				}
			break;
		case DIR.right:
			if (abs(angle_difference(0, _stick_dir)) < stick_direction_sens) then return true;
			break;
		case DIR.left:
			if (abs(angle_difference(180, _stick_dir)) < stick_direction_sens) then return true;
			break;
		case DIR.vertical:
			if (abs(angle_difference(270, _stick_dir)) < stick_direction_sens ||
				abs(angle_difference(90, _stick_dir)) < stick_direction_sens)
				{
				return true;
				}
			break;
		case DIR.down:
			if (abs(angle_difference(270, _stick_dir)) < stick_direction_sens) then return true;
			break;
		case DIR.up:
			if (abs(angle_difference(90, _stick_dir)) < stick_direction_sens) then return true;
			break;
		case DIR.any:
			return true;
			break;
		case DIR.none:
			return false;
			break;
		default: crash("[stick_direction] Direction is invalid (", argument[1], ")"); break;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */