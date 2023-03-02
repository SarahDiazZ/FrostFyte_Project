///@description
//Input - accept from all devices
var _confirm = false;
var _start = false;
var _option = false;
var _array = mis_devices_get_array();
for(var i = 0; i < array_length(_array); i++)
	{
	var _id = _array[@ i];
	if (mis_device_input(_id, MIS_INPUT.confirm)) then _confirm = true;
	if (mis_device_input(_id, MIS_INPUT.start)) then _start = true;
	if (mis_device_input(_id, MIS_INPUT.option)) then _option = true;
	}

//Offset animations
if (state == "winner")
	{
	state_timer = lerp(state_timer, 0, 0.1);
	if (state_timer <= 0.1)
		{
		state_timer = 0;
		state = "losers";
		state_timer = 100;
		}
	}
else if (state == "losers")
	{
	state_timer = lerp(state_timer, 0, 0.15);
	if (state_timer <= 0.1)
		{
		state_timer = 0;
		}
	}

//Save replay
if (_option)
	{	
	if (!setting().replay_mode && setting().replay_record && can_save_replay)
		{
		menu_sound_play(snd_menu_alert);
		can_save_replay = false;
		var _time = replay_data_get().time;
		
		//Save replays to the main folder on web exports
		if (web_export)
			{
			replay_save("Replay " + _time + ".pfe");
			}
		else	
			{
			replay_save(version_string + "/" + "Replay " + _time + ".pfe");
			}
		}
	}
	
//Time Limit
var _time_up = false;
time_left--;
if (time_left <= 0 && engine().win_screen_time_limit != -1)
	{
	_time_up = true;
	}

//Go to the preset next room (default is rm_css)
if ((state != "winner" && (_confirm || _start)) || _time_up)
	{
	audio_stop_all(); //Stop victory theme
	menu_sound_play(snd_menu_start);
	room_goto(engine().win_screen_next_room);
	exit;
	}
/* Copyright 2023 Springroll Games / Yosi */