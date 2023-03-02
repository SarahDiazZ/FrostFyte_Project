///@category Replays
///@param {string} filename			The name of the file to save the replay to
/*
Saves the current replay data to the given file.
If <web_export> is true, the name of the replay file will also be added to the <savefile_replay_names>.
*/
function replay_save() {
	var _name = argument[0];
	
	//Create the final buffer
	var _final = buffer_create(1, buffer_grow, 1);
	buffer_seek(_final, buffer_seek_start, 0);

	//Write metadata
	replay_save_metadata(_final);

	//Write player data
	replay_save_players(_final);

	//Copy the main replay buffer
	var _main = replay_data_get().buffer;
	buffer_resize(_main, buffer_tell(_main));
	buffer_write(_final, buffer_u64, buffer_get_size(_main));
	buffer_append(_main, _final, buffer_tell(_final));

	//Export to file
	buffer_resize(_final, buffer_tell(_final));
	var _compress = buffer_compress(_final, 0, buffer_get_size(_final));
	buffer_save(_compress, _name);
	log(to_string("Replay saved to: ", _name));

	//Web export - Add to the <savefile_replay_names>
	if (web_export)
		{
		try
			{
			var _struct = 
				{
				replay_array : [],
				};
			if (file_exists(savefile_replay_names))
				{
				var _json = string_file_load(savefile_replay_names);
				var _old = json_parse(_json);
				if (variable_struct_exists(_old, "replay_array"))
					{
					if (is_array(_old.replay_array))
						{
						_struct.replay_array = _old.replay_array;
						}
					}
				}
			array_push(_struct.replay_array, _name);
			string_file_save(savefile_replay_names, json_stringify(_struct));
			}
		catch (_e)
			{
			log(_e);
			}
		}

	//Destroy buffers
	buffer_delete(_compress);
	buffer_delete(_final);
}
/* Copyright 2023 Springroll Games / Yosi */