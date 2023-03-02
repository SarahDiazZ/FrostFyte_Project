///@category Sound System
///@param {asset} sound				The sound effect to play
///@param {real} [x]				The x position the sound is being played from, for stereo
/*
Plays the given sound without looping, and returns the sound index.
You can optionally supply an x position, which will determine which side the sound is played on if setting().<stereo_sound_effects> is true.

If the same sound was played very recently, the sound will not be played to prevent overlapping sounds.
During online matches, additional checks are in place to ensure sounds play correctly without overlapping or repeating.

This is intended to play sound effects, and uses the sound effect audiogroup.

Please note: This function requires <obj_sound_system> to be in the room.
*/
function game_sound_play() {
	var _snd = argument[0];
	var _x = argument_count > 1 ? argument[1] : x;
	
	var _index = sound_system_play(_snd, false, 5, 5, 0, true, _x);
	return _index;
}
/* Copyright 2023 Springroll Games / Yosi */