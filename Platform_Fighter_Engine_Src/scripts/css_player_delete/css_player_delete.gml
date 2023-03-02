///@category Character Select Screen
///@param {int} player_id		The player to remove from the character select screen
/*
Deletes the player with the given id number from the character select screen.
*/
function css_player_delete() {
	for(var i = 0; i < array_length(engine().css_player_data); i++)
		{
		var _player = engine().css_player_data[@ i];
		if (_player[@ CSS_PLAYER.player_id] == argument[0])
			{
			array_delete(engine().css_player_data, i, 1);
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */