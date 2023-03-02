///@category Characters
///@param {array} [banned_characters]		An array of character names that cannot be chosen
/*
Chooses a random character from all of the characters defined in <character_data>.
You can optionally pass an array of strings, and the characters with those names cannot be chosen.
Please note: The function will crash if there are no characters to choose from after taking bans into account.
*/
function character_choose_random() {
    //Create an array of all characters that are NOT the random button, and choose one
    var _banned = argument_count > 0 ? argument[0] : [];
	var _possible = [];
	var _total = character_count();
	for(var i = 0; i < _total; i++)
		{
		var _name = character_data_get(i, CHARACTER_DATA.name);
		if (_name != "Random")
			{
			//Make sure the character isn't banned
			var _is_banned = false;
			for(var m = 0; m < array_length(_banned); m++)
				{
				if (_name == _banned[@ m])
					{
					_is_banned = true;
					break;
					}
				}
			if (!_is_banned)
				{
				array_push(_possible, i);
				}
			}
		}
	assert(array_length(_possible) > 0, "[character_choose_random] Either there are no characters besides Random in character_data(), or every other character has been banned.");
	return _possible[@ irandom(array_length(_possible) - 1)];
}
/* Copyright 2023 Springroll Games / Yosi */