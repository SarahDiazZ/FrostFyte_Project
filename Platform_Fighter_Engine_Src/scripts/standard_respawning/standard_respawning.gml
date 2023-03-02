///@category Player Standard States
/*
This script contains the default Respawning state characters are given.

The Respawning state is for players who are standing on the respawn platform.
Players can tilt the control stick to leave the platform, or wait until the respawn timer runs out.
After leaving the platform, players will have invincibility equal to the <respawn_inv_time>.
If <respawn_platform_change_facing> is set to true, players can change the direction they are facing when manually leaving the platform.
*/
function standard_respawning() {
	//Contains the standard actions for the respawning state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Idle"]);
			//Invulnerability
			invulnerability_set(INV.invincible, respawn_inv_time);
			//Timer
			state_frame = respawn_platform_time_max;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Invulnerability
			hurtbox_inv_set(hurtbox, INV.invincible, 1, false);
	
			//Respawn time limit
			if (run && state_frame == 0)
				{
				//Aerial State
				state_set(PLAYER_STATE.aerial);
				hurtbox_inv_set(hurtbox, INV.invincible, respawn_inv_time, false);
				run = false;
				}
			
			//Taunting
			if (run && respawn_platform_taunt_enable)
				{
				if (input_pressed(INPUT.taunt, buffer_time_standard, false))
					{
					//Assign the passive script
					callback_add(callback_passive, respawn_taunt_passive, CALLBACK_TYPE.permanent, id, false);
					callback_add(callback_draw_end, respawn_taunt_draw_end, CALLBACK_TYPE.permanent, id, false);
					
					var _time_remaining = state_frame;
					var _started = attack_start(my_attacks[$ "Taunt"]);
					if (_started)
						{
						state_frame = _time_remaining;
						run = false;
						}
					else
						{
						callback_remove(callback_passive, respawn_taunt_passive);
						callback_remove(callback_passive, respawn_taunt_draw_end);
						}
					}
				}
	
			//Manual Cancel
			if (run && stick_tilted(Lstick))
				{
				state_set(PLAYER_STATE.aerial);
				hurtbox_inv_set(hurtbox, INV.invincible, respawn_inv_time, false);
	
				if (respawn_platform_change_facing)
					{
					if (sign(stick_get_value(Lstick, DIR.horizontal)) != 0)
						{
						facing = sign(stick_get_value(Lstick, DIR.horizontal));
						}
					}
	
				run = false;
				}
	
			//No movement
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */