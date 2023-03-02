///@category Player Standard States
/*
This script contains the default Run Stop state characters are given.

The Run Stop state is for players who were running and then moved the control stick back to neutral.
Please note: This state is not used for players who stop dashing.
*/
function standard_run_stop() {
	//Contains the standard actions for the run stop state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Run_Stop"]);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Friction
			friction_gravity(ground_friction, grav, max_fall_speed);
	
			//Change to Aerial State
			if (run && check_aerial()) then run = false;
	
			//Jumping
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
			if (run && check_drop_through())
				{
				jump_is_dash_jump = true;
				run = false;
				}
	
			//Crouching
			if (run && check_crouch()) then run = false;
	
			//Rolling
			if (run && check_rolling()) then run = false;
	
			//Run Turnaround
			if (run && sign(stick_get_value(Lstick, DIR.horizontal)) != sign(hsp) && sign(hsp) != 0 && stick_tilted(Lstick, DIR.horizontal))
				{
				state_set(PLAYER_STATE.run_turnaround);
				state_facing = sign(stick_get_value(Lstick, DIR.horizontal));
				state_frame = run_turn_time;
				//VFX
				var _vfx = vfx_create(spr_dust_dash, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
				_vfx.vfx_xscale = 2 * -facing;
				run = false;
				}
	
			//Return to Idle State
			if (run && state_frame == 0)
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