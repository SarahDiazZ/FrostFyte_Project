///@description
				
//Menu Input System
mis_init();
mis_auto_connect_enable(true);

//Background animation
menu_background_color_set($FFD3D3);

//All options
options_array = [];
if (!web_export)
	{
	array_push(options_array, { name : "Toggle Fullscreen", current : window_get_fullscreen(), display : "bool",
		desc : "Enter or exit fullscreen." });
	}
array_push(options_array, { name : "Change Window Size", current : string(window_get_width() div screen_width) + "x", display : "string",
	desc : "Change the size of the game window." });
array_push(options_array, "Sound");
array_push(options_array, { name : "Music Volume", current : setting().volume_music, display : "percent",
	desc : "Adjust the volume of the music." });
array_push(options_array, { name : "Sound Effects Volume", current : setting().volume_sound_effects, display : "percent",
	desc : "Adjust the volume of the in-game sound effects." });
array_push(options_array, { name : "Menu Volume", current : setting().volume_menu, display : "percent",
	desc : "Adjust the volume of the menu sound effects." });
array_push(options_array, { name : "Stereo Sound Effects", current : setting().stereo_sound_effects, display : "bool",
	desc : "Use stereo or mono sound effects." });
array_push(options_array, "Graphics / Display");
array_push(options_array, { name : "Overhead Names", current : setting().show_overhead_name, display : "bool",
	desc : "Display profile names over players." });
array_push(options_array, { name : "Overhead Damage", current : setting().show_overhead_damage, display : "bool",
	desc : "Display damage percent over players." });
array_push(options_array, { name : "Overhead Arrows", current : setting().show_overhead_arrow, display : "bool",
	desc : "Display arrows over players with the color of the player's port." });
array_push(options_array, { name : "Show HUD", current : setting().show_hud, display : "bool",
	desc : "Display the HUD on the bottom of the screen." });
array_push(options_array, { name : "Combo Display", current : setting().show_combos, display : "bool",
	desc : "Show the combo counter on hit."});
array_push(options_array, { name : "Frame Advantage Display", current : setting().show_frame_advantage, display : "bool",
	desc : "Show the frame advantage of the last move used." });
array_push(options_array, { name : "Damage Number VFX", current : setting().show_damage_numbers, display : "bool",
	desc : "Show damage numbers near players whenever players take damage." });
array_push(options_array, { name : "Offscreen Radar", current : setting().show_offscreen_radar, display : "bool",
	desc : "Show a small radar in the corner when players go off the screen." });
array_push(options_array, { name : "Knockback Cloud Trails", current : setting().knockback_trails_enable, display : "bool",
	desc : "Show cloud effects when players are launched at high speeds." });
array_push(options_array, { name : "Performance Mode", current : setting().performance_mode, display : "bool",
	desc : "Turn off all visual effects and some shaders to increase performance." });
array_push(options_array, { name : "Disable Shaders", current : setting().disable_shaders, display : "bool",
	desc : "Turn off all shaders to increase drawing performance. Use at your own risk!" });
array_push(options_array, "Extra");
array_push(options_array, { name : "Record Replays", current : setting().replay_record, display : "bool",
	desc : "Whether to record replays during matches and allow replay saving on the win screen." });
if (!web_export)
	{
	array_push(options_array, { name : "Record Clips", current : setting().clip_record, display : "bool",
		desc : "Whether to record clips during matches and allow clip saving in the pause menu. This may affect performance." });
	}
array_push(options_array, { name : "Hold to Pause", current : setting().pause_hold_input, display : "bool",
	desc : "Whether you need to hold the pause button to pause local matches." });
array_push(options_array, { name : "Debug Mode", current : setting().debug_mode_enable, display : "bool",
	desc : "Turns on debug functionality." });
		
options_count = array_length(options_array) + 1; //Include the back button
option_current = 0;
options_per_page = 20;
option_scroll = 0;

active = true;
/* Copyright 2023 Springroll Games / Yosi */