///@category Replays
/*
Returns a struct with the following properties:
	- replay_array : An array with the names of all ".pfe" files in the correct version folder in the game's Local App Data folder.
	- clip_number : The number of ".gif" files in the folder
	- unknown_number : The number of files with an unsupported extension in the folder
	
If <web_export> is true, the function will get this data from the <savefile_replay_names> instead of scanning the directory.
	
Please note: You can change the directory files are saved to in the GameMaker Game Options.
Warning: This function does NOT check to make sure the replays are valid replay files that can be read by <replay_load>.
*/
function replays_scan() {
	var _replay_array = [];
	var _clip_number = 0;
	var _unknown_number = 0;
	
	//Non-web version
	if (!web_export)
		{
		for(var f = file_find_first(working_directory + string(version_string) + "\\*", 0); f != ""; f = file_find_next())
			{
			if (string_pos(".pfe", f) > 0)
				{
				array_push(_replay_array, f);
				}
			else if (string_pos(".gif", f) > 0)
				{
				_clip_number++;
				}
			else
				{
				_unknown_number++;
				}
			}
		}
	//Web version - check what is stored in the <savefile_replay_names>
	else
		{
		try
			{
			if (file_exists(savefile_replay_names))
				{
				var _json = string_file_load(savefile_replay_names);
				var _struct = json_parse(_json);
				
				//Check that all of the files still exist!
				var _array = _struct.replay_array;
				for(var m = 0; m < array_length(_array); m++)
					{
					if (!file_exists(_array[@ m]))
						{
						array_delete(_array, m, 1);
						m--;
						}
					}
				string_file_save(savefile_replay_names, json_stringify(_struct));
				
				_replay_array = _struct.replay_array;
				}
			}
		catch (_e)
			{
			log(_e);
			}
		}
		
	return
		{
		replay_array : _replay_array,
		clip_number : _clip_number,
		unknown_number : _unknown_number,
		};
}
/* Copyright 2023 Springroll Games / Yosi */