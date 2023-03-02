///@category Player Standard States
/*
This script contains the default Crouching state characters are given.

The Crouching state is for players who are crouching, and allows them to perform most grounded actions.
*/
function standard_crouching() {
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Crouch"]);
			
			//Hurtbox
			hurtbox_anim_set(hurtbox_crouch_sprite, round(anim_frame), facing, 1, 0);
			
			//Crouch canceling
			invulnerability_set(INV.heavyarmor, 1);
			heavyarmor_amount = crouch_cancel_armor;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Contains the standard actions for the crouching state.
			var run = true;
	
			//Hurtbox
			hurtbox_anim_set(hurtbox_crouch_sprite, round(anim_frame), facing, 1, 0);
			
			//Crouch canceling
			invulnerability_set(INV.heavyarmor, 1);
			heavyarmor_amount = crouch_cancel_armor;

			//Friction / Gravity
			friction_gravity(crouch_friction, grav, max_fall_speed);

			//Change to Aerial State
			if (run && check_aerial()) then run = false;

			//Cancel into normal grounded states
			//If the control stick is not down
			if (run && !stick_tilted(Lstick, DIR.down))
				{
				//Dashing
				if (run && check_dash()) then run = false;
	
				//Walking
				if (run && check_walk()) then run = false;
	
				//Idle
				if (run)
					{
					//Change the state to idle and exit the script.
					state_set(PLAYER_STATE.idle);
					run = false;
					}
				}

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
			if (run && check_drop_through()) then run = false;

			//Rolling
			if (run && check_rolling()) then run = false;

			//Shielding
			if (run && check_shield()) then run = false;

			move();
			break;
			}
		case PLAYER_STATE_PHASE.stop:
			{
			//Reset invulnerability
			invulnerability_set(INV.normal, -1);
			heavyarmor_amount = 0;
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */