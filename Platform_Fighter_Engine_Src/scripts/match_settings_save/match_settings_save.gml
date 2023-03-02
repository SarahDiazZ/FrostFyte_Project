///@category Gameplay
///@param {struct} [struct]				A struct to add the values to, instead of creating a new struct
/*
Returns a struct with all of the match settings saved. You can call <match_settings_load> to load these settings later.
*/
function match_settings_save() {
	var _struct = argument_count > 0 ? argument[0] : {};
	assert(is_struct(_struct), "[match_settings_save] The argument is not a struct (", _struct, ")");
	_struct.match_stage = setting().match_stage;
	_struct.match_stock = setting().match_stock;
	_struct.match_time = setting().match_time;
	_struct.match_stamina = setting().match_stamina;
	_struct.match_team_mode = setting().match_team_mode;
	_struct.match_team_attack = setting().match_team_attack;
	_struct.match_items_enable = setting().match_items_enable;
	_struct.match_items_frequency = setting().match_items_frequency;
	_struct.match_fs_meter = setting().match_fs_meter;
	_struct.match_screen_wrap = setting().match_screen_wrap;
	_struct.match_ex_meter = setting().match_ex_meter;
	return _struct;
}
/* Copyright 2023 Springroll Games / Yosi */