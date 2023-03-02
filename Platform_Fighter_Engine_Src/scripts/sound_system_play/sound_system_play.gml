///@category Sound System
///@param {asset} sound						The sound to play
///@param {bool} [replace]					Whether to stop the sound if it is already being played
///@param {int} [priority]					The priority
///@param {int} [replay_timer]				The maximum amount the pitch can vary
///@param {real} [pitch_variance]			How long the sound must be active before it can be played again
///@param {bool} [play_over_current]		If the sound can be played even if it is already played
///@param {real} [x]						The x position the sound is being played from, for stereo
/*
Plays a sound after checking with <obj_sound_system> to make sure the sound cannot overlap / repeat.
This is intended for playing sound effects, and uses the sound effect audiogroup.
You can optionally supply an x position, which will determine which side the sound is played on if setting().<stereo_sound_effects> is true.
*/
function sound_system_play() {
	with(obj_sound_system)
		{
		var _snd = argument[0];
		var _replace = argument_count > 1 ? argument[1] : true;
		var _priority = argument_count > 2 ? argument[2] : 0;
		var _replay_timer = argument_count > 3 ? argument[3] : 3;
		var _pitch = argument_count > 4 ? argument[4] : 0;
		var _play_over_current = argument_count > 5 ? argument[5] : true;
		var _x = argument_count > 6 ? argument[6] : undefined;
		var _name = string(_snd);
		
		//Make sure playing over the current sound is allowed or the sound is not currently playing
		if (_play_over_current || !audio_is_playing(_snd))
			{
			//Make sure the sound is past the replay timer
			if (!variable_struct_exists(sound_system_all_sounds, _name) ||
				sound_system_all_sounds[$ _name] >= _replay_timer)
				{
				//Replacing the old sound
				if (_replace)
					{
					audio_stop_sound(_snd);
					}
			
				//Play the sound and store the index
				var _w;
				if (setting().stereo_sound_effects)
					{
					_x = (-_x) + sound_system_listener_x_get();
					_w = sound_system_listener_width_get();
					}
				else
					{
					_x = undefined;
					_w = undefined;
					}
				var _index = audio_play_sound_adjusted
					(
					_snd, 
					_priority, 
					false, 
					audiogroup_sound_effects, 
					_x,
					_w,
					);
			
				//Pitch
				audio_sound_pitch(_index, 1 + random_range(-_pitch, _pitch));
			
				//Zero frames since the sound has been played
				sound_system_all_sounds[$ _name] = 0;
			
				//Return the sound index
				return _index;
				}
			}
		
		//If no sound was played
		return undefined;
		}
	crash("obj_sound_system did not exist when sound_system_play was called");
}
/* Copyright 2023 Springroll Games / Yosi */