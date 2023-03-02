///@category Player Standard States
/*
This script contains the default Tumble state characters are given.

The Tumble state happens after a player's hitstun ends if "is_reeling" is true.
When in tumble, players can only drift a small amount. Tumble can be canceled with a jump, attack, ledge grab, or airdodge.
*/
function standard_tumble() {
	//Contains the standard actions for the tumble state.
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : PLAYER_STATE_PHASE.normal;
	switch(_phase)
		{
		case PLAYER_STATE_PHASE.start:
			{
			//Animation
			anim_set(my_sprites[$ "Tumble"]);
			//Landing
			landed_on_ground = false;
			break;
			}
		case PLAYER_STATE_PHASE.normal:
			{
			//Friction / Gravity
			friction_gravity(air_friction, grav, max_fall_speed);

			//Landing
			if (run && on_ground() && vsp == 0)
				{
				//Knockdown
				if (is_reeling)
					{
					if (knockdown_type == KNOCKDOWN_TYPE.slide)
						{
						check_landing();
						}
					else if (knockdown_type == KNOCKDOWN_TYPE.normal)
						{
						state_set(PLAYER_STATE.knockdown);
						//VFX
						var _vfx = vfx_create_color(spr_dust_impact, 1, 0, 22, x, (bbox_bottom - 1) + 1, 0.75, 90, "VFX_Layer_Below");
						_vfx.vfx_yscale = prng_choose(0, -0.75, 0.75);
						}
					}
				else
					{
					check_landing();
					}
				//Effects
				camera_shake(1, 3);
				run = false;
				}

			//Ledge
			if (run && check_ledge_grab_falling()) then run = false;

			//Drift DI
			//If stick is past threshold
			if (stick_tilted(Lstick, DIR.horizontal))
				{
				//Drift DI cannot be used to speed up knockback to high speeds
				if (sign(stick_get_value(Lstick, DIR.horizontal)) == sign(hsp))
					{
					if (abs(hsp + drift_di_accel * sign(stick_get_value(Lstick, DIR.horizontal))) < drift_di_max * drift_di_multiplier)
						{
						hsp += drift_di_accel * sign(stick_get_value(Lstick, DIR.horizontal));
						}
					}
				else
					{
					hsp += drift_di_accel * sign(stick_get_value(Lstick, DIR.horizontal));
					}
				}

			//Airdodge Cancel
			if (run && check_airdodge()) then run = false;

			//Jump Cancel (not a normal double jump)
			if (run && input_pressed(INPUT.jump))
				{
				if (double_jumps > 0)
					{
					state_set(PLAYER_STATE.aerial);
					speed_set(0, -double_jump_speed, true, false);
					double_jumps--;
					jump_is_midair_jump = true;
					/*No horizontal speed change*/
					//VFX
					vfx_create(spr_dust_air_jump, 1, 0, 7, x, y, 2, 0);
					run = false;
					}
				}

			//Attack Cancel
			if (run && allow_smash_attacks()) then run = false;
			if (run && allow_special_attacks()) then run = false;
			if (run && allow_aerial_attacks()) then run = false;

			move_hit_platforms();
			break;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */