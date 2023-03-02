///@category Player Standard States
/*
This script contains the default Rolling state characters are given.

The Rolling state is for players who are dodge rolling.
*/
function standard_rolling() {
	//Contains the standard actions for the rolling state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Rolling"]);
			//Speeds
			speed_set(0, 0, false, false);
			//Timers
			state_frame = roll_startup;
			state_phase = 0;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Animation is done in the phase switch
			//Special Airdodge exception for "momentum_stop" Airdodge
			if (run && state_phase == 0 && airdodge_type == AIRDODGE_TYPE.momentum_stop)
				{
				//If the jump button is pressed
				if (input_pressed(INPUT.jump))
					{
					//Cancel the roll
					state_phase = 0;
					state_frame = 0;
					//Set the state
					state_set(PLAYER_STATE.airdodging);
					//Set speeds
					var spd, dir;
					//If the control stick is not being pressed far enough, there is no movement
					if (stick_tilted(Lstick))
						{
						spd = airdodge_speed;
						dir = point_direction(0, 0, stick_get_value(Lstick, DIR.horizontal) * 10, stick_get_value(Lstick, DIR.vertical) * 10);
						}
					else
						{
						spd = 0;
						dir = 90;
						}
					speed_set(lengthdir_x(spd, dir), lengthdir_y(spd, dir), false, false);
					run = false;
					}
				}
	
			//Cancel in air
			if (run && !on_ground())
				{
				state_set(PLAYER_STATE.aerial);
				run = false;
				}
	
			//Transition through phases of rolling
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
							state_frame = roll_active;
							//Invulnerability
							invulnerability_set(INV.invincible, roll_active);
							//Speed
							speed_set(roll_speed * state_facing, 0, false, false);
							}
						break;
						}
					case 1:
						{
						//Speed
						speed_set(roll_speed * state_facing, 0, false, false);
						if (state_frame == 0)
							{
							state_phase++;
							state_frame = roll_endlag;
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
				}
	
			move_grounded();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */