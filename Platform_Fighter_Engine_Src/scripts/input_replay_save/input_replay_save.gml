///@category Inputs
/*
Saves inputs into the current replay buffer. If replay_sync_mode is true, additional information such as position is saved to check for desyncs later.
*/
function input_replay_save() {
	var _replay = replay_data_get().buffer;
	var _input = obj_game.player_inputs[@ player_number];
	
	//Copy the buffer data over
	buffer_copy(_input, 0, input_buffer_size, _replay, buffer_tell(_replay));
	buffer_seek(_replay, buffer_seek_relative, input_buffer_size);
	
	//Replay Sync Mode Saving
	if (replay_sync_mode)
		{
		buffer_write(_replay, buffer_s16, x);
		buffer_write(_replay, buffer_s16, y);
		buffer_write(_replay, buffer_u8, state);
		buffer_write(_replay, buffer_f64, hsp);
		buffer_write(_replay, buffer_f64, vsp);
		}
}
/* Copyright 2023 Springroll Games / Yosi */