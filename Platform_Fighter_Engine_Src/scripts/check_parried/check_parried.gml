///@category Player Actions
/*
Switches the player to either the parry stun state or the helpless state if their recent attack was parried.
This only works when the <shield_type> is set to SHIELD_TYPE.parry_press, and is NOT related to SHIELD_TYPE.parry_shield.
*/
function check_parried() {
	if (shield_type == SHIELD_TYPE.parry_press)
		{
		if (has_been_parried)
			{
			has_been_parried = false;
			if (on_ground())
				{
				state_set(PLAYER_STATE.parry_stun);
				state_frame = parry_stun_time;
				}
			else
				{
				state_set(PLAYER_STATE.helpless);
				}
			return true;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */