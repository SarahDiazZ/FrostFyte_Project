///@category Gameplay
///@param {buffer} buffer		The index of the input buffer
/*
Creates a string of the player's inputs.
Only used for debug purposes.
*/
function game_input_print() {
	var _b = argument[0];
	buffer_seek(_b, buffer_seek_start, 0);
	var _s = "";
	
	var _flag = buffer_read(_b, buffer_u32);
	//*
	for(var i = 0; i < (INPUT.LENGTH * 2); i++)
		{
		if (bitflag_read(_flag, i))
			{
			_s += "1";
			}
		else
			{
			_s += "0";
			}
		}
		
	_s += "/";
	//*/

	_s += string(buffer_read(_b, buffer_s8) / 100.0);
	_s += string(buffer_read(_b, buffer_s8) / 100.0);
	_s += string(buffer_read(_b, buffer_s8) / 100.0);
	_s += string(buffer_read(_b, buffer_s8) / 100.0);
	
	_s += "\n";
	
	return _s;
}
/* Copyright 2023 Springroll Games / Yosi */