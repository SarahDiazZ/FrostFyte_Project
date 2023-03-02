///@category Player Actions
/*
Allows the player to roll simply by flicking left or right, and returns true if they do.
This is only used in the shielding state.
*/
function check_rolling_hold() {
	//If you are pressing a direction and the dodge buttons
	if (input_held(INPUT.shield, buffer_time_standard))
		{
		var _frame = stick_find_frame(Lstick, false, true, DIR.horizontal);
		if (_frame != -1)
			{
			state_set(PLAYER_STATE.rolling);
			//Facing
			change_facing(Lstick, _frame);
			//Set the rolling direction
			state_facing = facing;
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */