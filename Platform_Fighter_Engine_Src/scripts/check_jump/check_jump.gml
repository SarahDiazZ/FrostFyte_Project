///@category Player Actions
/*
Allows the player to start a jump, and returns true if they do.
This is only for grounded jumping.
*/
function check_jump() {
	//If the jump button is pressed
	if (on_ground())
		{
		if (input_pressed(INPUT.jump))
			{
			//Change to the jumpsquat state, and set the timer
			state_set(PLAYER_STATE.jumpsquat);
			state_frame = jumpsquat_time;
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */