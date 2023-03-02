///@param {array} callback		The callback array to clean
/*
Removes all scripts from the callback array with the type of "CALLBACK_TYPE.temporary".
*/
function callback_clean() {
	var _cb = argument[0];
	for(var i = 0; i < array_length(_cb); i += CALLBACK_SCRIPT.LENGTH)
		{
		if (_cb[@ i + CALLBACK_SCRIPT.type] == CALLBACK_TYPE.temporary)
			{
			array_delete(_cb, i, CALLBACK_SCRIPT.LENGTH);
			i -= CALLBACK_SCRIPT.LENGTH;
			}
		}
	return _cb;
}
/* Copyright 2023 Springroll Games / Yosi */