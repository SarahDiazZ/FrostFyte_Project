///@category Sound System
///@param {asset} sound					The sound to play
///@param {real} priority				The priority of the sound
///@param {bool} loops					Whether the sound automatically loops or not
///@param {asset} audio_group			The audio group of the sound
///@param {real} [x]					The x position the sound is being played from, for stereo
///@param {real} [width]				The total width of the possible x values, for stereo
/*
Plays a sound and adjusts the volume of the sound based on the volume of the given audio group.
You can optionally supply an "x" and "width", which will determine which side the sound is played on.
Warning: This only supports the three default audio groups (audiogroup_music, audiogroup_sound_effects, and audiogroup_menu).
*/
function audio_play_sound_adjusted() {
	var _index = argument[0];
	var _priority = argument[1];
	var _loops = argument[2];
	var _group = argument[3];
	var _x = argument_count > 4 ? argument[4] : undefined;
	var _w = argument_count > 5 ? argument[5] : undefined;
	
	var _volume = audio_sound_get_gain(_index);
	switch(_group)
		{
		case audiogroup_menu:
			_volume *= setting().volume_menu;
			break;
		case audiogroup_music:
			_volume *= setting().volume_music;
			break;
		case audiogroup_sound_effects:
			_volume *= setting().volume_sound_effects;
			break;
		}
	var _snd = noone;
	if (!is_undefined(_x) && !is_undefined(_w))
		{
		_snd = audio_play_sound_at(_index, _x, 0, 0, _w, 1, 1, _loops, _priority);
		}
	else
		{
		_snd = audio_play_sound(_index, _priority, _loops);
		}
	audio_sound_gain(_snd, _volume, 0);
	return _snd;
}
/* Copyright 2023 Springroll Games / Yosi */