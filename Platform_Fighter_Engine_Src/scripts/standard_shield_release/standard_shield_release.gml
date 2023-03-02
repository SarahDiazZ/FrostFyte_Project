///@category Player Standard States
/*
This script contains the default Shield Release state characters are given.

The Shield Release state is for players who stopped holding the shield input. If players cancel the shield through a jump, roll, spotdodge etc. they will not go through this state.
*/
function standard_shield_release() {
	//Contains the standard actions for the shield release state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "ShieldR"]);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//No vertical movement
			speed_set(0, 0, true, false);

			//Friction
			friction_gravity(hard_landing_friction);

			//Aerial
			if (run && check_aerial()) then run = false;

			//Drop Throughs
			if (run && check_drop_through()) run = false;

			//When the lag is done
			if (run && state_frame == 0)
				{
				//Return to idle state
				state_set(PLAYER_STATE.idle);
				run = false;
				}

			move_grounded();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */