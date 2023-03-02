///@category Player Engine Scripts
///@param {int} player_number		The player to set data for
///@param {int} data				The data to set, from the PLAYER_DATA enum
///@param {any} value				The value to set the data to
/*
Sets specific player data in engine().<player_data>.
Player data is the data stored for each player during matches, as opposed to CSS player data, which is the data stored on the character select screen.
*/
function player_data_set() {
	var _player = engine().player_data[argument[0]];
	_player[@ argument[1]] = argument[2];
}
/* Copyright 2023 Springroll Games / Yosi */