///@category Player Actions
///@param {id} target					The player to grab
///@param {int} hold_x					The relative x position to hold them at (assume the grabber is facing right)
///@param {int} hold_y					The relative y position to hold them at
///@param {bool} [grab_break]			Whether this command grab can be broken or not
/*
Grabs the given player WITHOUT changing the attacking player to the "grabbing" state.
This is different from grab hitboxes, which will cancel the current attack and leave the player in the "grabbing" state on hit.
If <grab_break_enable> is true, you can decide if the command grab can be broken or not. If you do not specify, the <grab_break_command_grabs_default> is used.
*/
function command_grab() {
	var _target = argument[0];
	var _x = argument[1];
	var _y = argument[2];
	var _can_grab_break = argument_count > 3 ? argument[3] : grab_break_command_grabs_default;

	with(_target)
		{
		attack_stop(PLAYER_STATE.is_grabbed);
		grab_hold_id = other.id;
		other.grabbed_id = id;
		grab_hold_x = round(_x);
		grab_hold_y = round(_y);
		grab_hold_enable = true;
		speed_set(0, 0, false, false);
		
		//Grab breaking
		if (!_can_grab_break)
			{
			state_phase = 1;
			}
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */