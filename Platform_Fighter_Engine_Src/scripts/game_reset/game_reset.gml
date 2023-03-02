///@category Gameplay
/*
Restarts the current match.
*/
function game_reset() {
	part_particles_clear(Particle_System());
	audio_stop_all();
	
	//Replay-specific data
	engine().replay_total_frames = obj_game.current_frame;
	
	//Stats
	stats_set("local_matches", 1, true);
	
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
	
	//Restart the room
	room_restart();
}
/* Copyright 2023 Springroll Games / Yosi */