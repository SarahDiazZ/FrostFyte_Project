///@category Startup
/*
Returns a struct with all of the options the game will save and load (using <options_save> and <options_load>).
The struct has two properties by default:
	- game: The array of all properties that must be saved from the <game_settings>.
	- engine: The array of all properties that must be saved from <engine_settings>.
*/
function options_list() {
	var _struct = {};
	_struct[$ "game"] =
		[
		"volume_music",
		"volume_sound_effects",
		"volume_menu",
		"stereo_sound_effects",
		"show_overhead_name",
		"show_overhead_damage",
		"show_overhead_arrow",
		"show_hud",
		"show_combos",
		"show_frame_advantage",
		"show_damage_numbers",
		"show_offscreen_radar",
		"knockback_trails_enable",
		"replay_record",
		"clip_record",
		"hold_pause_input",
		"debug_mode_enable",
		"performance_mode",
		"disable_shaders",
		];
	_struct[$ "engine"] =
		[
		];
	return _struct;
}
/* Copyright 2023 Springroll Games / Yosi */