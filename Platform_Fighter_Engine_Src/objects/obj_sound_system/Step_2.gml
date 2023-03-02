///@description Count frame numbers on all sounds
var _array = variable_struct_get_names(sound_system_all_sounds);
var _length = array_length(_array);
for(var i = 0; i < _length; i++)
	{
	var _val = sound_system_all_sounds[$ _array[@ i]];
	if (_val < sound_system_max_frame_count)
		{
		sound_system_all_sounds[$ _array[@ i]] = _val + 1;
		}
	}
/* Copyright 2023 Springroll Games / Yosi */