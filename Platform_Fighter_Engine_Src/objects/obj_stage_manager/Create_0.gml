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
	
	case rm_warpgate:
		background = 
		[
		background_define(warpgatebackground, 0, 0, 2, 0, 0),
		back_clear,
		];
		break;
	case rm_speedhighway:
		background = 
		[
		background_define(speedhighwaybackground, 0, 0, 2, 0, 0),
		back_clear,
		];
  break;
		
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