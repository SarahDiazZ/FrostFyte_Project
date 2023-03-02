///@category Attacking
/*
Allows a player to start a normal grab, and returns true if they do.
*/
function allow_grabs() {
	//If one stick is set to grab it overrides the direction of the other stick
	var _stick = stick_choose_by_input(INPUT.grab);
	//If the grab button has been pressed OR if the player was holding shield and pressed the attack button
	if (input_pressed(INPUT.grab, buffer_time_standard, false) || 
		(grab_with_shield_and_attack && input_held(INPUT.shield) && input_pressed(INPUT.attack, buffer_time_standard, false)))
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
		var _started = attack_start(my_attacks[$ "Grab"]);
		return _started;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */