///@category Player Actions
/*
Allows the player to start walking, and returns true if they do.
*/
function check_walk() {
	//If the control stick is past a threshold
	if (stick_tilted(Lstick, DIR.horizontal))
		{
		//Change the direction facing
		change_facing();
		
		//Set the state to walking and stop the script.
		state_set(PLAYER_STATE.walking);
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */