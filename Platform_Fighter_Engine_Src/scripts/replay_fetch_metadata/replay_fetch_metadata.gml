///@category Replays
///@param {string} filename		The name of the replay file to get the metadata from
/*
Returns a struct with the metadata from the specified file.
This function can be called independently of <replay_load> and does not start a replay match.
*/
function replay_fetch_metadata() {
	var _name = version_string + "/" + argument[0];
	if (web_export)
		{
		_name = argument[0];
		}
	
	//Get the buffer data from the file
	if (file_exists(_name))
		{
		var _compress = buffer_load(_name);
		if (buffer_exists(_compress))
			{
			var _load = buffer_decompress(_compress);
			buffer_seek(_load, buffer_seek_start, 0);

			//Get the metadata
			var _meta = json_parse(buffer_read(_load, buffer_string));
		
			//Destroy the buffers
			buffer_delete(_compress);
			buffer_delete(_load);
		
			return _meta;
			}
		else
			{
			crash("[replay_fetch_metadata] Replay has failed to load because the buffer could not be loaded! (", _name, ")");
			}
		}
	else
		{
		crash("[replay_fetch_metadata] Replay has failed to load because the file does not exist! (", _name, ")");
		}
}
/* Copyright 2023 Springroll Games / Yosi */