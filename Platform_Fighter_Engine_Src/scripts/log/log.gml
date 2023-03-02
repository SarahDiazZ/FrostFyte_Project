///@category Debugging
///@param {any} values		The value(s) to log
/*
Displays a debug message with all of the given values.
This function is for debug use only, and will only work if <debug_mode_enable> and <show_debug_logs> are true.
*/
function log() {
	if (!setting().debug_mode_enable || !show_debug_logs) then return;
		
	var _output = "";
	for(var i = 0; i < argument_count; i++)
		{
		_output += string(argument[i]);
		}
	
	show_debug_message(_output);
}
/* Copyright 2023 Springroll Games / Yosi */