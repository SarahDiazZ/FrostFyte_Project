///@param {string} filename		The name of the file to load
/*
Returns a string of the data in a file.
*/
function string_file_load() {
	var _filename, _buffer, _str;
	_filename = argument[0];

	//Make a data buffer from the file and put it in a string
	if (file_exists(_filename))
		{
		_buffer = buffer_load(_filename);
		_str = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);

		//Return the string
		return _str;
		}
	else
		{
		crash("[string_file_load] File does not exist! (", _filename, ")");
		return;
		}
}
/* Copyright 2023 Springroll Games / Yosi */