///@category Characters
///@param {string} name			The character's name
/*
Returns the index of the character with the given name in the character data array.
If no character is found, it returns -1.
*/
function character_find() {
	var _total = character_count();
	for(var i = 0; i < _total; i++)
		{
		if (character_data_get(i, CHARACTER_DATA.name) == argument[0])
			{
			return i;
			}
		}
	return -1;
}
/* Copyright 2023 Springroll Games / Yosi */