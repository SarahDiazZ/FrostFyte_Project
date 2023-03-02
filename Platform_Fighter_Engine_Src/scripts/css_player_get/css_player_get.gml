///@category Character Select Screen
///@param {int} player_id			The player number to get a property from
///@param {int} property			The property to get, from the CSS_PLAYER enum
/*
Gets the property of the given player. Properties are from the CSS_PLAYER enum.
*/
function css_player_get() {
	for(var i = 0; i < array_length(engine().css_player_data); i++)
		{
		var _player = engine().css_player_data[@ i];
		if (_player[@ CSS_PLAYER.player_id] == argument[0])
			{
			return _player[@ argument[1]];
			}
		}
	return undefined;
}
/* Copyright 2023 Springroll Games / Yosi */