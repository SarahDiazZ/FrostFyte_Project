///@category Player Standard States
/*
This script contains the default Ledge Trump state characters are given.

The Ledge Snap state is for players who were forced off the ledge when another player grabbed the ledge after them.
This can only happen when the <ledge_type> is set to LEDGE_TYPE.trump.
*/
function standard_ledge_trump() {
	//Contains the standard actions for the ledge trump state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "LedgeTr"]);
			//No invincibility
			invulnerability_set(INV.normal, 1);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Vulnerable
			invulnerability_set(INV.normal, 1);
	
			//Friction / Gravity
			friction_gravity(air_friction, grav, max_fall_speed);
	
			//When the lag is done
			if (run && state_frame == 0)
				{
				//Return to aerial state
				state_set(PLAYER_STATE.aerial);
				run = false;
				}
		
			move();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */