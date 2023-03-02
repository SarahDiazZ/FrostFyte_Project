///@category Player Engine Scripts
///@param {int} player_number		The player to get data from
///@param {int} data				The data to get, from the PLAYER_DATA enum
/*
Gets specific player data from engine().<player_data>.
Player data is the data stored for each player during matches, as opposed to CSS player data, which is the data stored on the character select screen.
*/
function player_data_get() {
	var _player = engine().player_data[argument[0]];
	return _player[@ argument[1]];
}
/* Copyright 2023 Springroll Games / Yosi */