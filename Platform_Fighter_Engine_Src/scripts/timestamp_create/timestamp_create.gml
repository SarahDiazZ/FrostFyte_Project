/*
Creates a string of the current time in the following format:
	- MM-DD-YY (HH-MM-SS)
*/
function timestamp_create() {
	var _stamp = 
		string_replace(string_format(current_month,		2, 0), " ", "0") + "-" + 
		string_replace(string_format(current_day,		2, 0), " ", "0") + "-" + 
		string_replace(string_format(current_year,		2, 0), " ", "0") + " (" + 
		string_replace(string_format(current_hour,		2, 0), " ", "0") + "-" + 
		string_replace(string_format(current_minute,	2, 0), " ", "0") + "-" + 
		string_replace(string_format(current_second,	2, 0), " ", "0") + ")";
	return _stamp;
}
/* Copyright 2023 Springroll Games / Yosi */