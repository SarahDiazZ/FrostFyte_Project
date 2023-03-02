///The passive script for adding command inputs
function uspec_shoryuken_input_passive() {
	//Allow command inputs to be used in the following states, including the starting frames of any attack
	if ((state == PLAYER_STATE.attacking && state_time < 5) ||
		state == PLAYER_STATE.crouching ||
		state == PLAYER_STATE.dashing ||
		state == PLAYER_STATE.idle ||
		state == PLAYER_STATE.jumpsquat ||
		state == PLAYER_STATE.run_stop ||
		state == PLAYER_STATE.run_turnaround ||
		state == PLAYER_STATE.running ||
		state == PLAYER_STATE.walk_turnaround ||
		state == PLAYER_STATE.walking ||
		state == PLAYER_STATE.wavelanding)
		{
		//Make sure you aren't grabbing anyone
		if (grabbed_id == noone || 
			grabbed_id.grab_hold_id != id || 
			(grabbed_id.state != PLAYER_STATE.is_grabbed && 
			grabbed_id.state != PLAYER_STATE.hitlag))
			{
			//Shoryuken
			if (attack_script != uspec_shoryuken)
				{
				if (input_pressed(INPUT.special, buffer_time_standard, false))
					{
					//You can do the input in either direction, and it will turn you around
					if (input_motion([6, [1, 2], [3, 6]], Lstick))
						{
						input_reset(INPUT.special);
						attack_start(uspec_shoryuken);
						speed_set(0, 0, false, false);
						custom_attack_struct.uspec_shoryuken_input = true;
						}
					else if (input_motion([4, [2, 3], [1, 4]], Lstick))
						{
						facing *= -1;
						input_reset(INPUT.special);
						attack_start(uspec_shoryuken);
						speed_set(0, 0, false, false);
						custom_attack_struct.uspec_shoryuken_input = true;
						}
					}
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */