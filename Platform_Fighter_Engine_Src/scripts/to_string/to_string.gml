///@param {any} values		The values to be merged into a string
/*
Merges all of the given values into a single string.
*/
function to_string() {
	var _output = "";

	for(var i = 0; i < argument_count; i++)
		{
		_output += is_string(argument[i]) ? argument[i] : string(argument[i]);
		}
	
	return _output;
}
/* Copyright 2023 Springroll Games / Yosi */