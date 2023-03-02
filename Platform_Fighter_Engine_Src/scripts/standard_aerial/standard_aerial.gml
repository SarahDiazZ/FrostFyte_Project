///@category Player Standard States
/*
This script contains the default Aerial state characters are given.

The Aerial state is for players in the air, whether by jumping or falling, and allows them to perform actions such as Aerial attacks, double jumping, and airdodging.
*/
function standard_aerial() {
	//Contains the standard actions for the aerial state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Restrict speed
			if (aerial_restrict_speed_instantly)
				{
				var _max_speed = jump_is_dash_jump ? max_air_speed_dash : max_air_speed;
				hsp = clamp(hsp, -_max_speed, _max_speed);
				}
				
			//Jumping variables
			jump_is_midair_jump = false;
			jump_is_dash_jump = false;
			jump_is_shorthop = false;
			landed_on_ground = false;
			
			//Peak of jump
			if (abs(vsp) < 1)
				{
				anim_set(my_sprites[$ "JumpMid"]);
				}
			//Falling
			else if (vsp >= 1)
				{
				anim_set(my_sprites[$ "JumpFall"]);
				}
			//Rising
			else if (vsp <= 1)
				{
				anim_set(my_sprites[$ "JumpRise"]);
				}
			//Fastfalling
			if (vsp >= floor(fastfall_speed))
				{
				anim_set(my_sprites[$ "Fastfall"]);
				}
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			if (!jump_is_midair_jump)
				{
				//Peak of jump
				if (abs(vsp) < 1)
					{
					anim_loop_continue(my_sprites[$ "JumpMid"]);
					}
				//Falling
				else if (vsp >= 1)
					{
					anim_loop_continue(my_sprites[$ "JumpFall"]);
					}
				//Rising
				else if (vsp <= 1)
					{
					anim_loop_continue(my_sprites[$ "JumpRise"]);
					}
				//Fastfalling
				if (vsp >= floor(fastfall_speed))
					{
					anim_loop_continue(my_sprites[$ "Fastfall"]);
					}
				}
			else
				{
				//Peak of jump
				if (abs(vsp) < 1)
					{
					anim_loop_continue(my_sprites[$ "DJumpMid"]);
					}
				//Falling
				else if (vsp >= 1)
					{
					anim_loop_continue(my_sprites[$ "DJumpFall"]);
					}
				//Rising
				else if (vsp <= 1)
					{
					anim_loop_continue(my_sprites[$ "DJumpRise"]);
					}
				//Fastfalling
				if (vsp >= floor(fastfall_speed))
					{
					anim_loop_continue(my_sprites[$ "DFastfall"]);
					}
				}
	
			//Friction and Gravity
			//No air friction if you are tilting the stick
			var _friction = air_friction;
			if (stick_tilted(Lstick, DIR.horizontal) && !aerial_state_use_momentum_drift)
				{
				_friction = 0;
				}
			friction_gravity(_friction, grav, max_fall_speed);
	
			//Horizontal Movement
			if (run) 
				{
				if (aerial_state_use_momentum_drift)
					{
					aerial_drift_momentum();
					}
				else
					{
					aerial_drift();
					}
				}
	
			//Landing
			if (run && check_landing()) then run = false;
	
			//Ledge
			if (run && check_ledge_grab()) then run = false;
	
			//Airdodging
			if (run && check_airdodge()) then run = false;
			
			//Footstooling
			if (run && check_footstool()) then run = false;
			
			//Wall Clinging / Jumping
			if (run && check_wall_cling()) then run = false;
			if (run && check_wall_jump()) then run = false;
	
			//Double Jumping
			//If you have enough jumps
			if (run && double_jumps > 0)
				{
				//If jump is being pressed
				if (input_pressed(INPUT.jump))
					{
					double_jump();
					run = false;
					}
				}
	
			//Items
			if (item_system_type == ITEM_SYSTEM_TYPE.standard ||
				item_system_type == ITEM_SYSTEM_TYPE.simplified)
				{
				if (run && allow_item_throws()) then run = false;
				}
	
			//Attacking
			if (run && allow_smash_attacks()) then run = false;
			if (run && allow_special_attacks()) then run = false;
			if (run && allow_aerial_attacks()) then run = false;
	
			//Fastfalling
			if (run) fastfall_try();
	
			move();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */