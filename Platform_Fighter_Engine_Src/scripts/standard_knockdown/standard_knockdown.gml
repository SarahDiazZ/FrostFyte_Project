///@category Player Standard States
/*
This script contains the default Knockdown state characters are given.

The Knockdown state is for players who have been hit into the ground and did not bounce off the surface or tech.
Characters use their crouch hurtbox during this state.

The specifics depend on the <knockdown_type>. For KNOCKDOWN_TYPE.slide, the state will behave almost identically to the flinch state.
For KNOCKDOWN_TYPE.normal, players will have to manually choose a getup option - a normal getup, roll, or getup attack.
*/
function standard_knockdown() {
	//Contains the standard actions for the knockdown state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Knockdown"]);
			
			//Sound
			game_sound_play(snd_collide);
			
			//Hurtbox
			hurtbox_anim_set(hurtbox_crouch_sprite, round(anim_frame), facing, 1, 0);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Sliding knockdown
			if (knockdown_type == KNOCKDOWN_TYPE.slide)
				{
				//No vertical movement
				speed_set(0, 0, true, false);

				//Friction / Gravity
				friction_gravity(hard_landing_friction, grav, max_fall_speed);

				//Aerial
				if (run && check_aerial()) then run = false;

				//When the lag is done
				if (run && state_frame == 0)
					{
					//Return to idle state
					state_set(PLAYER_STATE.idle);
					run = false;
					}

				//Stay on the ground
				move_grounded();
				}
			//Normal knockdown (with locking and resets)
			else if (knockdown_type == KNOCKDOWN_TYPE.normal)
				{
				//Reset the animation after being locked
				if (state_time == 1 && state_phase > 0)
					{
					anim_set(my_sprites[$ "Lock"]);
					}
	
				//No vertical movement
				speed_set(0, 0, true, false);

				//Friction / Gravity
				friction_gravity(hard_landing_friction, grav, max_fall_speed);

				//Aerial
				if (run && check_aerial()) then run = false;

				//Getup options
				if (run && state_phase > 0 && state_time >= knockdown_lock_time_min)
					{
					//Locked players are forced to do normal getup
					state_set(PLAYER_STATE.getup);
					run = false;
					}
				if (run && state_phase == 0 && state_time >= knockdown_time_min)
					{
					//Getup attack
					if (run && (input_held(INPUT.attack) || 
						input_held(INPUT.special) || 
						input_held(INPUT.grab) || 
						input_held(INPUT.smash)))
						{
						attack_start(my_attacks[$ "GetupAtk"]);
						run = false;
						}
						
					//Rolling
					if (run && stick_tilted(Lstick, DIR.horizontal))
						{
						state_set(PLAYER_STATE.tech_rolling);
						//Set the rolling direction to match the ledge facing direction
						state_facing = sign(stick_get_value(Lstick, DIR.horizontal));
						run = false;
						}
						
					//Normal Getup
					if (run && (stick_tilted(Lstick, DIR.up) || input_pressed(INPUT.jump)))
						{
						state_set(PLAYER_STATE.getup);
						invulnerability_set(INV.invincible, getup_active);
						run = false;
						}
					}
					
				//Auto getup
				if (run && state_time >= knockdown_time_max)
					{
					state_set(PLAYER_STATE.teching);
					run = false;
					}

				//Stay on the ground
				move_grounded();
				}
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */