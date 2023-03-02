///@category Player Actions
/*
Locks the calling player if they are in the knockdown state already, and the <knockdown_type> is KNOCKDOWN_TYPE.normal.
The maximum number of times a player can be locked is determined by <knockdown_lock_number>. After this amount, the player will be reset to the idle state when this function is called.
*/
function knockdown_lock() {
	//Reset the knockdown
	state_time = 0;
	state_phase++;
	
	//Max locks
	if (state_phase > knockdown_lock_number)
		{
		state_set(PLAYER_STATE.idle);
		return false;
		}
		
	//Screenshake
	camera_shake(0, 3);
	
	return true;
}
/* Copyright 2023 Springroll Games / Yosi */