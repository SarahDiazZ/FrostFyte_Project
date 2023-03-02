///@category Inputs
///@param {int} input		The input to check, from the INPUT enum
///@param {bool} [held]		Whether to check if the input is pressed, or held
/*
Checks if the given input is going to be pressed or held for the calling CPU.
*/
function cpu_check_input() {
	var _held = argument_count > 1 ? argument[1] : false;
	return _held
		? cpu_inputs_bitflag & (1 << argument[0] + INPUT.LENGTH)
		: cpu_inputs_bitflag & (1 << argument[0]);
}
/* Copyright 2023 Springroll Games / Yosi */