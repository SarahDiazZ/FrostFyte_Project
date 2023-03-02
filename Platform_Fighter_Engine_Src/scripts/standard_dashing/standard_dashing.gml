///@category Player Standard States
/*
This script contains the default Dashing state characters are given.

The Dashing state is the initial burst of speed players get before transitioning into the Running state.
Players can "dash dance" in this state by flicking the control stick back and forth before the running state kicks in.
*/
function standard_dashing() {
	//Contains the standard actions for the dashing state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Dash"]);
			
			//Sound
			game_sound_play(snd_dash);
			
			//Timers
			state_frame = dash_time;
			
			//For moonwalking
			state_phase = 0;
			
			//Allow jumping by default
			dash_prevent_jump = false;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Moonwalk Start
			if (moonwalk_enable)
				{
				if (abs(stick_get_value(Lstick, DIR.vertical)) > stick_flick_amount ||
					(stick_tilted(Lstick, DIR.vertical) && !stick_flicked(Lstick, DIR.horizontal, 0) && sign(stick_get_value(Lstick, DIR.horizontal)) != facing))
					{
					state_phase = 1;
					}
				}
					
			//Acceleration
			if (state_phase == 0)
				{
				hsp += dash_accel * facing;
				}
			//Moonwalk acceleration
			else 
				{
				if (stick_tilted(Lstick, DIR.horizontal))
					{
					hsp += dash_accel * 0.5 * sign(stick_get_value(Lstick, DIR.horizontal));
					//Starting a new dash
					if (stick_flicked(Lstick, DIR.horizontal) && sign(stick_get_value(Lstick, DIR.horizontal)) == facing)
						{
						//Reset dash time
						state_frame = dash_time;
						
						//Sound
						game_sound_play(snd_dash);
						
						//VFX
						var _vfx = vfx_create(spr_dust_dash, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
						_vfx.vfx_xscale = 2 * facing;
						}
					}
				else
					{
					hsp = approach(hsp, 0, ground_friction);
					}
				}
				
			//Limits
			hsp = clamp(hsp, -dash_speed, dash_speed);
	
			//Change to Aerial State
			if (run && check_aerial()) then run = false;
	
			//Jumping
			if (run && !dash_prevent_jump && check_jump())
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
	
			//Rolling
			if (run && check_rolling()) then exit;
	
			//Dash Dancing
			//If the control stick is past a threshold in the other direction, and if you're not moonwalking
			var _stick_value = sign(stick_get_value(Lstick, DIR.horizontal));
			if (run && state_phase == 0 && abs(stick_get_value(Lstick, DIR.horizontal)) > stick_flick_amount && _stick_value != 0 && _stick_value != sign(hsp))
				{
				change_facing();
				
				//Reset dash time
				state_frame = dash_time;
				
				//Change momentum
				hsp = -hsp;
				
				//Sound
				game_sound_play(snd_dash);
				
				//VFX
				var _vfx = vfx_create(spr_dust_dash, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
				_vfx.vfx_xscale = 2 * facing;
				}
	
			//Transition to Running / Idle
			if (run)
				{
				//Moonwalking only ends if you hit maximum speed going forwards, go over the moonwalk time, or stop tilting the stick
				if ((state_phase == 0 && state_frame == 0) || (state_phase == 1 && state_frame == 0 && (hsp == dash_speed * facing || state_time > moonwalk_time || !stick_tilted(Lstick, DIR.horizontal))))
					{
					//Running
					if (stick_tilted(Lstick))
						{
						//Change state
						state_set(PLAYER_STATE.running);
						}
					else
						{
						//Stop dashing
						state_set(PLAYER_STATE.idle);
						
						//Try to prevent double dashes (mainly happens on keyboard)
						var _frame = stick_find_frame(Lstick, false, true, DIR.horizontal, undefined, undefined, buffer_time_standard, false);
						if (_frame != -1)
							{
							control_flicked_l = buffer_time_max;
							}
						}
					run = false;
					}
				}
	
			jostle_players();
			move();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */