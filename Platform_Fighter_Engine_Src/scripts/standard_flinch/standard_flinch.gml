///@category Player Standard States
/*
This script contains the default Flinch state characters are given.

The Flinch state is for players hit by a weak attack on the ground that doesn't have enough knockback to launch.
*/
function standard_flinch() {
	//Contains the standard actions for the flinch state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Cancel into hitstun in the air
			if (!on_ground())
				{
				state_set(PLAYER_STATE.hitstun);
				break;
				}
			//Animation
			anim_set(my_sprites[$ "Flinch"]);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//No vertical movement
			speed_set(0, 0, true, false);

			//Friction / Gravity
			friction_gravity(hard_landing_friction, grav, max_fall_speed);

			//Cancel into hitstun when in the air
			if (run && !on_ground())
				{
				var _frame = state_frame;
				state_set(PLAYER_STATE.hitstun);
				state_frame = _frame;
				run = false;
				}

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