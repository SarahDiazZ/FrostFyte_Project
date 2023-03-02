///@category Player Actions
/*
If the player is currently in the air, this function switches them to the aerial state and returns true.
*/
function check_aerial() {
	if (!on_ground())
		{
		//You're in the air
		state_set(PLAYER_STATE.aerial);
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */