///@category Player Actions
/*
Allows the player to airdodge by pressing the shield input (even if they aren't in the air), and returns true if they do.
*/
function check_airdodge() {
	//If you have another airdodge
	if (airdodges > 0 || airdodge_type == AIRDODGE_TYPE.momentum_keep)
		{
		//Check if the dodge button is being pressed
		if (input_pressed(INPUT.shield))
			{
			airdodges--;
			//Set the state
			state_set(PLAYER_STATE.airdodging);
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */