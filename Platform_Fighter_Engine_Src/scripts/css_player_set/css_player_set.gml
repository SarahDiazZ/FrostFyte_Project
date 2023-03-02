///@category Character Select Screen
///@param {int} player_id		The player number to set a property of
///@param {int} property		The property to set, from the CSS_PLAYER enum
///@param {any} value			The value
/*
Sets the property of the given. player. Properties are from the CSS_PLAYER enum.
*/
function css_player_set() {
	for(var i = 0; i < array_length(engine().css_player_data); i++)
		{
		var _player = engine().css_player_data[@ i];
		if (_player[@ CSS_PLAYER.player_id] == argument[0])
			{
			_player[@ argument[1]] = argument[2];
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */