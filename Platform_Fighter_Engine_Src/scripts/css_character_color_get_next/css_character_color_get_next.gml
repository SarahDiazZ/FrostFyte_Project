///@category Character Select Screen
///@param {int} player_id				The player in the character select screen
///@param {int} character				The character selected
///@param {int} [current_color]			The color the player currently has
///@param {int} [direction]				The direction to change the color
/*
Finds the next available color for a specific character. 
This ensures that players cannot choose the same color. 
The optional direction can be +1 or -1.
*/
function css_character_color_get_next() {
	var _id = argument[0];
	var _character = argument[1];
	var _current = argument_count > 2 ? argument[2] : 0;
	var _dir = argument_count > 3 ? argument[3] : 1;
	var _col = _current;
		
	//Loop through all possible colors in the character's palette
	var _num = character_data_get(_character, CHARACTER_DATA.palette_data).columns;
	repeat(_num)
		{
		//Check the next color, with wrapping.
		//The 0th color is not used in-game, so it wraps at 1.
		_col += _dir;
		if (_col >= _num)
			{
			_col = 1;
			}
		else if (_col < 1)
			{
			_col = _num - 1;
			}
				
		//Make sure no other players are using that color
		var _already_taken = false;
		for(var i = 0; i < array_length(engine().css_player_data); i++)
			{
			//The checking player does not count itself
			var _player = engine().css_player_data[@ i];
			if (_player[@ CSS_PLAYER.player_id] == _id) then continue;
				
			//Only check other players using the same character
			if (_player[@ CSS_PLAYER.character] == _character && _player[@ CSS_PLAYER.color] == _col)
				{
				_already_taken = true;
				break;
				}
			}
		if (!_already_taken)
			{
			return _col;
			}
		}
	return _col;
}
/* Copyright 2023 Springroll Games / Yosi */