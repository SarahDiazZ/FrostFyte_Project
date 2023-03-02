///@category Profiles
/*
Overwrites the <savefile_profiles> file with the profiles currently in the game.
*/
function profile_save_all() {
	//Convert the values to a json string
	var _json = json_stringify
		({
		list : engine().profiles,
		version : version_string,
		});

	string_file_save(savefile_profiles, _json);
	log("Saved All profiles (", _json, ")");
}
/* Copyright 2023 Springroll Games / Yosi */