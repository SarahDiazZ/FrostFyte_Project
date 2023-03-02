///@category Inputs
///@param {int} input		The input, from the INPUT enum
/*
Returns the name of the given input.
If you want to get the name of a custom controls input, use <cc_input_name_get>.
*/
function input_name_get() {
	switch(argument[0])
		{
		case INPUT.attack:	return "Attack";
		case INPUT.grab:	return "Grab";
		case INPUT.jump:	return "Jump";
		case INPUT.pause:	return "Pause";
		case INPUT.shield:	return "Shield";
		case INPUT.smash:	return "Smash";
		case INPUT.special: return "Special";
		case INPUT.taunt:	return "Taunt";
		case INPUT.run:		return "Run/Walk";
		default: crash("[input_name_get] Invalid input (", argument[0], ")"); break;
		}
}
/* Copyright 2023 Springroll Games / Yosi */