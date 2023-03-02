///@category Gameplay
///@param {bool} [quickplay]		Whether to use the "quickplay" version of the settings or not
/*
Resets all of the match settings to the "default" values, which are set in <engine_settings>.
*/
function match_settings_default() {
	if (argument_count > 0 && argument[0])
		{
		setting().match_stock = quickplay_match_stock;
		setting().match_time = quickplay_match_time;
		setting().match_stamina = quickplay_match_stamina;
		setting().match_team_mode = quickplay_match_team_mode;
		setting().match_team_attack = quickplay_match_team_attack;
		setting().match_items_enable = quickplay_match_items_enable;
		setting().match_items_frequency = quickplay_match_items_frequency;
		setting().match_fs_meter = quickplay_match_fs_meter;
		setting().match_screen_wrap = quickplay_match_screen_wrap;
		setting().match_ex_meter = quickplay_match_ex_meter;
		}
	else
		{
		setting().match_stock = match_stock_default;
		setting().match_time = match_time_default;
		setting().match_stamina = match_stamina_default;
		setting().match_team_mode = match_team_mode_default;
		setting().match_team_attack = match_team_attack_default;
		setting().match_items_enable = match_items_enable_default;
		setting().match_items_frequency = match_items_frequency_default;
		setting().match_fs_meter = match_fs_meter_default;
		setting().match_screen_wrap = match_screen_wrap_default;
		setting().match_ex_meter = match_ex_meter_default;
		}
}
/* Copyright 2023 Springroll Games / Yosi */