///@category FX
///@param {resouce} sounds				The sound to play, or an array of sounds to choose a sound from
///@param {real} [pitch_shift]			The maximum amount of pitch shift
///@param {real} [x]					The x position the sound is being played from, for stereo
/*
Plays the given hit sound effect.
The default amount of pitch shift is <hit_sound_pitch_variance>.
You can optionally supply an x position, which will determine which side the sound is played on if setting().<stereo_sound_effects> is true.
*/
function hit_sfx_play() {
	var _snd = argument[0],
	var _pitch = argument_count > 1 ? argument[1] : hit_sound_pitch_variance;
	var _x = argument_count > 2 ? argument[2] : x;

	if (_snd != -1)
		{
		//Choose a random sound to play if an array is given
		if (is_array(_snd))
			{
			_snd = _snd[@ prng_number(0, array_length(_snd) - 1)];
			}
			
		var _index = sound_system_play(_snd, hit_sound_replace, hit_sound_priority_default, hit_sound_replay_timer_default, _pitch, true, _x);
		return _index;
		}
	return undefined;
}
/* Copyright 2023 Springroll Games / Yosi */