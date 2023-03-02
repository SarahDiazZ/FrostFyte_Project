///@category Profiles
///@param {int} profile					The index to check for
///@param {bool} [ignore_auto]			Whether to ignore autogenerated profiles or not
/*
Returns true if a profile exists with the given index.
You can optionally choose to ignore autogenerated profiles.
*/
function profile_exists() {
	var _profile = argument[0];
	var _ignore_auto = argument_count > 1 ? argument[1] : false;
	if (!_ignore_auto)
		{
		return (_profile >= 0 && _profile < array_length(engine().profiles));
		}
	else
		{
		return (_profile >= 0 && _profile < array_length(engine().profiles) && !profile_get(_profile, PROFILE.autogenerated))
		}
}
/* Copyright 2023 Springroll Games / Yosi */