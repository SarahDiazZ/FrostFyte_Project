///@category Replays
///@param {string} filename			The file to load a replay from
/*
Loads a replay to be played back by the game.
This function changes the player data, sets the game to be in replay mode, and turns off replay recording.
Please note: This does not actually start the match, it only loads it into memory and changes the game/engine settings.
*/
function replay_load() {
	var _name = version_string + "/" + argument[0];
	if (web_export)
		{
		_name = argument[0];
		}
	
	//Set up the game to run the replay
	setting().replay_mode = true;
	
	//Get the buffer data from the file
	var _compress = buffer_load(_name);
	if (buffer_exists(_compress))
		{
		var _load = buffer_decompress(_compress);
		buffer_seek(_load, buffer_seek_start, 0);

		//Metadata
		replay_load_metadata(_load);
	
		//Player data
		replay_load_players(_load);

		//Load the main replay buffer
		var _size = buffer_read(_load, buffer_u64);
		buffer_reset(replay_data_get().buffer, false);
		buffer_resize(replay_data_get().buffer, _size);
		buffer_copy(_load, buffer_tell(_load), _size, replay_data_get().buffer, 0);
		buffer_seek(replay_data_get().buffer, buffer_seek_start, 0);
	
		//Destroy the buffers
		buffer_delete(_compress);
		buffer_delete(_load);
		}
	else
		{
		crash("[replay_load] Replay has failed to load because the file does not exist! (", _name, ")");
		}
}
/* Copyright 2023 Springroll Games / Yosi */