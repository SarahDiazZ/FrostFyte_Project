///@category Attacking
///@param {id} [player]     The player to stop counting frame advantage for
/*
Please note: This function only works if <show_frame_advantage> is turned on.
Stops the frame advantage number for the given player from counting down any further.
This value will remain until <frame_advantage_start> is called.
*/
function frame_advantage_stop() {
	var _player = argument_count > 0 ? argument[0] : id;
	
	if (!setting().show_frame_advantage) then return false;
	
	with(_player)
		{
		if (!object_is(object_index, obj_player)) then return false;
		custom_passive_struct.frame_advantage_count = false;
		}
	return true;
}
/* Copyright 2023 Springroll Games / Yosi */