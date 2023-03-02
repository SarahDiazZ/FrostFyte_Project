///@category Gameplay
///@param {buffer} inputs		The input buffer to check
/*
Checks if the given input buffer has the default data, which is considered "blank".
Only used for debug purposes.
*/
function game_input_is_blank() {
	var _b = argument[0];
	buffer_seek(_b, buffer_seek_start, 0);
	
	if (buffer_read(_b, buffer_u32) != 0) then return false;
	if (buffer_read(_b, buffer_s8) != 0) then return false;
	if (buffer_read(_b, buffer_s8) != 0) then return false;
	if (buffer_read(_b, buffer_s8) != 0) then return false;
	if (buffer_read(_b, buffer_s8) != 0) then return false;
	
	return true;
}
/* Copyright 2023 Springroll Games / Yosi */