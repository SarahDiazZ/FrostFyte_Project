///@category Gameplay
///@param {asset} [room]		The room to switch to
/*
Ends a match, and switches to the given room.
If no room is specified, it switches to <rm_win_screen>.
*/
function game_finish() {
	var _online = game_is_online();
	
	part_particles_clear(Particle_System());
	audio_stop_all();
	
	//Replay-specific data
	engine().replay_total_frames = obj_game.current_frame;
	
	//Online win screen time limit
	if (_online)
		{
		engine().win_screen_time_limit = online_win_screen_time_limit;
		}
	else
		{
		engine().win_screen_time_limit = -1;
		}
	
	//Update stats
	if (_online)
		{
		stats_set("online_matches", 1, true);
		}
	else
		{
		stats_set("local_matches", 1, true);
		}
	
	//Destroy all gameplay objects, before the sync id system is destroyed
	sync_id_system_destroy();
	
	//Remove all non-predefined simple attacks from memory
	var _struct = simple_attack_data();
	var _array = variable_struct_get_names(_struct);
	var _len = array_length(_array);
	for(var i = 0; i < _len; i++)
		{
		var _name = _array[@ i];
		if (variable_struct_exists(_struct, _name))
			{
			if (_struct[$ _name][$ "predefined"]) then continue;
			variable_struct_remove(_struct, _name);
			}
		}
	
	//Next room
	room_goto(argument_count > 0 ? argument[0] : rm_win_screen);
}
/* Copyright 2023 Springroll Games / Yosi */