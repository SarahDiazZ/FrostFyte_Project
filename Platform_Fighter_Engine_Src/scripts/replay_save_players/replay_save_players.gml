///@category Replays
///@param {buffer} replay			The buffer to save player data to
/*
Saves player data to a replay buffer. Used in <replay_save>, and should not be called independently.
*/
function replay_save_players() {
	var _b = argument[0];

	//Save number of players
	var _num_of_players = array_length(engine().player_data);
	buffer_write(_b, buffer_u8, _num_of_players);

	//For each player
	for(var i = 0; i < _num_of_players; i++)
		{
		var _p = player_data_get(i, PLAYER_DATA.profile);
		var _cc = profile_get(_p, PROFILE.custom_controls);
		var _right_stick = _cc.right_stick_input;
		var _scs = _cc.scs;
		var _acs = _cc.acs;
	
		//Save their data to the buffer
		buffer_write(_b, buffer_u8, player_data_get(i, PLAYER_DATA.character));
		buffer_write(_b, buffer_u8, player_data_get(i, PLAYER_DATA.color));
		buffer_write(_b, buffer_u8, player_data_get(i, PLAYER_DATA.device));
		buffer_write(_b, buffer_u8, player_data_get(i, PLAYER_DATA.device_type));
		buffer_write(_b, buffer_bool, player_data_get(i, PLAYER_DATA.is_cpu));
		buffer_write(_b, buffer_u8, player_data_get(i, PLAYER_DATA.cpu_type));
		buffer_write(_b, buffer_s8, player_data_get(i, PLAYER_DATA.team));
		buffer_write(_b, buffer_string, json_stringify(player_data_get(i, PLAYER_DATA.custom)));
		buffer_write(_b, buffer_s8, _right_stick);
		buffer_write_array(_b, _scs, buffer_bool);
		buffer_write_array(_b, _acs);
		buffer_write(_b, buffer_string, profile_get(_p, PROFILE.name));
		}
}
/* Copyright 2023 Springroll Games / Yosi */