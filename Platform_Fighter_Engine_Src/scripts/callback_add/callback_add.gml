///@param {array} callback				The callback array to add a script to
///@param {asset} script				The script to add to the callback array
///@param {int} [type]					The type of script, from the enum CALLBACK_TYPE
///@param {id/asset} [target]			An instance id to run the script on
///@param {bool} [allow_duplicates]		Whether the script can be added even if it is already in the callback array
/*
Adds a script to the given callback array.
These scripts will be run in order whenever <callback_run> is called.
The script type must be from the CALLBACK_TYPE array:
	- permanent: The script will never be removed from the array
	- temporary: The script will be removed when <callback_clean> is run
	- one_time: The script will be removed after it is run from <callback_run>
By default, the type will be "CALLBACK_TYPE.temporary".
You can optionally choose a target for the script. By default, this is the instance id of the calling instance.
Duplicate scripts are not added to the callback array, unless the optional "allow_duplicates" argument is true.

Warning: Do not use any "one_time" scripts for drawing! Drawing is not always tied to game frames.

Warning: Only "CALLBACK_TYPE.permanent" scripts can be set from character init scripts.
*/
function callback_add() {
	var _cb = argument[0];
	var _script = argument[1];
	var _type = argument_count > 2 ? argument[2] : CALLBACK_TYPE.temporary;
	var _target = argument_count > 3 ? argument[3] : id;
	var _duplicate = argument_count > 4 ? argument[4] : false;
	
	if (!_duplicate)
		{
		var _len = array_length(_cb);
		for(var i = CALLBACK_SCRIPT.script; i < _len; i += CALLBACK_SCRIPT.LENGTH)
			{
			if (_cb[@ i] == _script) then return _cb;
			}
		}
	
	array_push
		(
		_cb,
		_script,
		_type,
		_target,
		);
		
	return _cb;
}
/* Copyright 2023 Springroll Games / Yosi */