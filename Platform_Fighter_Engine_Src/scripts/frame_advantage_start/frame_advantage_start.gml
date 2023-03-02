///@category Attacking
///@param {id} attacker		        The player attacking
///@Parma {int} stun_frames         The number of frames the target will be inactionable. This is usually hitlag + hitstun
/*
Please note: This function only works if <show_frame_advantage> is turned on.
Sets the frame advantage of the attacking player to the given "stun_frames" value.
This number will count down until <frame_advantage_end> is called.
*/
function frame_advantage_start() {
	var _attacker = argument[0];
	var _stun_frames = argument[1];
	
	if (!setting().show_frame_advantage) then return false;
	
	with(_attacker)
		{
		if (!object_is(object_index, obj_player)) then return false;
		custom_passive_struct.frame_advantage_value = _stun_frames;
		custom_passive_struct.frame_advantage_count = true;
		}
	return true;
}
/* Copyright 2023 Springroll Games / Yosi */