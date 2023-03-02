///@category Player Standard States
/*
This script contains the default Tech Wall Jump state characters are given.

The Tech Wall Jump state is when players tech against a wall while holding the jump input or tilting the control stick upwards.
*/
function standard_tech_wall_jump() {
	//Contains the standard actions for the tech wall jump state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Techjump"]);
			//No speed
			speed_set(0, 0, false, false);
			//Landing
			landed_on_ground = false;
			//Invulnerable
			invulnerability_set(INV.invincible, tech_active);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Landing
			if (run && check_landing()) run = false;

			//Transition through phases of tech wall jumping
			if (run)
				{
				switch(state_phase)
					{
					case 0:
						{
						//Speeds
						speed_set(0, 0, false, false);
		
						if (state_frame == 0)
							{
							state_phase++;
							state_frame = wall_jump_time;
							speed_set(wall_jump_hsp * facing, wall_jump_vsp, false, false);
							}
						break;
						}
					case 1:
						{
						//Speeds
						friction_gravity(air_friction, grav, max_fall_speed);
		
						//Invulnerability
						invulnerability_set(INV.invincible, 1);
		
						if (run && state_frame == 0)
							{
							state_phase = 0;
							state_frame = 0;
							state_set(PLAYER_STATE.aerial);
							run = false;
							}
			
						break;
						}
					}
				}

			move();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */