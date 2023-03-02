///@category Menu Input System
///@param {real} deadzone		The deadzone, from 0 to 1
/*
Set the control stick deadzone for the Menu Input System.
*/
function mis_controller_deadzone_set() {
	assert(argument[0] >= 0 && argument[0] <= 1, "[mis_controller_deadzone_set] The controller deadzone must be a number from 0 to 1! (", argument[0], ")");
	mis_data().controller_deadzone = argument[0];
	return;
}
/* Copyright 2023 Springroll Games / Yosi */