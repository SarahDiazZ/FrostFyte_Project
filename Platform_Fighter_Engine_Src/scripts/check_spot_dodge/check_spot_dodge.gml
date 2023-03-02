///@category Player Actions
/*
Allows the player to spot dodge, and returns true if they do.
Does not work if the <shield_type> is set to SHIELD_TYPE.parry_press.
*/
function check_spot_dodge() {
	//If the shield type is set to parry, you can't spot dodge
	if (shield_type == SHIELD_TYPE.parry_press) return false;
	//If the control stick is flicked downwards
	if (stick_flicked(Lstick, DIR.down))
		{
		//Set the state to spot dodging and stop the script.
		state_set(PLAYER_STATE.spot_dodging);
		state_frame = spot_dodge_startup;
		return true;
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */