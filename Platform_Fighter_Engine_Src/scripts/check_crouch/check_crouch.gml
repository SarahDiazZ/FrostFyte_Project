///@category Player Actions
/*
Allows the player to crouch, and returns true if they do.
*/
function check_crouch() {
	//If control stick is below an amount
	if (stick_tilted(Lstick, DIR.down))
		{
		//Set the state to crouching and stop the script.
		state_set(PLAYER_STATE.crouching);
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */