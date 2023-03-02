///@category Stages
///@param {asset} song					The song to play
///@param {real} [intro_length]			The length of the "intro" of the song, in seconds
///@param {real} [loop_length]			The position in the song that should loop back to the end of the intro, in seconds
/*
Sets the music for the current stage.
If intro and loop positions are given, the song will play until it gets to the loop position, and then jump back to the intro position.
Warning: If the loop position is exactly at the end of the song there may be some issues with looping. Please add 1-2 extra seconds onto the end of the song to ensure it always loops properly.
*/
function stage_music_set() {
	var _song = argument[0];
	var _intro = argument_count > 1 ? argument[1] : 0;
	var _loop = argument_count > 2 ? argument[2] : 0;

	with(obj_stage_manager)
		{
		music = audio_play_sound_adjusted(_song, 0, true, audiogroup_music);
		music_intro_pos = _intro;
		music_loop_pos = _loop;
		}
}
/* Copyright 2023 Springroll Games / Yosi */