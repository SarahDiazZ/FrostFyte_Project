///@category Player Standard States
/*
This script contains the default Wavelanding state characters are given.

The Wavelanding state is for players who airdodged into the ground, and is only possible when the <airdodge_type> is set to AIRDODGE_TYPE.momentum_stop.
Players can perform most grounded actions from the wavelanding state.
*/
function standard_wavelanding() {
	//Contains the standard actions for the waveland state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Waveland"]);
			
			//Sound
			game_sound_play(snd_waveland);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Sliding Friction and gravity
			friction_gravity(waveland_friction, grav, max_fall_speed);
	
			//Waveland to Aerial
			if (run && check_aerial()) run = false;
	
			//Waveland to Grounded States
			if (run && state_frame == 0)
				{
				//Dash
				if (check_dash())
					{
					run = false;
					}
				//Walking
				else if (check_walk())
					{
					run = false;
					}
				//Idle
				else
					{
					state_set(PLAYER_STATE.idle);
					run = false;
					}
				}
	
			//Actions
			if (run && state_time >= waveland_time_min)
				{
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
				}
	
			move_hit_platforms();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */