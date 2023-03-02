///@category Control Stick
///@param {int} stick			Either <Lstick> or <Rstick>
///@param {int} [frame]			The frame to check. The default is 0 (current)
/*
Returns the direction of the given control stick on the given frame.
This is a number in degrees.
*/
function stick_get_direction() {
	var _frame = argument_count > 1 ? argument[1] : 0;
	var _array = (argument[0] == Lstick) ? control_states_l : control_states_r;
	var _index = (_frame * CONTROL_STICK.LENGTH);
	return round(point_direction(0, 0, _array[@ CONTROL_STICK.xval + _index], _array[@ CONTROL_STICK.yval + _index]));
}
/* Copyright 2023 Springroll Games / Yosi */