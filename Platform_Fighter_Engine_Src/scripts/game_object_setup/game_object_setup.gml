///@category Gameplay
/*
This function is ONLY intended to be called by <obj_game> and <obj_game_online> during the Room Start events.
It sets up the necessary variables for the game object to run.
*/
function game_object_setup() {
	//Game States
	meta_state = GAME_META_STATE.running;
	state = GAME_STATE.startup;
	game_state_buffer = buffer_create(1, buffer_grow, 1); //Used for the sync test

	//PRNG
	prng_numbers = array_create(prng_channels);
	for(var i = 0; i < prng_channels; i++)
		{
		prng_numbers[@ i] = prng_seed + (prng_channel_difference * i);
		}

	//Spawn all players and assigns controllers
	players_spawn();

	//Player render order & HUD order
	player_depth_list = ds_list_create();
	ordered_player_list = ds_list_create();
	with(obj_player)
		{
		ds_list_add(other.player_depth_list, id);
		other.ordered_player_list[| player_number] = id;
		}
	
	//Finishing initializing all players
	with(obj_player)
		{
		player_init_end();
		}
	
	//Frames
	current_frame = 0;
	game_time = 0;
	frames_advanced = 0;
	frame_advance_active = false;
	go_to_next_frame = false;

	//Camera
	view_enabled = true;
	view_visible[0] = true;
	view_wport[0] = screen_width;
	view_hport[0] = screen_height;
	cam = game_camera_get();
	view_camera[0] = cam;
	cam_x = 0;
	cam_y = 0;
	cam_x_goal = 0;
	cam_y_goal = 0;
	cam_x_ending = 0;
	cam_y_ending = 0;
	cam_shake_h = 0;
	cam_shake_v = 0;
	cam_w = camera_width_start;
	cam_h = camera_height_start;
	cam_w_goal = cam_w;
	cam_h_goal = cam_h;
	cam_auto = true;
	camera_set_view_size(cam, cam_w, cam_h);
	cam_surface = -1;
	if (camera_can_zoom())
		{
		cam_surface = surface_create(screen_width, screen_height);
		view_set_surface_id(0, cam_surface);
		}

	//Center the camera on the players
	camera_update();
	cam_x = cam_x_goal;
	cam_y = cam_y_goal;
	camera_set_view_pos(cam, cam_x, cam_y);

	//Game surface
	game_surface = noone;

	//Off-screen view surface
	offscreen_view_surface = noone;
	
	//Offscreen Radar
	offscreen_radar_alpha = 0;
	offscreen_radar_flip_x = false;
	offscreen_radar_flip_y = false;

	//Set up the hitbox priority queue
	hitbox_priority_queue = ds_priority_create();

	//Pause menu
	pause_menu_choices = [];
	array_push(pause_menu_choices, "RESUME");
	array_push(pause_menu_choices, "FRAME ADVANCE");
	array_push(pause_menu_choices, "RESTART");
	array_push(pause_menu_choices, "EXIT");
	if (clip_can_record())
		{
		array_insert(pause_menu_choices, 3, "SAVE CLIP");
		}
	pause_menu_choices_sprite = spr_pause_menu_choices;
	pause_menu_current = 0;
	pause_menu_device_id = noone;
	pause_menu_color = c_white;
	pause_hold_frame = 0;

	//Cache some values
	number_of_players = instance_number(obj_player);
	player_hud_width = (screen_width div (number_of_players + 1));
	player_hud_y = (screen_height - player_hud_padding_bottom);
	center_x = (screen_width div 2);
	center_y = (screen_height div 2);

	//Daynight
	uni_red = shader_get_uniform(shd_daynight, "red");
	uni_green = shader_get_uniform(shd_daynight, "green");
	uni_blue = shader_get_uniform(shd_daynight, "blue");
	daynight_r = 0;
	daynight_g = 0;
	daynight_b = 0;
	daynight_time = 0;

	//Startup counter
	countdown = countdown_start_time * 4;

	//Ending counter
	game_end_frame = 0;
	
	//1v1 Scoreboard
	hud_1v1_scoreboard_frame = 0;
	hud_1v1_scoreboard_total_frames = 0;

	//Sound System
	sound_system_init();
	
	//Verlet Physics
	verlet_system = verlet_system_create(verlet_custom_point_move, verlet_custom_draw, 0.5, 270, 0.02, 0.4, 2, 1.0);
	verlet_system.layer = layer_get_id("VFX_Layer_Below");

	//Clips
	clip_array = array_create(clip_length, undefined);
	clip_frame = 0;
	clip_should_save = false;
	clip_surface = noone;
	clip_saving_progress = -1;
	clip_is_saving = false;
	clip_gif = undefined;
	if (clip_can_record())
		{
		var _size = (screen_width * screen_height * 4);
		for(var i = 0; i < clip_length; i++)
			{
			clip_array[@ i] = buffer_create(_size, buffer_fixed, 1);
			}
		}

	//Debugging
	if (setting().debug_mode_enable)
		{
		debug_menus =
			{
			overlay : false,
			resources : false,
			overhead : false,
			inputs : false,
			sync_ids : false,
			};
		resource_counts = dynamic_resource_count_all();
		}
	
	//FPS
	if (setting().debug_fps)
		{
		fps_min = infinity;
		fps_max = -infinity;
		fps_avg = undefined;
		}
}

/* Copyright 2023 Springroll Games / Yosi */