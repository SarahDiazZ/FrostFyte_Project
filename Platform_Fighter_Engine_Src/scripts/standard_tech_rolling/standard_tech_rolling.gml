///@category Player Standard States
/*
This script contains the default Tech rolling state characters are given.

The Tech rolling state is for players who were holding left or right when teching on the ground.
Tech rolls may have different frame data and animations than normal rolls.
*/
function standard_tech_rolling() {
	//Contains the standard actions for the tech rolling state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Techroll"]);
			//No speed
			speed_set(0, 0, false, false);
			//Invulnerable
			invulnerability_set(INV.invincible, techroll_startup);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Transition through phases of rolling
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
						state_frame = techroll_active;
						//Invulnerability
						invulnerability_set(INV.invincible, techroll_active);
						//Speed
						speed_set(techroll_speed * state_facing, 0, false, false);
						}
					break;
					}
				case 1:
					{
					//Speed
					speed_set(techroll_speed * state_facing, 0, false, false);
					if (state_frame == 0)
						{
						state_phase++;
						state_frame = techroll_endlag;
						}
					break;
					}
				case 2:
					{
					//No speed
					speed_set(0, 0, false, false);
					//End roll
					if (run && state_frame == 0)
						{
						state_phase = 0;
						//Position the player to be backwards
						if (state_facing != 0)
							{
							facing = -sign(state_facing);
							}
						//Back to Idle State, unless Shield is being held down
						if ((shield_type == SHIELD_TYPE.perfect_shield_start || shield_type == SHIELD_TYPE.parry_shield) && check_shield())
							{}
						else
							{
							state_set(PLAYER_STATE.idle);
							}
						run = false;
						}
					break;
					}
				default: break;
				}
		
			//Movement
			move_grounded();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */