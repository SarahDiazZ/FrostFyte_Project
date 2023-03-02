///@category Player Standard States
/*
This script contains the default Getup state characters are given.

The Getup state is for players who use a neutral getup from the knockdown state.
*/
function standard_getup() {
	//Contains the standard actions for the getup state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Getup"]);
			//No speed
			speed_set(0, 0, false, false);
			state_frame = getup_active;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
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
						state_frame = getup_endlag;
						}
					break;
					}
				case 1:
					{
					if (run && state_frame == 0)
						{
						state_set(PLAYER_STATE.idle);
						run = false;
						}
					break;
					}
				default: break;
				}

			//No movement
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */