///@category Character Select Screen
/*
Returns an array with the number id of every player currently on the character select screen.
*/
function css_players_get_array() {
	var _array = [];
	for(var i = 0; i < array_length(engine().css_player_data); i++)
		{
		array_push(_array, engine().css_player_data[@ i][@ CSS_PLAYER.player_id]);
		}
	return _array;
}
/* Copyright 2023 Springroll Games / Yosi */