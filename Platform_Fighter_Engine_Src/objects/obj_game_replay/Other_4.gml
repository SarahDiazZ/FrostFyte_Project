///@description Initialize

//Normal Setup
game_object_setup();

//Menu Input System
mis_init();
mis_auto_connect_enable(true);

//Player inputs
player_inputs = array_create(number_of_players);
for(var i = 0; i < number_of_players; i++)
	{
	player_inputs[@ i] = game_input_template();
	}

//Local Frame Skip
frame_delta_time = 0;

//Replay variables
replay_draw_hud = true;
replay_playback_speed = 1;
replay_frame = 0;

replay_menu_current = 0;
replay_menu_choices = [];
array_push(replay_menu_choices, "Resume");
array_push(replay_menu_choices, "Playback Speed");
if (clip_can_record()) then array_push(replay_menu_choices, "Save Clip");
array_push(replay_menu_choices, "Camera Mode");
array_push(replay_menu_choices, "Hide HUD");
array_push(replay_menu_choices, "Frame Advance");
array_push(replay_menu_choices, "Take Control");
array_push(replay_menu_choices, "Quit");

replay_camera_mode = false;
replay_cam_x = 0;
replay_cam_y = 0;
replay_cam_w = 0;
replay_cam_h = 0;

replay_took_control = false;
replay_control_device = noone;
replay_control_player = 0;

/* Copyright 2023 Springroll Games / Yosi */