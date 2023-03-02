///@category Player Standard States
/*
This script contains the default Grab Release state characters are given.

The Grab Release state is used when an opponent breaks out of the player's grab.
Please note: The player breaking out of the grab uses the "in_hitstun" state.
*/
function standard_grab_release() {
	//Contains the standard actions for the grab release state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "GrabRel"]);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//No vertical movement
			speed_set(0, 0, true, false);

			//Friction / Gravity
			friction_gravity(hard_landing_friction, grav, max_fall_speed);

			//Aerial
			if (run && check_aerial()) then run = false;

			//When the lag is done
			if (run && state_frame == 0)
				{
				//Return to idle state
				state_set(PLAYER_STATE.idle);
				run = false;
				}

			move();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */