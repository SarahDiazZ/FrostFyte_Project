///@category Characters
///@param {int/string} character		The character's index, or name
///@param {int} data_enum				The data to get, from the CHARACTER_DATA enum
/*
Returns data from a certain character's values in the <character_data> script.
*/
function character_data_get() {
	var _char = argument[0];
	var _data = argument[1];
	var _total = character_count();
	
	//Find the character with the name
	if (is_string(_char))
		{
		var _found = false;
		for(var i = 0; i < _total; i++)
			{
			if (character_data_get_all()[@ i][@ CHARACTER_DATA.name] == _char)
				{
				_char = i;
				_found = true;
				break;
				}
			}
		if (!_found)
			{
			crash("[character_data_get] No character exists with the given name: ", _char);
			}
		}

	return character_data_get_all()[@ _char][@ _data];
}
/* Copyright 2023 Springroll Games / Yosi */