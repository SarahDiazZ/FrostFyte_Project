///@category Inputs
///@param {int} input_index			The input to check for, from the INPUT enum
///@param {int} [buffer_time]		How many frames back to check for a held input
/*
Checks if the player has held a button or key that was mapped to the given input.
If you want to check for pressed inputs, use <button>.
*/
function input_held() {
	var _input, _buffer;
	_input = argument[0] + INPUT.LENGTH;
	_buffer = argument_count > 1 ? argument[1] : 0;
	
	assert(_buffer < buffer_time_max, "[input_held] buffer_time (", _buffer, ") is larger than or equal to the preset buffer_time_max (", buffer_time_max, ")");

	//Checks if the input has been pressed within the time
	if (input_buffer[@ _input] <= _buffer)
		{
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */