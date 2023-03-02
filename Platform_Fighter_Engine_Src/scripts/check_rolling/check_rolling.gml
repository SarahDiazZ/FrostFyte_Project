///@category Player Actions
/*
Allows the player to roll, and returns true if they do.
Please note: This function does not check if the player is on the ground.
*/
function check_rolling() {
	//If you are pressing a direction and the dodge buttons
	if (input_pressed(INPUT.shield, buffer_time_standard, false))
		{
		var _frame = stick_find_frame(Lstick, false, true, DIR.horizontal);
		if (_frame != -1)
			{
			//Reset shield button
			input_reset(INPUT.shield);
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