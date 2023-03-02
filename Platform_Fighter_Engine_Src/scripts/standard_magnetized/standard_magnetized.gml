///@category Player Standard States
/*
This script contains the default Magnetized state characters are given.

The Magnetized state is for players who have been hit by a magnetbox.
*/
function standard_magnetized() {
	//Contains the standard actions for the magnetized state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Magnet"]);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//End Phase
			if (state_frame == 0)
				{
				state_set(PLAYER_STATE.aerial);
				run = false;
				}
		
			//Move toward magnet goal
			if (run)
				{
				speed_set_towards_point(magnet_goal_x, magnet_goal_y, magnet_snap_speed);
				}
		
			move_through_platforms();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */