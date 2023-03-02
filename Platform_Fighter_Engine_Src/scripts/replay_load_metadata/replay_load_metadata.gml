///@category Replays
///@param {buffer} replay			The buffer to load game metadata from
/*
Loads game metadata from a replay buffer. Used in <replay_load>, and should not be called independently.
*/
function replay_load_metadata() {
	var _b = argument[0];
	
	//Get the metadata
	var _meta = json_parse(buffer_read(_b, buffer_string));
	
	//Match settings
	match_settings_load(_meta);
	
	//Replay-specific data
	engine().replay_total_frames = _meta.replay_total_frames;
	engine().replay_player_ko_frames = _meta.replay_player_ko_frames;
	
	//Don't do anything with the player metadata - that's only for the replay menu to read!
}
/* Copyright 2023 Springroll Games / Yosi */