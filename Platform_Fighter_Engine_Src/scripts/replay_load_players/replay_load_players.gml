///@category Replays
///@param {buffer} replay			The buffer to load player data from
/*
Loads player data out of a replay buffer. Used in <replay_load>, and should not be called independently.
*/
function replay_load_players() {
	var _b = argument[0];

	//For each player
	var _players = buffer_read(_b, buffer_u8);
	player_data_clear();

	for(var i = 0; i < _players; i++)
		{
		//Grab data from the buffer and create a new player entry
		var _character = buffer_read(_b, buffer_u8);
		var _color = buffer_read(_b, buffer_u8);
		var _device = buffer_read(_b, buffer_u8);
		var _device_type = buffer_read(_b, buffer_u8);
		var _is_cpu = buffer_read(_b, buffer_bool);
		var _cpu_type = buffer_read(_b, buffer_u8);
		var _team = buffer_read(_b, buffer_s8);
		var _custom = json_parse(buffer_read(_b, buffer_string));
		var _right_stick = buffer_read(_b, buffer_s8);
		var _scs = buffer_read_array(_b, buffer_bool);
		var _acs = buffer_read_array(_b);
		var _name = buffer_read(_b, buffer_string);
		var _profile = profile_create(_name, custom_controls_create(true), true);
		var _cc = profile_get(_profile, PROFILE.custom_controls);
		_cc.right_stick_input = _right_stick;
		_cc.scs = _scs;
		_cc.acs = _acs;
	
		player_data_create(_character, _color, _device, _device_type, _profile, false, _is_cpu, _cpu_type, _team, _custom);
		}
	
	profile_save_all();
}
/* Copyright 2023 Springroll Games / Yosi */