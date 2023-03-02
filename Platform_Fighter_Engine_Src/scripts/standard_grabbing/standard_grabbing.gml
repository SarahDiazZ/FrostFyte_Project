///@category Player Standard States
/*
This script contains the default Grabbing state characters are given.

The Grabbing state is for players who are currently grabbing another player.
The player being grabbed uses the "is_grabbed" state.
*/
function standard_grabbing() {
	//Contains the standard actions for the grabbing state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Grabbing"]);
			//Stick reset - the player must reset stick to neutral before a throw
			throw_stick_has_reset = false;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Friction & Gravity
			friction_gravity(ground_friction, grav, max_fall_speed);
	
			//Change to Aerial State
			if (run && check_aerial()) then run = false;
	
			//Attacking
			if (run && (grabbed_id.state == PLAYER_STATE.is_grabbed || grabbed_id.state == PLAYER_STATE.hitlag))
				{
				//Throw stick reset
				if (!stick_tilted(Lstick))
					{
					throw_stick_has_reset = true;
					}

				//Throw
				if (run)
					{
					//You can throw opponents if the stick has been reset or if the grab is ending
					if (throw_stick_has_reset)
						{
						if (allow_throws()) then run = false;
						}
					else if (state_frame <= 0)
						{
						if (allow_throws()) then run = false;
						}
					}
		
				//Pummel
				if (run && state_frame > 0)
					{
					var _grab_frame = state_frame;
					if (allow_pummels())
						{
						state_frame = _grab_frame;
						run = false;
						}
					}
		
				}
	
			//Grab Interrupt
			//If the grabbed player is no longer being grabbed, the grab releases
			if (run && ((grabbed_id.state != PLAYER_STATE.is_grabbed && 
				grabbed_id.state != PLAYER_STATE.hitlag) ||
				grabbed_id.grab_hold_id != id))
				{
				grab_release();
				run = false;
				}
	
			//Grab Release
			//Grabs end automatically when the grab frame times out without a throw
			if (run && state_frame == 0)
				{
				grab_release();
				run = false;
				}
	
			//Grab Snap
			if (run)
				{
				grab_snap_move();
				}
	
			move_grounded();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */