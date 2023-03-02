///@category Player Standard States
/*
This script contains the default Ledge Jump state characters are given.

The Ledge Jump state is for players who are starting to jump from the ledge. The actual jump happens during the Aerial state.
*/
function standard_ledge_jump() {
	//Contains the standard actions for the ledge jump state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "LedgeJ"]);
			//Invincible
			invulnerability_set(INV.invincible, 1);
			//Timer
			state_frame = ledge_jump_time;
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
				
				//Wavedash cancel
				if (check_airdodge())
					{
					return;
					}
				
				//Move off the ground
				move_y(false, -1, true);
				
				speed_set(ledge_jump_hsp * facing, -ledge_jump_vsp, false, false);
				state_set(PLAYER_STATE.aerial);
				}
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */