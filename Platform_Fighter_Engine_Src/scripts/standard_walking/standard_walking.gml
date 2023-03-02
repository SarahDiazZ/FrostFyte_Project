///@category Player Standard States
/*
This script contains the default Walking state characters are given.

The Walking state is for players who are walking on the ground.
Players can perform most grounded actions out of this state.
*/
function standard_walking() {
	//Contains the standard actions for the walking state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Walk"]);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Change facing direction
			change_facing();
				
			//Acceleration
			hsp += walk_accel * sign(stick_get_value(Lstick, DIR.horizontal));
			//Maximums
			hsp = clamp(hsp, -walk_speed, walk_speed);

			//Change to Aerial State
			if (run && check_aerial()) run = false;

			//Jumping
			if (run && check_jump()) run = false;

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

			//Rolling
			if (run && check_rolling()) run = false;

			//Shielding
			if (run && check_shield()) run = false;

			//Dashing
			//If the control stick is past a threshold
			if (run)
				{
				if (stick_flicked(Lstick,DIR.horizontal))
					{
					//Set the state to dashing and stop the script.
					state_set(PLAYER_STATE.dashing);
					//VFX
					var _vfx = vfx_create(spr_dust_dash, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					//Reset variables
					state_frame = 0;
					state_frame = dash_time;
					run = false;
					}
				}
				
			//Drop Throughs
			if (run && check_drop_through()) run = false;

			//Crouching
			if (run && check_crouch()) run = false;

			//Walk Turnaround
			if (run && 
				sign(stick_get_value(Lstick, DIR.horizontal)) != sign(hsp) &&
				sign(hsp) != 0 && 
				stick_tilted(Lstick, DIR.horizontal))
				{
				state_set(PLAYER_STATE.walk_turnaround);
				state_facing = sign(stick_get_value(Lstick, DIR.horizontal));
				state_frame = walk_turn_time;
				run = false;
				}

			//Idle
			//If the control stick is within the threshold
			if (run && !stick_tilted(Lstick, DIR.horizontal))
				{
				state_set(PLAYER_STATE.idle);
				run = false;
				}

			jostle_players();
			move();
			break;
			}
		}
}

/* Copyright 2023 Springroll Games / Yosi */