///@category Replays
///@param {buffer} replay			The buffer to save game metadata to
/*
Saves game metadata to a replay buffer. Used in <replay_save>, and should not be called independently.
*/
function replay_save_metadata() {
	var _b = argument[0];
	
	//Struct
	var _meta = {};
	
	//Match settings
	match_settings_save(_meta);
	
	//Replay-specific data
	_meta.replay_total_frames = engine().replay_total_frames;
	_meta.replay_player_ko_frames = engine().replay_player_ko_frames;
	
	//Player metadata
	var _player_data = [];
	var _num_of_players = array_length(engine().player_data);
	for(var i = 0; i < _num_of_players; i++)
		{
		var _p = player_data_get(i, PLAYER_DATA.profile);
		var _data = {};
		_data.name = profile_get(_p, PROFILE.name);
		_data.character = player_data_get(i, PLAYER_DATA.character);
		_data.color = player_data_get(i, PLAYER_DATA.color);
		_data.team = player_data_get(i, PLAYER_DATA.team);
		array_push(_player_data, _data);
		}
	_meta.player_data = _player_data;
	
	//Write to the buffer
	buffer_write(_b, buffer_string, json_stringify(_meta));
}
/* Copyright 2023 Springroll Games / Yosi */