///@category Character Select Screen
///@param {int} player_id		The number of the player
/*
Finds the list position of the player with the given id in the engine().<css_player_data> array.
*/
function css_player_list_position() {
	for(var i = 0; i < array_length(engine().css_player_data); i++)
		{
		var _player = engine().css_player_data[@ i];
		if (_player[@ CSS_PLAYER.player_id] == argument[0])
			{
			return i;
			}
		}
	return undefined;
}
/* Copyright 2023 Springroll Games / Yosi */