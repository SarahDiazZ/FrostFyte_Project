///@category Control Stick
///@param {int} stick			Either <Lstick> or <Rstick>
///@param {int} direction		The direction to check, from the DIR enum
///@param {int} [frame]			The frame to check. The default is 0 (current)
/*
Returns how far the given control stick is pointed in the given direction on the given frame.
This function has slighly different behavior depending on the direction given:
	- Horizontal : Returns a number from -1 to 1, with -1 being left and 1 being right
	- Vertical : Returns a number from -1 to 1, with -1 being up and 1 being down
	- Left/Right/Up/Down : Returns a number from 0 to 1, being how far the stick is from the center in that direction.
	- Any : Returns a number from 0 to 1, being the distance of the stick from the center. This is essentially the same as using the <stick_get_distance> function.
*/
function stick_get_value() {
	var _frame = argument_count > 2 ? argument[2] : 0;
	var _array = (argument[0] == Lstick) ? control_states_l : control_states_r;
	var _index = (_frame * CONTROL_STICK.LENGTH);
	var _stick_x = _array[@ CONTROL_STICK.xval + _index];
	var _stick_y = _array[@ CONTROL_STICK.yval + _index];

	switch(argument[1])
		{
		case DIR.horizontal:
			return _stick_x;
			break;
		case DIR.left:
			return _stick_x < 0 ? abs(_stick_x) : 0;
			break;
		case DIR.right:
			return _stick_x > 0 ? _stick_x : 0;
		case DIR.vertical:
			return _stick_y;
			break;
		case DIR.down:
			return _stick_y > 0 ? _stick_y : 0;
			break;
		case DIR.up:
			return _stick_y < 0 ? abs(_stick_y) : 0;
			break;
		case DIR.any:
			return point_distance(0, 0, _stick_x, _stick_y);
			break;
		case DIR.none:
			return 0;
			break;
		default: crash("[stick_get_value] Direction is invalid (", argument[1], ")"); break;
		}
	return 0;
}
/* Copyright 2023 Springroll Games / Yosi */