///@category Sound System
/*
Creates an instance of <obj_sound_system> to be used in the current room.
This can be used to play sound effects with the function <sound_system_play>.
*/
function sound_system_init() {
	if (!instance_exists(obj_sound_system))
		{
		instance_create_layer(x, y, layer, obj_sound_system);
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */