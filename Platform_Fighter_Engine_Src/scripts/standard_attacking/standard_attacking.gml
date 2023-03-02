///@category Player Standard States
/*
This script contains the default Attacking state characters are given.

The Attacking state is for players who are using any kind of move, and runs their "attack_script".
*/
function standard_attacking() {
	//Contains the standard actions for the attacking state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.normal:
			{
			//Calls the attack script
			if (attack_script != -1 && script_exists(attack_script))
				{
				script_execute(attack_script);
				}
			else
				{
				state_set(PLAYER_STATE.idle);
				}
			//No movement in the Standard Attack Script - Individual attacks must move themselves!
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */