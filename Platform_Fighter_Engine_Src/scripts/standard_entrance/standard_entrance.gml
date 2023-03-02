///@category Player Standard States
/*
This script contains the default Entrance state characters are given.

The Entrance state is the state players start in until <obj_game> finishes counting down at the beginning of a match.
*/
function standard_entrance() {
	//Contains the standard actions for the entrance state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Entrance"]);
			//No speed
			speed_set(0, 0, false, false);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Players do an entrance animation until obj_game starts the match.
			speed_set(0, 0, false, false);
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */