///@category Debugging
///@param {bool} value			The value to check
///@param {string} messages		The messages to display if the value isn't true
/*
Crashes the game with the given messages if the specified value is not true.
*/
function assert() {
	var _val = argument[0];
	
	if (_val) then return;
	
	var _output = "[Assertion Failed] ";
	for(var i = 1; i < argument_count; i++)
		{
		_output += string(argument[i]);
		}
		
	if (setting().debug_mode_enable)
		{
		show_debug_message(_output);
		show_debug_message(debug_get_callstack());
		show_message(_output);
		}
	else
		{
		crash(_output);
		}
}
/* Copyright 2023 Springroll Games / Yosi */