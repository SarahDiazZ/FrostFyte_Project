///@category Startup
/*
Loads all stats from the <savefile_stats> file.
If you want to add more stats to the game, they need to be added to this function.
Warning: If there is an error when reading the file, any stats that have not been read yet will remain on the default values.
*/
function stats_load() {
    //Default stats:
    engine().stats =
        {
        playtime_hours : 0,
		playtime_minutes : 0,
        local_matches : 0,
        online_matches : 0,
        online_wins : 0,
        };
    
    //Attempt to load the file
	if (file_exists(savefile_stats))
		{
		try
			{
			var _json = string_file_load(savefile_stats);
			var _struct = json_parse(_json);
			var _names = variable_struct_get_names(_struct);
			for(var i = 0; i < array_length(_names); i++)
			    {
			    engine().stats[$ _names[@ i]] = _struct[$ _names[@ i]];
			    }
			}
		catch (_exception)
			{
			log(_exception);
			}
		
		log("Loaded the game stats!");
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */