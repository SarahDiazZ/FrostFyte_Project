///@category Player Standard States
/*
This script contains the default Hitlag state characters are given.

The Hitlag state is used to create a small pause when players are hit.
Please note: Hitlag is used for the player being hit by an attack. The attacking player does not change state and instead uses their "self_hitlag_frame".
*/
function standard_hitlag() {
	//Contains the standard actions for the hitlag state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Don't set the animation for 1 frame, so players can see how they got hit.
			if (!hitlag_delay_animation)
				{
				anim_set(my_sprites[$ "Hitlag"]);
				}
			//Reeling
			is_reeling = false;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Animation
			if (hitlag_delay_animation)
				{
				anim_loop_continue(my_sprites[$ "Hitlag"]);
				//Turn around based on the knockback
				if (hit_turnaround)
					{
					var _diff = abs(angle_difference(knockback_dir, 0));
					if (_diff != 0)
						{
						facing = _diff < 90 ? -1 : 1;
						}
					}
				}
			
			//Restore Airdodge
			if (airdodge_restore_in_hitlag)
				{
				airdodges = airdodges_max;
				}

			//End Hitlag
			if (run && state_frame == 0)
				{
				launch_player();
				run = false;
				}

			//No movement
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */