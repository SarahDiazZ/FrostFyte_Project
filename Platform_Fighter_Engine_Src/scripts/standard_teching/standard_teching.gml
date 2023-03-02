///@category Player Standard States
/*
This script contains the default Tech state characters are given.

The Tech state is for players who pressed the shield input just before hitting a hard surface.
Teching stops the player's knockback and grants the player brief invincibility.
*/
function standard_teching() {
	//Contains the standard actions for the teching state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Teching"]);
			//No speed
			speed_set(0, 0, false, false);
			//Invulnerable
			invulnerability_set(INV.invincible, tech_active);
			state_frame = tech_active;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Transition through phases of teching
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
						state_frame = tech_endlag;
						}
					break;
					}
				case 1:
					{
					if (run && state_frame == 0)
						{
						if (on_ground())
							{
							state_set(PLAYER_STATE.idle);
							}
						else
							{
							state_set(PLAYER_STATE.aerial);
							}
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