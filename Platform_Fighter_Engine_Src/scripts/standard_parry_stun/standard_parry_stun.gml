///@category Player Standard States
/*
This script contains the default Parry Stun state characters are given.

The Parry Stun state is for players who have been parried when <shield_type> is set to SHIELD_TYPE.parry_press.
*/
function standard_parry_stun() {
	//Contains the standard actions for the parry stun state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "ParryS"]);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Animation
			anim_loop_continue(my_sprites[$ "ParryS"]);

			//Friction and Gravity
			friction_gravity(hard_landing_friction, grav, max_fall_speed);
			
			//Cancel in the air
			if (run && check_aerial()) run = false;

			//When the lag is done
			if (run && state_frame == 0)
				{
				//Return to idle state
				state_set(PLAYER_STATE.idle);
				run = false;
				}
			
			//Color fade
			flash_alpha = 0.5;
			flash_color = c_black;
			
			move();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */