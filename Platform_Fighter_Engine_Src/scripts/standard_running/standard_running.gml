///@category Player Standard States
/*
This script contains the default Running state characters are given.

The Running state comes after the initial Dashing state when a player flicks the control stick horizontally on the ground.
*/
function standard_running() {
	//Contains the standard actions for the running state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Run"]);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Accelerate in one direction
			if (sign(stick_get_value(Lstick, DIR.horizontal)) == facing && stick_tilted(Lstick, DIR.horizontal))
				{
				hsp += run_accel * sign(stick_get_value(Lstick,DIR.horizontal));
				}
			//Maximums
			hsp = clamp(hsp, -run_speed, run_speed);
	
			//Change to Aerial State
			if (run && check_aerial()) then run = false;
	
			//Jumping
			if (run && check_jump()) 
				{
				jump_is_dash_jump = true;
				run = false;
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
			if (run && allow_dash_attacks()) then run = false;
			if (run && allow_ground_attacks()) then run = false;
			if (run && allow_dash_grabs()) then run = false;
	
			//Rolling
			if (run && check_rolling()) then run = false;
	
			//Drop Throughs
			if (run && check_drop_through())
				{
				jump_is_dash_jump = true;
				run = false;
				}
	
			//Crouching
			if (run && check_crouch()) then run = false;
	
			//Shielding
			if (run && check_shield()) then run = false;
	
			//Run Turnaround
			if (run && 
				sign(stick_get_value(Lstick, DIR.horizontal)) != facing &&
				sign(hsp) != 0 && 
				stick_tilted(Lstick, DIR.horizontal))
				{
				state_set(PLAYER_STATE.run_turnaround);
				state_facing = sign(stick_get_value(Lstick, DIR.horizontal));
				state_frame = run_turn_time;
				//VFX
				var _vfx = vfx_create(spr_dust_dash, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
				_vfx.vfx_xscale = 2 * -facing;
				run = false;
				}
	
			//Stopping
			if (run && check_run_stop()) then run = false;
	
			jostle_players();
			move();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */