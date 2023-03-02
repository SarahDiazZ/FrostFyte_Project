///@category Player Actions
///@param {real} [knockback_dir]		The direction the player will be launched
///@param {real} [knockback_spd]		The speed at which the player will be launched
///@param {int} [stored_hitstun]		How much hitstun the player will have
///@param {int} [stored_state]			The state players will be in when launched
/*
Launches the calling player based on their instance variables related to knockback.
You can optionally pass arguments to this function that will be used instead of the instance variables.
By default, this function is called at the end of hitlag from <standard_hitlag>.
*/
function launch_player() {
	var _knockback_dir = argument_count > 0 ? argument[0] : knockback_dir;
	var _knockback_spd = argument_count > 1 ? argument[1] : knockback_spd
	var _stored_hitstun = argument_count > 2 ? argument[2] : stored_hitstun;
	var _stored_state = argument_count > 3 ? argument[3] : stored_state;
	
	//Transition to stored state
	var _reset_grab_hold_id = true;
	state_set(_stored_state);
	switch(_stored_state)
		{
		case PLAYER_STATE.hitstun:
		case PLAYER_STATE.balloon:
			//Set the hitstun timer
			state_frame = _stored_hitstun;
			
			//Reset teching
			if (!tech_buffer_before_hitstun)
				{
				tech_buffer = tech_lockout_time;
				}
			
			//ASDI - Moves the player a few pixels based on input after hitlag
			if (stick_tilted(Lstick, DIR.horizontal))
				{
				var _move_x = ceil(lengthdir_x(asdi_default * asdi_multiplier, stick_get_direction(Lstick)));
				if (!collision(x + _move_x, y, [FLAG.solid]))
					{
					x += _move_x;
					}
				}
			if (stick_tilted(Lstick, DIR.vertical))
				{
				var _move_y = ceil(lengthdir_y(asdi_default * asdi_multiplier, stick_get_direction(Lstick)));
				if (!collision(x, y + _move_y, [FLAG.solid]))
					{
					y += _move_y;
					}
				}
				
			//DI - Player trajectory is altered slightly based on input after hitlag
			var _final_direction;
			_final_direction = calculate_di_direction(_knockback_dir, stick_get_direction(Lstick), di_angle);
			
			//Final Knockback
			speed_set(lengthdir_x(_knockback_spd, _final_direction), lengthdir_y(_knockback_spd, _final_direction), false, false);
			break;
		case PLAYER_STATE.flinch:
			//Set the timer for flinching
			state_frame = _stored_hitstun;
						
			//ASDI - You can only move horizontally when flinching!
			if (stick_tilted(Lstick, DIR.horizontal))
				{
				var _move_x = ceil(lengthdir_x(asdi_default * asdi_multiplier, stick_get_direction(Lstick)));
				if (!collision(x + _move_x, y, [FLAG.solid]))
					{
					x += _move_x;
					}
				}
			break;
		case PLAYER_STATE.is_grabbed:
			_reset_grab_hold_id = false;
			//Prevent the player from grab breaking after a pummel
			if (grab_break_enable)
				{
				state_phase = 1;
				}
			break;
		}
				
	//Reset grab variables
	if (_reset_grab_hold_id)
		{
		grab_hold_id = noone;
		}
}

/* Copyright 2023 Springroll Games / Yosi */