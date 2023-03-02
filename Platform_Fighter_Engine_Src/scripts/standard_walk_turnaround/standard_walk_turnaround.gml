///@category Player Standard States
/*
This script contains the default Walk Turnaround state characters are given.

The Walk Turnaround state is for players who turned around when walking.
Players can perform most grounded actions out of this state.
*/
function standard_walk_turnaround() {
	//Contains the standard actions for the walk turnaround state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Walk_Turn"]);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Facing
			facing = state_facing;
	
			//Walking
			hsp += walk_accel * state_facing;
			//Maximums
			hsp = clamp(hsp, -walk_speed, walk_speed);
	
			//Transition back to walking
			if (state_frame == 0)
				{
				state_set(PLAYER_STATE.walking);
				run = false;
				}
	
			//Transition to run turnaround
			if (run && stick_flicked(Lstick))
				{
				state_set(PLAYER_STATE.run_turnaround);
				state_frame = max(run_turn_time - state_frame, 0);
				state_facing = facing;
				run = false;
				}
	
			//Change to Aerial State
			if (run && check_aerial()) then run = false;
	
			//Jumping (RAR)
			if (run && check_jump()) then run = false;
	
			//Items
			if (item_system_type == ITEM_SYSTEM_TYPE.standard ||
				item_system_type == ITEM_SYSTEM_TYPE.simplified)
				{
				if (run && allow_item_throws()) then run = false;
				}
	
			//Attacking
			if (run && allow_smash_attacks()) then run = false;
			if (run && allow_special_attacks()) then run = false;
			if (run && allow_ground_attacks()) then run = false;
			if (run && allow_grabs()) then run = false;
	
			//Drop Throughs
			if (run && check_drop_through()) then run = false;
	
			//Rolling
			if (run && check_rolling()) then run = false;
	
			//Shielding
			if (run && check_shield()) run = false;
	
			jostle_players();
			move_grounded();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */