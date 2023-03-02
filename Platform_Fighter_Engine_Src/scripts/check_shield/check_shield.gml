///@category Player Actions
/*
Allows the player to shield, and returns true if they do.
The specifics of this function change based on the <shield_type>:
	- perfect_shield_start / parry_shield : The player switches to the shield state and must remain in that state for the <shield_time_min>.
	- parry_press : The player starts a parry.
*/
function check_shield() {
	//If you are holding the shield button
	switch(shield_type)
		{
		case SHIELD_TYPE.perfect_shield_start:
			{
			if (input_held(INPUT.shield))
				{
				//Change to shielding state
				state_set(PLAYER_STATE.shielding);
				state_frame = shield_time_min;
				return true;
				}
			break;
			}
		case SHIELD_TYPE.parry_shield:
			{
			if (input_held(INPUT.shield))
				{
				//Change to shielding state
				state_set(PLAYER_STATE.shielding);
				state_frame = shield_time_min;
				return true;
				}
			break;
			}
		case SHIELD_TYPE.parry_press:
			{
			if (input_pressed(INPUT.shield))
				{
				//Change to parrying state
				state_set(PLAYER_STATE.parry_press);
				state_frame = parry_press_startup;
				return true;
				}
			break;
			}
		}
	return false;
}
/* Copyright 2023 Springroll Games / Yosi */