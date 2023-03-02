///@category Player Standard States
/*
This script contains the default Idle state characters are given.

The Idle state is for players standing on the ground doing nothing, and is the "default" state that all other states eventually lead back to.
Players can perform any grounded actions from the idle state.
*/
function standard_idle() {
	//Contains the standard actions for the idle state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Idle"]);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Friction & Gravity
			friction_gravity(ground_friction, grav, max_fall_speed);
	
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
			if (run && check_dash()) run = false;
			
			//Drop Throughs
			if (run && check_drop_through()) run = false;
			
			//Crouching
			if (run && check_crouch()) run = false;
	
			//Walking
			if (run && check_walk()) run = false;
	
			jostle_players();
			move();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */