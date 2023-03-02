///@category Player Standard States
/*
This script contains the default Ledge Hang state characters are given.

The Ledge Hang state is for players who are hanging on a ledge doing nothing.
*/
function standard_ledge_hang() {
	//Contains the standard actions for the ledge hang state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Ledge"]);
			
			//No speeds
			speed_set(0, 0, false, false);
			
			//Invincible
			if (ledge_grab_counter < ledge_grab_invincible_limit)
				{
				invulnerability_set(INV.invincible, ledge_invincible_time);
				}
				
			//Ledge counter
			ledge_grab_counter++;
			
			//Held item
			item_visible = false;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Renew resources
			double_jumps = max_double_jumps;
			airdodges = airdodges_max;
	
			//No speed
			speed_set(0, 0, false, false);
	
			//Ledge Options
			if (state_time >= ledge_hang_time_min)
				{
				//Ledge Drift Away
				if (run &&
					(sign(stick_get_value(Lstick, DIR.horizontal)) != facing &&
					stick_tilted(Lstick, DIR.horizontal)))
					{
					run = false;
					state_set(PLAYER_STATE.aerial);
					invulnerability_set(INV.normal, 0);
					//Cannot instantly regrab the ledge
					ledge_grab_timeout = ledge_grab_timeout_standard;
					ledge_id = noone;
					}
		
				//Ledge Fall
				if (run && stick_tilted(Lstick, DIR.down))
					{
					run = false;
					state_set(PLAYER_STATE.aerial);
					invulnerability_set(INV.normal, 0);
					//Cannot instantly regrab the ledge
					ledge_grab_timeout = ledge_grab_timeout_standard;
					ledge_id = noone;
					}
		
				//Ledge Jump
				if (run && (input_pressed(INPUT.jump) || stick_tilted(Lstick, DIR.up)))
					{
					run = false;
					state_set(PLAYER_STATE.ledge_jump);
					//Cannot instantly regrab the ledge
					ledge_grab_timeout = ledge_grab_timeout_standard;
					ledge_id = noone;
					}
		
				//Ledge Roll
				if (run && input_pressed(INPUT.shield))
					{
					run = false;
					state_set(PLAYER_STATE.ledge_roll);
					//Cannot instantly regrab the ledge
					ledge_grab_timeout = ledge_grab_timeout_standard;
					ledge_id = noone;
					}
		
				//Ledge Getup
				if (run && 
					(sign(stick_get_value(Lstick, DIR.horizontal)) == facing &&
					stick_tilted(Lstick, DIR.horizontal)))
					{
					run = false;
					state_set(PLAYER_STATE.ledge_getup);
					//Cannot instantly regrab the ledge
					ledge_grab_timeout = ledge_grab_timeout_standard;
					ledge_id = noone;
					}
		
				//Ledge Attack
				if (run && (input_pressed(INPUT.attack)))
					{
					run = false;
					state_set(PLAYER_STATE.ledge_attack);
					//Cannot instantly regrab the ledge
					ledge_grab_timeout = ledge_grab_timeout_standard;
					ledge_id = noone;
					}
		
				}
			if (state_time >= ledge_hang_time_max)
				{
				//Ledge Fall
				if (run)
					{
					run = false;
					speed_set(0, 1, false, false);
					state_set(PLAYER_STATE.aerial);
					invulnerability_set(INV.normal, 0);
					//Cannot instantly regrab the ledge
					ledge_grab_timeout = ledge_grab_timeout_standard;
					ledge_id = noone;
					}
				}
	
			move();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */