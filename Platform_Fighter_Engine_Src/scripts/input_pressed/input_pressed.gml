///@category Inputs
///@param {int} input_index			The input to check for, from the INPUT enum
///@param {int} [buffer_time]		How many frames back to check for a press
///@param {bool} [delete_input]		Whether to "delete" the pressed input or not. By default, the input is deleted
/*
Checks if the player has pressed a button or key that was mapped to the given input.
If you want to check for held inputs, use <input_held>.
*/
function input_pressed() {
	var _input, _buffer, _delete;
	_input = argument[0];
	_buffer = argument_count > 1 ? argument[1] : buffer_time_standard;
	_delete = argument_count > 2 ? argument[2] : true;

	assert(_buffer < buffer_time_max, "[input_pressed] buffer_time (", _buffer, ") is larger than or equal to the preset buffer_time_max (", buffer_time_max, ")");

	//Checks if the input has been pressed within the time
	if (input_buffer[@ _input] <= _buffer)
		{
		if (_delete) then input_buffer[@ _input] = buffer_time_max;
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */