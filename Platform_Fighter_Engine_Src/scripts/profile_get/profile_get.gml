///@category Profiles
///@param {int} profile				The index of the profile
///@param {int} setting				The setting to get, from the PROFILE enum
/*
Returns the value of the specified setting from a profile.
*/
function profile_get() {
	var _array = engine().profiles[@ argument[0]],
		_setting = argument[1];
	return _array[@ _setting];
}
/* Copyright 2023 Springroll Games / Yosi */