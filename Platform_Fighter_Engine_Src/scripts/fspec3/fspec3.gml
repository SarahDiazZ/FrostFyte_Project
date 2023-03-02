function fspec3() {
	//Forward Special
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_speed = 0;
				anim_frame = 0;
				
				//Grounded vs Aerial
				if (on_ground())
					{
					anim_sprite = spr_fspec3;
					
					attack_frame = 6;
					speed_set(0, 0, false, false);
					}
				else
					{
					anim_sprite = spr_fspec3_air;
					//Airdash version
					attack_frame = 22;
					attack_phase = 2;
					landing_lag = 10;
					input_reset(INPUT.special);
					}
					
				//EX
				ex_move_reset();
				return;
				}
			//Grounded Startup
			case 0:
				{
				//EX
				ex_move_allow(2);
				
				//Animation
				if (attack_frame == 4)
					anim_frame = 1;
				if (attack_frame == 2)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					//EX version
					if (ex_move_is_activated())
						{
						anim_sprite = spr_fspec3_fully_charged;
						attack_frame = 60;
						attack_phase = 3;
						speed_set(18 * facing, 0, false, false);
						}
					//Normal
					else
						{
						anim_frame = 3;
						attack_frame = 40;
						attack_phase++;
						}
					}
				break;
				}
			//Grounded Active / Endlag
			case 1:
				{
				//Hitbox
				if (attack_frame == 38)
					{
					anim_frame = 4;
					
					speed_set(11 * facing, 0, false, false);
					
					var _hitbox = hitbox_create_melee(36, 30, 0.9, 0.2, 8, 9, 0.4, 13, 75, 17, SHAPE.square, 0);
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.custom_hitstun = 21;
					}
					
				//Animation
				if (attack_frame == 36)
					anim_frame = 5;
				if (attack_frame == 33)
					anim_frame = 6;
				if (attack_frame == 31)
					anim_frame = 7;
				if (attack_frame == 28)
					anim_frame = 8;
				if (attack_frame == 26)
					anim_frame = 9;
				if (attack_frame == 23)
					anim_frame = 10;
				if (attack_frame == 21)
					anim_frame = 11;
				if (attack_frame == 17)
					anim_frame = 12;
				if (attack_frame == 11)
					anim_frame = 13;
				if (attack_frame == 6)
					anim_frame = 14;
					
				//Cancel on hit
				if (attack_connected() && cancel_jump_check())
					{
					speed_set(hsp / 2, 0, false, true);
					return;
					}
				
				//Speeds
				if (attack_frame < 21)
					{
					friction_gravity(0.6);
					}
				
				if (attack_frame == 0)
					{
					attack_stop();
					break;
					}
					
				//Hurtbox
				hurtbox_anim_match(spr_fspec3_hurtbox);
				break;
				}
			//Aerial version (airdash)
			case 2:
				{
				//VFX
				if (attack_frame % 4 == 0)
					{
					vfx_create_color(spr_fspec3_trail, 1, 0, 18, x + prng_number(0, 15, -15), y + prng_number(1, 15, -15), 2, prng_choose(1, 0, 90, 180, 270), "VFX_Layer_Below");
					}
				
				//Animation
				if (attack_frame == 20)
					anim_frame = 1;
				if (attack_frame == 15)
					anim_frame = 2;
				if (attack_frame == 10)
					anim_frame = 3;
				if (attack_frame == 5)
					anim_frame = 4;
					
				//Speed
				if (attack_frame == 20)
					{
					//Speed
					speed_set(15 * facing, 0, false, false);
					//VFX
					var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					}
					
				//Turnaround
				if (attack_frame < 20)
					{
					if (stick_tilted(Lstick, DIR.horizontal) && input_pressed(INPUT.special, buffer_time_standard, true))
						{
						change_facing();
						}
					}
					
				//Grabbing the ledge
				if (check_ledge_grab()) then return;
				
				//Walljumping
				if (check_wall_jump()) then return;
					
				//Cancels
				if (attack_frame <= 20)
					{
					if (allow_aerial_attacks() || allow_smash_attacks() || allow_special_attacks() || cancel_jump_check())
						{
						return;
						}
					}
				
				//Friction / Gravity
				if (attack_frame <= 9)
					{
					aerial_drift();
					friction_gravity(air_friction, 0.3, max_fall_speed);
					
					if (cancel_ground_check())
						{
						run = false;
						break;
						}
					}
					
				if (attack_frame == 0)
					{
					attack_stop();
					run = false;
					}
				break;
				}
			//EX version
			case 3:
				{
				if (attack_frame == 57)
					{
					invulnerability_set(INV.superarmor, 17);
					anim_frame = 1;
					speed_set(18 * facing, 0, false, false);
					
					//Hitbox
					var _hitbox = hitbox_create_melee(6, 6, 1.3, 1.3, 13, 8, 0.8, 18, 39, 17, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_explosion4;
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.explosion, HIT_VFX.lines];
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					
					//VFX
					if (on_ground())
						{
						var _fx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
						_fx.vfx_xscale = 2 * facing;
						}
					var _fx = vfx_create_color(spr_fspec3_shockwave_front, 1, 0, 20, x + (32 * facing), y, 2, 0);
					_fx.vfx_xscale = 2 * facing;
					var _fx = vfx_create_color(spr_fspec3_shockwave_back, 1, 0, 20, x + (32 * facing), y, 2, 0, "VFX_Layer_Below");
					_fx.vfx_xscale = 2 * facing;
					}
					
				//Animation
				if (attack_frame < 57 && attack_frame > 40)
					{
					if (attack_frame % 2 == 0)
						{
						anim_frame++;
						if (anim_frame > 3) then anim_frame = 1;
						}
					}
					
				if (attack_frame == 37)
					anim_frame = 5;
				if (attack_frame == 30)
					anim_frame = 6;
				if (attack_frame == 20)
					anim_frame = 7;
				if (attack_frame == 10)
					anim_frame = 8;
					
				//VFX
				if (attack_frame > 50 && attack_frame % 3 == 0)
					{
					vfx_create_color(spr_fspec3_trail, 1, 0, 17, x + prng_number(0, 15, -15), y + prng_number(1, 15, -15), 2, prng_choose(1, 0, 90, 180, 270), "VFX_Layer_Below");
					}
				
				if (attack_frame == 40)
					{
					anim_frame = 4;
					speed_set(8 * facing, 0, false, false);
					}
					
				if (attack_frame <= 30)
					{
					if (on_ground())
						{
						friction_gravity(ground_friction);
						}
					else
						{
						aerial_drift_momentum();
						friction_gravity(air_friction, grav, max_fall_speed);
						}
					}
					
				if (attack_frame == 0)
					{
					if (on_ground())
						{
						attack_stop(PLAYER_STATE.idle);
						}
					else
						{
						attack_stop(PLAYER_STATE.helpless);
						}
					run = false;
					}
				break;
				}
			}
		}
	//Movement
	if (!on_ground())
		{
		move();
		}
	else
		{
		move_grounded();
		}
}
/* Copyright 2023 Springroll Games / Yosi */