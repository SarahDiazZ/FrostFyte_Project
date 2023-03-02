///@param {array} callback			The callback array to remove a script to
///@param {asset} script			The script to remove to the callback array
///@param {bool} [remove_one]		Whether only the first instance of the script should be removed, or all of them
/*
Removes a script from the given callback array.
This will remove ALL instances of the script in the array, unless the "remove_one" argument is true.
*/
function callback_remove() {
	var _cb = argument[0];
	var _script = argument[1];
	var _one = argument_count > 2 ? argument[2] : false;
	
	for(var i = 0; i < array_length(_cb); i += CALLBACK_SCRIPT.LENGTH)
		{
		if (_cb[@ i + CALLBACK_SCRIPT.script] == _script)
			{
			array_delete(_cb, i, CALLBACK_SCRIPT.LENGTH);
			i -= CALLBACK_SCRIPT.LENGTH;
			
			//Remove only one script
			if (_one) then return _cb;
			}
		}

	return _cb;
}
/* Copyright 2023 Springroll Games / Yosi */