///@category Player Standard States
/*
This script contains the default Wall Jump state characters are given.

The Wall Jump state is for players who are jumping off a wall.
The inputs needed to wall jump are determined by the <wall_jump_type>, and can be viewed in <check_wall_jump>.
*/
function standard_wall_jump() {
	//Contains the standard actions for the wall jump state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "WallJ"]);
			//Phase
			state_phase = 0;
			//Landing
			landed_on_ground = false;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Landing
			if (run && check_landing()) run = false;
	
			//Transition through phases of wall jumping
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
		
						if (run && state_frame == 0)
							{
							state_phase = 0;
							state_frame = 0;
							wall_jump_timeout = wall_jump_normal_timeout;
							state_set(PLAYER_STATE.aerial);
							run = false;
							}
			
						//Cancels
						if (run && double_jumps > 0)
							{
							//If jump is being pressed
							if (input_pressed(INPUT.jump))
								{
								double_jump();
								run = false;
								}
							}
				
						//Airdodge
						if (run && check_airdodge()) run = false;
						
						//Items
						if (item_system_type == ITEM_SYSTEM_TYPE.standard ||
							item_system_type == ITEM_SYSTEM_TYPE.simplified)
							{
							if (run && allow_item_throws()) then run = false;
							}
						
						//Attacking
						if (run && allow_smash_attacks()) run = false;
						if (run && allow_special_attacks())	run = false;
						if (run && allow_aerial_attacks()) run = false;
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