///@category Startup
/*
Loads all options from the <savefile_options> file.
If you want to add more options to the game, they need to be added to the <option_list> function.
Warning: If there is an error when loading, the game will stop loading options and delete the file. This means all options that were not read from the file yet will remain on the default values.
*/
function options_load() {
	if (file_exists(savefile_options))
		{
		try
			{
			var _json = string_file_load(savefile_options);
			var _struct = json_parse(_json);
			var _options = options_list();
			var _array = _options[$ "game"];
			for(var i = 0; i < array_length(_array); i++)
				{
				var _o = _array[@ i];
				if (variable_struct_exists(_struct, _o))
					{
					setting()[$ _o] = _struct[$ _o];
					}
				}
			var _array = _options[$ "engine"];
			for(var i = 0; i < array_length(_array); i++)
				{
				var _o = _array[@ i];
				if (variable_struct_exists(_struct, _o))
					{
					engine()[$ _o] = _struct[$ _o];
					}
				}
			}
		catch (_exception)
			{
			log(_exception);
			file_delete(savefile_options);
			}
		
		log("Loaded the game options!");
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */