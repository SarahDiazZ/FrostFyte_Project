///@category Attacking
/*
Allows a player to start a dash grab, and returns true if they do.
This function does not check if the player is in a dashing state.
*/
function allow_dash_grabs() {
	//If the grab button has been pressed
	var _stick = stick_choose_by_input(INPUT.grab);
	if (input_pressed(INPUT.grab, buffer_time_standard, false))
		{
		if (item_system_type == ITEM_SYSTEM_TYPE.simplified)
			{
			//Try to pick up items. Stop the attack and clear the buffer if successful
			if (pick_up_item() != noone)
				{
				input_reset(INPUT.grab);
				return false;
				}
			}
		
		if (_stick == Rstick)
			{
			//Change direction
			var _frame = stick_find_frame(Rstick, false, true, DIR.horizontal, undefined, undefined, buffer_time_standard, false);
			if (_frame == -1) then _frame = 0;
			change_facing(Rstick, _frame);
			}
		else
			{
			change_facing(Lstick);
			}
		var _started = attack_start(my_attacks[$ "DashGrab"]);
		return _started;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */