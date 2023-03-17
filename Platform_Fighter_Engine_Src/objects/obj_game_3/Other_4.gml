///@description Initialize

//Normal Setup
game_object_setup();

//Replays
replay_record_match = setting().replay_record;
if (!match_has_stock_set() && !match_has_time_set() && !match_has_stamina_set())
	{
	//Do not attempt to record endless matches
	replay_record_match = false;
	log("A replay will not be recorded for the current match, since it is an endless match!");
	}

//Menu Input System
mis_init();
mis_auto_connect_enable(false);

//Player inputs
player_inputs = array_create(number_of_players);
for(var i = 0; i < number_of_players; i++)
	{
	player_inputs[@ i] = game_input_template();
	}

//Local Frame Skip
frame_delta_time = 0;

/* Copyright 2023 Springroll Games / Yosi */