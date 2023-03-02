///@category Player Standard States
/*
This script contains the default Spot Dodging state characters are given.

The Spot Dodging state is for players who are spot dodging, which is triggered by flicking down on the control stick while shielding.
*/
function standard_spot_dodging() {
	//Contains the standard actions for the spot dodge state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "SDodge"]);
			//No invulnerability
			invulnerability_set(INV.normal, 0);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Animation is done in the phase switch
			//Cancel in air
			if (run && !on_ground())
				{
				state_set(PLAYER_STATE.aerial);
				run = false;
				}
	
			//Transition through phases of spot dodging
			if (run)
				{
				switch(state_phase)
					{
					case 0:
						{
						//No speed
						speed_set(0, 0, false, false);
						if (state_frame == 0)
							{
							//Next phase
							state_phase++;
							state_frame = spot_dodge_active;
							//Invulnerability
							invulnerability_set(INV.invincible, spot_dodge_active);
							}
						break;
						}
					case 1:
						{
						if (state_frame == 0)
							{
							state_phase++;
							state_frame = spot_dodge_endlag;
							}
						break;
						}
					case 2:
						{
						//End spot dodge
						if (state_frame == 0)
							{
							state_phase = 0;
							//Back to Idle State, unless Shield is being held down
							if (!check_shield())
								{
								state_set(PLAYER_STATE.idle);
								}
							else
								{
								state_set(PLAYER_STATE.shielding);
								}
							}
						break;
						}
					default: break;
					}
				}
	
			move_grounded();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */