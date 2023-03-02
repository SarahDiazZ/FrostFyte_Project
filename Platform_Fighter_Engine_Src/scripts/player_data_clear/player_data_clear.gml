///@category Player Engine Scripts
/*
Deletes all of the player data stored in engine().<player_data>, leaving it as an empty array.
*/
function player_data_clear() {
	engine().player_data = [];
	log("Reset all of the engine player data!");
}
/* Copyright 2023 Springroll Games / Yosi */