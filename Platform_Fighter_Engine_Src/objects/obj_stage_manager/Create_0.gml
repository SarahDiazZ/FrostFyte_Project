///@category Stages
/*
obj_stage_manager controls most things related to stages during gameplay.
This includes parallax background layers, layer fading, music looping, the day/night cycle, etc.
You can also set a "stage_script" for rooms in the Create event of <obj_stage_manager>, which allows you to run unique code for stages.
*/
///@description Stage Features
only_one();

#region Default values
//Instance variables
background = [back_clear];
stage_script = -1;
stage_tint = [0.0, 0.0, 0.0];
music = -1;
music_intro_pos = 0;
music_loop_pos = 0;
custom_stage_struct = {};
custom_ids_struct = {};

//Game Settings
setting().daynight_cycle_enable = false;
setting().stage_background_color = c_white;
setting().slope_collisions_enable = true;
setting().background_is_static = false;
setting().screen_shader_script = -1;

//Music
audio_stop_all();

//Blastzones
blastzones = 
	{
	left : 0, 
	top : 0, 
	right : room_width, 
	bottom : room_height,
	};

//CPU Values
cpu_up_b_distance = 400;
cpu_main_stage_distance = 200;
#endregion

//Stage-specific values
switch(room)
	{
	case rm_small_campground:
		background = 
			[
			background_define(back_campground_autumn, 0, -15, 2, 0, 0),
			background_define(back_campground_autumn2, 0, -15, 2, 0.05, 0.05),
			background_define(back_campground_trees_autumn1, 0, 0, 2, 0.3, 0.3),
			background_define(back_campground_trees_autumn2, 0, 70, 2, 0.5, 0.5),
			background_define(back_campground_trees_autumn3, 0, 132, 2, 0.7, 0.7),
			back_clear,
			];
		stage_music_set(song_campgrounds_remix, 144.0, 281.1);
		setting().slope_collisions_enable = false;
		stage_tint = [0.2, 0.1, 0.0];
		setting().background_is_static = true;
		cpu_up_b_distance = 440;
		cpu_main_stage_distance = 220;
		break;
		
	case rm_large_campground:
		background = 
			[
			background_define_script(back_campground_day, 0, 0, 2, 0, 0, 0, 0, false, 0, stage_campground_distant_draw),
			background_define_script(back_campground_day2, 0, 0, 2, 0.05, 0.05, 0, 0, false, 0, stage_campground_distant_draw),
			background_define(back_campground_trees1, 0, 64, 2, 0.1, 0.1),
			background_define(back_campground_trees2, 0, 118, 2, 0.2, 0.3),
			background_define(back_campground_trees3, 0, 158, 2, 0.5, 0.5),
			back_clear,
			background_define(back_campground_flowers, 856, 704, 2, 0, 0, 0, 0, true, 0.1),
			];
		stage_music_set(song_campgrounds);
		setting().daynight_cycle_enable = true;
		setting().background_is_static = true;
		cpu_up_b_distance = 500;
		cpu_main_stage_distance = 300;
		break;
		
	case rm_peak:
		background = 
			[
			background_define(back_peak_distant, 0, 0, 2, 0, 0),
			background_define(back_peak_light, 0, -25, 2, 0.1, 0.1),
			background_define(back_peak_lighthouse, 0, -25, 2, 0.1, 0.1),
			background_define(back_peak_spikes1, 0, -10, 2, 0.1, 0.1),
			background_define(back_peak_spikes2, 0, 5, 2, 0.2, 0.2),
			background_define(back_peak_spikes3, 0, 25, 2, 0.3, 0.3),
			back_clear,
			];
		stage_script = stage_peak_snow;
		stage_music_set(song_snow, 25.4, 94.5);
		setting().slope_collisions_enable = false;
		stage_tint = [0.1, 0.1, 0.0];
		setting().background_is_static = true;
		cpu_up_b_distance = 410;
		cpu_main_stage_distance = 300;
		break;
		
	case rm_battlefield:
		background = 
			[
			background_define(back_battlefield_distant, 0, 0, 2, 0, 0),
			background_define(back_battlefield_clouds_moving, 0, 600, 2, -0.9, -0.9, 2, 0, true),
			background_define(back_battlefield_clouds_moving, 896 * 2, 600, 2, -0.9, -0.9, 2, 0, true),
			background_define(back_battlefield_stone, 0, 50, 2, 0.3, 0.2),
			background_define(back_battlefield_clouds, 0, 75, 2, 0.5, 0.3),
			back_clear,
			];
		stage_music_set(song_battlefield, 56.0, 120.0);
		cpu_up_b_distance = 540;
		cpu_main_stage_distance = 280;
		break;
		
	case rm_lava:
		background = 
			[
			background_define(back_lava_distant, 0, 0, 2, 0, 0),
			background_define_script(back_lava_falls, 0, 0, 2, 0, 0, 0, 0, false, 0, stage_lava_back_draw),
			background_define(back_lava_pipes, 0, 0, 2, 0.3, 0.1),
			background_define(back_lava_smokestacks, 0, 70, 2, 0.3, 0.2),
			back_clear,
			];
		stage_music_set(song_lava);
		setting().slope_collisions_enable = false;
		stage_tint = [0.2, -0.1, -0.1];
		setting().background_is_static = true;
		cpu_up_b_distance = 370;
		cpu_main_stage_distance = 300;
		break;
		
	case rm_clouds:
		background = 
			[
			background_define_script(back_clouds_distant, 0, 0, 2, 0, 0, 0, 0, false, 0, stage_clouds_distant_draw),
			background_define(back_clouds1, 0, 70, 2, 0.2, 0.2),
			background_define(back_clouds2, 0, 105, 2, 0.3, 0.3),
			background_define(back_clouds3, 0, 140, 2, 0.4, 0.4),
			back_clear,
			];
		stage_script = stage_clouds_lightning;
		stage_music_set(song_clouds, 121.6, 224.0);
		setting().background_is_static = true;
		setting().stage_background_color = $6D4F4C;
		cpu_up_b_distance = 460;
		cpu_main_stage_distance = 360;
		break;
		
	case rm_desert:
		background = 
			[
			background_define(back_desert_distant, 0, 0, 2, 0, 0),
			background_define(back_desert_rocks1, 0, 70, 2, 0.1, 0.1),
			background_define(back_desert_rocks2, 0, 105, 2, 0.2, 0.2),
			background_define(back_desert_rocks3, 0, 140, 2, 0.3, 0.3),
			back_clear,
			];
		stage_music_set(song_desert, 153.7, 300.0);
		setting().slope_collisions_enable = false;
		setting().background_is_static = true;
		cpu_up_b_distance = 430;
		cpu_main_stage_distance = 200;
		break;
		
	case rm_haven:
		background = 
			[
			background_define(back_haven_distant, 0, 0, 2, 0, 0),
			background_define(back_haven_falls, 0, 0, 2, 0, 0),
			background_define(back_haven_spikes, 0, 0, 2, 0.1, 0.1),
			background_define(back_haven_falls2, 0, 0, 2, 0.2, 0.2),
			background_define(back_haven_spikes2, 0, 0, 2, 0.3, 0.3),
			background_define(back_haven_spikes3, 0, 0, 2, 0.4, 0.4),
			back_clear,
			];
		stage_music_set(song_haven);
		stage_script = stage_haven_script;
		custom_stage_struct.haven_final_form = false;
		custom_stage_struct.haven_transform_frame = 0;
		stage_tint = [-0.1, 0.1, 0.2];
		cpu_up_b_distance = 380;
		cpu_main_stage_distance = 240;
		break;
		
	case rm_library:
		background = 
			[
			background_define(back_library_distant, 0, 0, 2, 0, 0),
			background_define(back_library_pillars, 0, 0, 2, 0.05, 0.05),
			background_define(back_library_shelves1, 0, 0, 2, 0.1, 0.1),
			background_define(back_library_shelves2, 0, 0, 2, 0.2, 0.2),
			background_define(back_library_shelves3, 0, 0, 2, 0.3, 0.3),
			background_define(back_library_abyss, 0, 156, 2, 0.3, 0.3),
			background_define(back_library_abyss2, 0, 36, 2, 0.3, 0.3),
			background_define(back_library_lantern, 0, -110, 2, 0.4, 0.4),
			back_clear,
			];
		stage_music_set(song_library, 166.4, 332.8);
		stage_tint = [0.1, 0.1, 0.0];
		setting().background_is_static = true;
		cpu_up_b_distance = 560;
		cpu_main_stage_distance = 330;
		break;
		
	case rm_practice_room:
		setting().stage_background_color = c_white;
		break;
		
	case rm_smiley_floats:
		background = 
			[
			background_define(back_battlefield_distant, 0, 0, 2, 0, 0),
			background_define(back_battlefield_clouds_moving, 0, 600, 2, -0.9, -0.9, 2, 0, true),
			background_define(back_battlefield_clouds_moving, 896 * 2, 600, 2, -0.9, -0.9, 2, 0, true),
			background_define(back_battlefield_clouds, 0, 75, 2, 0.5, 0.3),
			back_clear,
			];
		stage_script = stage_smiley_floats_script;
		stage_tint = [0.1, 0.1, 0.1];
		stage_music_set(song_battlefield, 56.0, 120.0);
		
		//Init script
		stage_smiley_floats_init();
		break;
		
	default:
		log("The current stage does not have any stage specific values in obj_stage_manager.");
		break;
	}
	
half_room_width = room_width / 2;
half_room_height = room_height / 2;

//Special Effects
background_clear_frame = 0;
background_clear_amount = 0;
background_clear_fade_speed = 1;
background_clear_color = c_white;
background_clear_direction = 90;
uni_black = shader_get_uniform(shd_fade, "fade_amount");

background_fog_color = c_black;
background_fog_alpha = 0;

//Layer fade for all layers that start with "Asset"
var _lay = layer_get_all();
for(var i = 0; i < array_length(_lay); i++)
	{
	if (string_count("Asset", layer_get_name(_lay[@ i])) > 0)
		{
		layer_script_begin(_lay[@ i], layer_fade_begin);
		layer_script_end(_lay[@ i], layer_fade_end);
		}
	}
/* Copyright 2023 Springroll Games / Yosi */