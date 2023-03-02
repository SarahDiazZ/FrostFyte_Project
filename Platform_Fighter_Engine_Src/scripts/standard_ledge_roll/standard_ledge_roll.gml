///@category Player Standard States
/*
This script contains the default Ledge Roll state characters are given.

The Ledge Roll state is for players who are starting to roll from the ledge. The actual roll happens in the Rolling state.
*/
function standard_ledge_roll() {
	//Contains the standard actions for the ledge roll state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "LedgeR"]);
			//Invincible
			invulnerability_set(INV.invincible, ledge_roll_time);
			//Timer
			state_frame = ledge_roll_time;
			//Held item
			item_visible = false;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//No speed
			speed_set(0, 0, false, false);

			//End Getup
			if (state_frame == 0)
				{
				ledge_getup_move();
				state_set(PLAYER_STATE.tech_rolling);
				//Set the rolling direction to match the ledge facing direction
				state_facing = facing;
				}
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */