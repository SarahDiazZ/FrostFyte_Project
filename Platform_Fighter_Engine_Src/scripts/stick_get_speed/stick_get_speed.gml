///@category Control Stick
///@param {int} stick			Either <Lstick> or <Rstick>
///@param {int} [frame]			The frame to check. The default is 0 (current)
/*
Returns the speed of the given control stick on the given frame.
This is normally a number from 0 to 2.
Please note: Some controllers may not return numbers all the way up to 2.
*/
function stick_get_speed() {
	//Grab the cached speed values
	var _frame = argument_count > 1 ? argument[1] : 0;
	var _array = (argument[0] == Lstick) ? control_states_l : control_states_r;
	var _index = (_frame * CONTROL_STICK.LENGTH);
	return _array[@ CONTROL_STICK.spd + _index];
}
/* Copyright 2023 Springroll Games / Yosi */