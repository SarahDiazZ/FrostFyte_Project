///@category Player Standard States
/*
This script contains the default Ledge Getup state characters are given.

The Ledge Getup state is for players who climbing up from the ledge normally.
*/
function standard_ledge_getup() {
	//Contains the standard actions for the ledge getup state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "LedgeG"]);
			//Invincible
			invulnerability_set(INV.invincible, 1);
			//Timer
			state_frame = ledge_getup_time;
			//Held item
			item_visible = false;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Invincible
			invulnerability_set(INV.invincible, 1);

			//No speed
			speed_set(0, 0, false, false);

			//End Getup
			if (state_frame == 0)
				{
				ledge_getup_move();
				state_set(PLAYER_STATE.idle);
				}
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */