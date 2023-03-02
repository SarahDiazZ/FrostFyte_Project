///@category Startup
/*
This function saves all of the player's current stats to the <savefile_stats> file.
If you want to add more stats to the game, they need to be added to <stats_load>.
*/
function stats_save() {
	var _struct = engine().stats;
	var _json = json_stringify(_struct);
	string_file_save(savefile_stats, _json);
	log("Saved the game stats!");
}
/* Copyright 2023 Springroll Games / Yosi */