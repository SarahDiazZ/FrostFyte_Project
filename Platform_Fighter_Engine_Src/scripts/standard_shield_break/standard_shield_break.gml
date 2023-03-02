///@category Player Standard States
/*
This script contains the default Shield Break state characters are given.

The Shield Break state is for players who got their shield HP reduced to zero, either by an opponent's attack or by holding shield for too long.
Please note: You cannot mash out of shield break!
*/
function standard_shield_break() {
	//Contains the standard actions for the shield break state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Tumble"]);
			//Invulnerable
			invulnerability_set(INV.invincible, 1);
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Speeds
			speed_set(0, 0, false, true);
			friction_gravity(0, grav, max_fall_speed);

			//Animation and invulnerability
			if (on_ground())
				{
				//VFX
				if (vsp > 0)
					{
					vfx_create(spr_dust_land, 1, 0, 26, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					}
					
				speed_set(0, 0, false, false);
				invulnerability_set(INV.normal, 0);
				anim_loop_continue(my_sprites[$ "ShieldB"]);
				}
			else
				{
				invulnerability_set(INV.invincible, 1);
				}

			//When the lag is done
			if (run && state_frame == 0)
				{
				//Return to idle state
				state_set(PLAYER_STATE.idle);
				run = false;
				}

			move_hit_platforms();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */