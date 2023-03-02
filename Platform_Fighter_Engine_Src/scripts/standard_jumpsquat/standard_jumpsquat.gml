///@category Player Standard States
/*
This script contains the default Jumpsquat state characters are given.
The Jumpsquat state is the startup of grounded jumps. 
When the jumpsquat time ends, players will either perform a short hop or a full hop, depending on if they are still holding the jump input.
Please note: Players will jump at the end of jumpsquat regardless of if they are still touching the ground or not.
*/
function standard_jumpsquat() {
	//Contains the standard actions for the jumpsquat state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "JumpSquat"]);
			
			//Jumping variables
			jump_is_midair_jump = false;
			jump_is_dash_jump = false;
			jump_is_shorthop = false;
			landed_on_ground = false;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Gravity
			friction_gravity(0, grav, max_fall_speed);
	
			//Airdodge out of jumpsquat (wavedash)
			if (airdodge_from_jumpsquat && airdodge_type == AIRDODGE_TYPE.momentum_stop)
				{
				if (run && check_airdodge()) run = false;
				}
	
			//Upwards attacks out of jumpsquat if the special control setting is on
			//This is mainly for Tap Jump players, but can be used to do attacks out of shield faster
			if (scs[@ SCS.jumpsquat_attacks])
				{
				if (run && allow_upward_ground_attacks()) run = false;
				}
	
			//Jumping
			if (run)
				{
				//If jumpsquat timer is done
				if (state_frame == 0)
					{
					//Jumpsquat turnaround
					if (jumpsquat_allow_turnaround)
						{
						change_facing();
						}
			
					//Change state to aerial state, set speed, and exit the script.
					//Preserve certain jump variables
					var _jump_is_shorthop = jump_is_shorthop;
					var _jump_is_dash_jump = jump_is_dash_jump;
					state_set(PLAYER_STATE.aerial);
					jump_is_shorthop = _jump_is_shorthop;
					jump_is_dash_jump = _jump_is_dash_jump;
		
					//VFX
					vfx_create(spr_dust_jump, 1, 0, 18, x, (bbox_bottom - 1) - 1, 2, 0);
					
					//Short Hop Aerial
					if (run && scs[@ SCS.short_hop_aerial] && input_pressed(INPUT.attack, buffer_time_standard, false))
						{
						jump_is_shorthop = true;
						run = false;
						}
		
					//Check for shorthops (if you're not holding the jump button when jumping happens)
					if (!input_held(INPUT.jump, 0) || jump_is_shorthop)
						{
						speed_set(0, -shorthop_speed, true, false);
						jump_is_shorthop = false;
						}
					//Full jumps
					else
						{
						speed_set(0, -jump_speed, true, false);
						}
			
					//Change horizontal speed
					if (stick_tilted(Lstick, DIR.horizontal) && !jumpsquat_allow_turnaround)
						{
						if (jumpsquat_change_momentum && stick_tilted(Lstick, DIR.horizontal))
							{
							hsp = abs(hsp) * sign(stick_get_value(Lstick, DIR.horizontal));
							}
						hsp = clamp(hsp + (sign(stick_get_value(Lstick, DIR.horizontal)) * jump_horizontal_accel), -max_air_speed, max_air_speed);
						}
		
					run = false;
					}
				}
	
			move();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */