///@category Sound System
/*
Returns the x value of the listener's position, for stereo.
By default, this is the middle point between the left and right blastzones.
If <obj_stage_manager> is not in the room, it will return the middle point of the room.
*/
function sound_system_listener_x_get() {
	assert(instance_number(obj_sound_system) > 0, "obj_sound_system did not exist when sound_system_listener_x_get was called");
	return (instance_number(obj_stage_manager) > 0)
		? mean(obj_stage_manager.blastzones.left, obj_stage_manager.blastzones.right)
		: (room_width div 2);
}
/* Copyright 2023 Springroll Games / Yosi */