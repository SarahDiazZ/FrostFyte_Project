///@category Player Standard States
/*
This script contains the default Run Turnaround state characters are given.

The Run Turnaround state is for players who were running and then tilted the control stick in the opposite direction.
Please note: This state is not used who turn around during a dash.
*/
function standard_run_turnaround() {
	//Contains the standard actions for the run turnaround state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Run_Turn"]);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Facing
			facing = state_facing;
	
			//Walking
			//Acceleration
			hsp += run_turn_accel * state_facing;
			//Maximums
			hsp = clamp(hsp, -run_speed, run_speed);
	
			//Transition back to dashing
			if (state_frame == 0)
				{
				//Make sure you're going in the right direction
				if (sign(hsp) != sign(state_facing))
					{
					speed_set(0, 0, false, false);
					}
				//Set to dashing if you are tilting the stick in the right direction
				if (stick_tilted(Lstick, DIR.horizontal) &&
					sign(stick_get_value(Lstick, DIR.horizontal)) == sign(state_facing))
					{
					state_set(PLAYER_STATE.dashing);
					}
				else
					{
					state_set(PLAYER_STATE.idle);
					}
				run = false;
				}
	
			//Change to Aerial State
			if (run && check_aerial()) then run = false;
	
			//Jumping (RAR)
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
	
			//Drop Throughs
			if (run && check_drop_through())
				{
				jump_is_dash_jump = true;
				run = false;
				}
	
			//Crouching
			if (run && check_crouch()) then run = false;
	
			//Rolling
			if (run && check_rolling()) then run = false;
	
			jostle_players();
			move_grounded();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */