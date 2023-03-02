///@category Player Standard States
/*
This script contains the default Ledge Attack state characters are given.

The Ledge Attack state is for players who are starting a ledge attack. The actual attack uses the Attacking state.
*/
function standard_ledge_attack() {
	//Contains the standard actions for the ledge attack state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "LedgeA"]);
			//Invincible
			invulnerability_set(INV.invincible, 1);
			//Timer
			state_frame = ledge_attack_time;
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
				attack_start(my_attacks[$ "LedgeAtk"]);
				}
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */