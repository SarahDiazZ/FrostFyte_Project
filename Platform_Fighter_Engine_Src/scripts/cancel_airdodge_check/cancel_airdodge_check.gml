///@category Attacking
/*
Allows the player to cancel an attack with an airdodge, and returns true if they do.
*/
function cancel_airdodge_check() {
	if (airdodges > 0 || airdodge_type == AIRDODGE_TYPE.momentum_keep)
		{
		//Check if the dodge button is being pressed
		if (input_pressed(INPUT.shield))
			{
			airdodges--;
			//Set the state
			attack_stop(PLAYER_STATE.airdodging);
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */