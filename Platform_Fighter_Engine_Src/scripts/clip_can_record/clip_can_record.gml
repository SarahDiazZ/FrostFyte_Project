///@category Clips
///@param
/*
Returns true if clips can be recorded in the current match.
Clips can be recorded if setting().<clip_record> is true, and <game_is_online> and <web_export> are false.
*/
function clip_can_record() {
	return (!web_export && setting().clip_record && !game_is_online());
}
/* Copyright 2023 Springroll Games / Yosi */