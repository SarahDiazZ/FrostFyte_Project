///@category Gameplay
///@param {struct} match_settings		The struct of saved settings to load
/*
Sets all of the match settings variables based on the values in the struct.
The struct should be from <match_settings_save>.
*/
function match_settings_load() {
	var _struct = argument[0];
	match_settings_default();
	if (variable_struct_exists(_struct, "match_stage")) then setting().match_stage = _struct.match_stage;
	if (variable_struct_exists(_struct, "match_stock")) then setting().match_stock = _struct.match_stock;
	if (variable_struct_exists(_struct, "match_time")) then setting().match_time = _struct.match_time;
	if (variable_struct_exists(_struct, "match_stamina")) then setting().match_stamina = _struct.match_stamina;
	if (variable_struct_exists(_struct, "match_team_mode")) then setting().match_team_mode = _struct.match_team_mode;
	if (variable_struct_exists(_struct, "match_team_attack")) then setting().match_team_attack = _struct.match_team_attack;
	if (variable_struct_exists(_struct, "match_items_enable")) then setting().match_items_enable = _struct.match_items_enable;
	if (variable_struct_exists(_struct, "match_items_frequency")) then setting().match_items_frequency = _struct.match_items_frequency;
	if (variable_struct_exists(_struct, "match_fs_meter")) then setting().match_fs_meter = _struct.match_fs_meter;
	if (variable_struct_exists(_struct, "match_screen_wrap")) then setting().match_screen_wrap = _struct.match_screen_wrap;
	if (variable_struct_exists(_struct, "match_ex_meter")) then setting().match_ex_meter = _struct.match_ex_meter;
}
/* Copyright 2023 Springroll Games / Yosi */