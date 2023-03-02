///@category Sound System
/*
Returns the width of the sound space, for stereo.
By default, this is a quater of the distance between the left and right blastzones.
If <obj_stage_manager> is not in the room, it will return a quarter of the width of the room.
*/
function sound_system_listener_width_get() {
	assert(instance_number(obj_sound_system) > 0, "obj_sound_system did not exist when sound_system_listener_width_get was called");
	return (instance_number(obj_stage_manager) > 0)
		? abs(obj_stage_manager.blastzones.left - obj_stage_manager.blastzones.right) / 4
		: (room_width / 4);
}
/* Copyright 2023 Springroll Games / Yosi */