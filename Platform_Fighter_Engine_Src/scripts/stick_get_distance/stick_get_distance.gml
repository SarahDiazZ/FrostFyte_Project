///@category Control Stick
///@param {int} stick			Either <Lstick> or <Rstick>
///@param {int} [frame]			The frame to check. The default is 0 (current)
/*
Returns the distance of the given control stick from the center on the given frame.
This is normally a number from 0 to 1.
Please note: Some controllers may return numbers less than 1, even when the stick is fully pressed in a direction.
*/
function stick_get_distance() {
	var _frame = argument_count > 1 ? argument[1] : 0;
	var _array = (argument[0] == Lstick) ? control_states_l : control_states_r;
	var _index = (_frame * CONTROL_STICK.LENGTH);
	return point_distance(0, 0, _array[@ CONTROL_STICK.xval + _index], _array[@ CONTROL_STICK.yval + _index]);
}
/* Copyright 2023 Springroll Games / Yosi */