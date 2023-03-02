///@category Player Standard States
/*
This script contains the default Is Grabbed state characters are given.

The Is Grabbed state is for players who are being grabbed by another player.
Please note: You cannot mash out of grabs!
*/
function standard_is_grabbed() {
	//Contains the standard actions for the is_grabbed state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "IsGrabbed"]);
			//Grab breaking
			state_phase = 0;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Regrab Frame
			grab_regrab_frame = grab_regrab_time;
			
			//Grab struggle / Grab break
			if (run && grab_hold_id != noone && grab_hold_id.grabbed_id == id)
				{
				//Check how long you have been grabbed, if you haven't been pummeled yet
				//<standard_hitlag> sets the state_phase to 1 after a pummel.
				if (state_time <= grab_break_window && state_phase == 0)
					{
					if (grab_break_buffer < grab_break_buffer_time)
						{
						if (grab_break_struggle_enable)
							{
							grab_break_struggle_start();
							}
						else if (grab_break_enable)
							{
							grab_break();
							}
						
						//Reset input buffer
						grab_break_buffer = grab_break_lockout_time;
						run = false;
						}
					}
				
				}
			
			//Release
			//If the opposing player is no longer grabbing or throwing, break out of the grab
			//If there is no grabbing player
			//If the grabbing player is holding a different player
			if (run && (
				grab_hold_id == noone ||
				grab_hold_id.grabbed_id != id ||
				(grab_hold_id != noone && 
				grab_hold_id.state != PLAYER_STATE.grabbing && 
				grab_hold_id.state != PLAYER_STATE.attacking &&
				grab_hold_id.grabbed_id == id)))
				{
				grab_break();
				run = false;
				}
	
			//Unknown Grabber
			if (run && grab_hold_id == noone)
				{
				crash("[standard_is_grabbed] grab_hold_id is set to noone");
				}
	
			//No Movement
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */