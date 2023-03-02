///@category Inputs
///@param {bool} [ignore_sync_mode]			Whether to ignore <replay_sync_mode> (stop checking for desyncs)
/*
Loads input data from the currently selected replay.
You can optionally choose to ignore <replay_sync_mode> data and not check for desyncs, which is useful for certain replay functionality.
*/
function input_replay_load() {
	var _replay = replay_data_get().buffer;
	var _input = obj_game.player_inputs[@ player_number];
	
	//Copy the buffer data over
	buffer_copy(_replay, buffer_tell(_replay), input_buffer_size, _input, 0);
	buffer_seek(_replay, buffer_seek_relative, input_buffer_size);

	//Replay Sync Mode Checking
	if (replay_sync_mode)
		{
		var _x = buffer_read(_replay, buffer_s16);
		var _y = buffer_read(_replay, buffer_s16);
		var _s = buffer_read(_replay, buffer_u8);
		var _h = buffer_read(_replay, buffer_f64);
		var _v = buffer_read(_replay, buffer_f64);
		
		if (argument_count > 0 && argument[0]) then return;
		
		if (x != _x || y != _y || state != _s || hsp != _h || vsp != _v)
			{
			crash(to_string
				(
				"[input_replay_load] ",
				"Desync on frame: ", obj_game.current_frame, 
				". State: ", player_state_name_get(state), " expected ", player_state_name_get(_s), 
				". Player number: ", player_number, 
				". X: ", x, " Y: ", y, " expected ", _x, ", ", _y,
				". H: ", hsp, " V: ", vsp, " expected ", _h, ", ", _v,
				));
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */