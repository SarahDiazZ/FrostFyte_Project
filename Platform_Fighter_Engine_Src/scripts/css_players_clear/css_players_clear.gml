///@category Character Select Screen
/*
Deletes all of the CSS player data stored in engine().<css_player_data>, leaving it as an empty array.
*/
function css_players_clear() {
	engine().css_player_data = [];
	log("Reset all of the CSS player data!");
}
/* Copyright 2023 Springroll Games / Yosi */