///@category Startup
/*
This function saves all of the player's current values for Options to the <savefile_options> file.
If you want to add more options to the game, they need to be added to the <option_list> function.
*/
function options_save() {
	var _struct = {};
	var _options = options_list();
	var _array = _options[$ "game"];
	for(var i = 0; i < array_length(_array); i++)
		{
		var _o = _array[@ i];
		_struct[$ _o] = setting()[$ _o];
		}
	var _array = _options[$ "engine"];
	for(var i = 0; i < array_length(_array); i++)
		{
		var _o = _array[@ i];
		_struct[$ _o] = engine()[$ _o];
		}
	var _json = json_stringify(_struct);
	string_file_save(savefile_options, _json);
	log("Saved the game options!");
}
/* Copyright 2023 Springroll Games / Yosi */