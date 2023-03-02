///@category Attacking
/*
If the player is in the air, their attack is canceled and the function returns true.
*/
function cancel_air_check() {
	if (!on_ground())
		{
		attack_stop(PLAYER_STATE.aerial);
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */