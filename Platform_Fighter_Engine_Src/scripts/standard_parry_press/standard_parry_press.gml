///@category Player Standard States
/*
This script contains the default Parry Press state characters are given.

The Parry Press state is only accessible when <shield_type> is set to SHIELD_TYPE.parry_press.
*/
function standard_parry_press() {
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Run the start phase of the parry script, which handles animation
			if (script_exists(parry_press_script))
				{
				script_execute(parry_press_script, PHASE.start);
				}
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Calls the parry script
			if (script_exists(parry_press_script))
				{
				script_execute(parry_press_script);
				}
			else
				{
				state_set(PLAYER_STATE.idle);
				}
		
			//No movement in the Standard Parry Script - Must be inside the custom script!
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */