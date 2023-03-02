///@category Attacking
/*
Allows a player to start a dash attack, and returns true if they do.
This function does not check if the player is in a dashing state.
*/
function allow_dash_attacks() {
	//Checks for Dash Attack
	if (input_pressed(INPUT.attack, buffer_time_standard, false))
		{
		if (item_system_type == ITEM_SYSTEM_TYPE.standard ||
			item_system_type == ITEM_SYSTEM_TYPE.simplified)
			{
			//Pick up items and continue attacking
			pick_up_item();
			}
			
		//No direction change
		var _started = attack_start(my_attacks[$ "DashAtk"]);
		return _started;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */