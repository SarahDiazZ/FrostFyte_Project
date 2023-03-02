///@category Gameplay
///@param {buffer} buffer					The buffer to write the input data to
///@param {id} [id]							The player to get inputs for
///@param {int} [paused_inputs_flag]		Used for storing inputs during Frame Advance
/*
Gets the input for a player, and writes the data to the given buffer.
Uses <game_local_input_write>.
*/
function game_local_input() {
	//Buffers
	var _b = argument[0];
	var _p = argument_count > 1 ? argument[1] : id;
	var _paused_inputs_flag = argument_count > 2 ? argument[2] : 0;
	buffer_seek(_b, buffer_seek_start, 0);
	
	//Device / Custom Control specifications
	var _cc = _p.custom_controls;
	var _d = _p.device;
	var _dt = _p.device_type;
	
	//Temporary variables
	var _flag = _paused_inputs_flag;
	
	game_local_input_write(_b, _d, _dt, _cc, _flag);
	
	return;
}
/* Copyright 2023 Springroll Games / Yosi */