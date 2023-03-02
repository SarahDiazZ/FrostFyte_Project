///@category Gameplay
///@param {asset} [win_screen_next_room]			The room to switch to after the win screen
///@param {bool} [replay_mode]						Whether a replay is being watched or not
///@param {bool} [is_online]						Whether the match is online or not
/*
Starts a match using the current match settings (from the setting() struct).
Additionally, there are optional arguments for other settings.
*/
function game_begin() {
	//Check that the stage exists
	assert(room_exists(setting().match_stage), "[game_begin] The match stage ", setting().match_stage, " does not exist!");
	
	//Save profiles
	profile_save_all();
	
	//Optional settings
	if (argument_count > 0)
		{
		engine().win_screen_next_room = argument[0];
		}
	if (argument_count > 1)
		{
		setting().replay_mode = argument[1];
		}
	if (argument_count > 2)
		{
		//Set online
		}
	
	//Clear the replay buffer if NOT in replay mode
	if (!setting().replay_mode)
		{
		buffer_reset(replay_data_get().buffer);
		
		//Reset replay variables
		engine().replay_total_frames = 0;
		engine().replay_player_ko_frames = [];
		}
		
	//Reset win screen
	engine().win_screen_order = [];

	//Stage
	room_goto(rm_match_loading);
}
/* Copyright 2023 Springroll Games / Yosi */