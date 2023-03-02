///@category Sound System
///@param {asset} sound			The menu sound to play
/*
Plays the given sound without looping, and returns the sound index.
This is intended to play menu sounds, and uses the menu audiogroup.
*/
function menu_sound_play(){
	var _index = audio_play_sound_adjusted(argument[0], 0, false, audiogroup_menu);
	return _index;
}
/* Copyright 2023 Springroll Games / Yosi */