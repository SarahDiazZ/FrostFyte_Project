///@category Profiles
///@param {int} profile				The index of the profile
///@param {int} setting				The setting to set, from the PROFILE enum
///@param {any} value				The value to set it to
/*
Sets a property for the given profile. The property should be from the PROFILE enum.
*/
function profile_set() {
	var _array = engine().profiles[@ argument[0]],
		_setting = argument[1],
		_val = argument[2];
	
	_array[@ _setting] = _val;
}
/* Copyright 2023 Springroll Games / Yosi */