///@category Inputs
///@param {int} input_index			The input to reset, from the INPUT enum
///@param {int} [value]				THe value to set the input to
/*
Reset the input buffer for the given input.
By default, this sets the input to the <buffer_time_max>, meaning the game will act as if the input had not been pressed for that many frames.
*/
function input_reset() {
	var _input, _val;
	_input = argument[0];
	_val = argument_count > 1 ? argument[1] : buffer_time_max;

	input_buffer[@ _input] = _val;
}
/* Copyright 2023 Springroll Games / Yosi */