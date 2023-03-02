///@category Profiles
///@param {int} profile			The index of the profile to destroy
/*
Removes a profile from the profiles array.
*/
function profile_destroy() {
	array_delete(engine().profiles, argument[0], 1);
}
/* Copyright 2023 Springroll Games / Yosi */