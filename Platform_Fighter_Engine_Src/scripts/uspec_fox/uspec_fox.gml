function uspec_fox() {
	//Up Special
	/*
	- Angle in any direction
	- The beginning of the attack is strongest
	- Hitting the ground at certain angles stops the move
	*/
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
				anim_set(spr_uspec_fox, 0, 0);
			
				//Variable management
				custom_attack_struct.fox_uspec_dir = 0;
				
				callback_add(callback_draw_begin, uspec_fox_draw);
				
				attack_frame = 40;
				landing_lag = 20;
				
				hurtbox_anim_match();
				
				//EX
				ex_move_reset();
				return;
				}
			//Startup -> Active
			case 0:
				{
				//EX
				ex_move_allow(1);
				
				//Animation
				if (attack_frame == 34)
					{
					speed_set(0, 0.5, false, false);
					anim_frame = 1;
					}
				if (attack_frame == 26)
					anim_frame = 2;
				if (attack_frame == 18)
					anim_frame = 3;
				if (attack_frame == 9)
					anim_frame = 4;
				
				//EX version
				if (attack_frame == 30 && ex_move_is_activated())
					{
					change_facing();
					speed_set(5 * facing, -32, false, false);
					
					var _dir = point_direction(0, 0, hsp, vsp);
					var _hitbox = hitbox_create_melee(0, 0, 0.8, 0.8, 5, 9, 0.75, 10, _dir, 36, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.spin, HIT_VFX.normal_strong, HIT_VFX.lines];
					_hitbox.hit_sfx = snd_hit_strong;
					
					attack_phase = 4;
					attack_frame = 120;
					
					anim_angle = _dir;
					break;
					}
				
				//Multihit Attacks
				if (attack_frame <= 28 && attack_frame % 3 == 0)
					{
					hitbox_group_reset(0);
					var _hitbox = hitbox_create_melee(0, 0, 0.9, 0.9, 1, 1, 0, 3, 180, 2, SHAPE.circle, 0, FLIPPER.toward_player_center);
					_hitbox.hitlag_scaling = 0;
					_hitbox.techable = false;
					_hitbox.background_clear_allow = false;
					
					//VFX
					var _vfx = vfx_create(spr_fx_fire, 1, 0, 10, x + prng_number(0, 10, -10), (bbox_bottom - 1) + 16, 2, 270 + prng_number(1, 15, -15));
					_vfx.vfx_yscale = prng_choose(2, -2, 2);
					_vfx.important = true;
					}
				
				if (attack_frame == 0)
					{
					//Point in the correct direction
					var _len = 13;
					var _dir = (stick_tilted(Lstick)) ? stick_get_direction(Lstick) : 90;
					speed_set(lengthdir_x(_len, _dir), lengthdir_y(_len, _dir), false, false);
					hitbox_destroy_attached_all();
					
					//Strong hitbox
					var _knockback = lerp(10, 5, abs(angle_difference(90, _dir)) / 180);
					var _hitbox = hitbox_create_melee(0, 0, 0.8, 0.8, 9, _knockback, 0.65, 11, _dir, 5, SHAPE.circle, 1, FLIPPER.fixed);
					_hitbox.hitstun_scaling = 0.8;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.spin];
					custom_attack_struct.fox_uspec_dir = _dir;
				
					//Animation
					anim_frame = 5;
					anim_angle = (facing == 1 ? _dir : _dir - 180);

					attack_frame = 25;
					attack_phase++;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Late hitbox
				if (attack_frame == 20)
					{
					var _dir = custom_attack_struct.fox_uspec_dir;
					var _knockback = lerp(5, 3, abs(angle_difference(90, _dir)) / 180);
					var _hitbox = hitbox_create_melee(0, 0, 0.4, 0.4, 5, _knockback, 0.5, 5, _dir, 20, SHAPE.circle, 1, FLIPPER.fixed);
					_hitbox.custom_hitstun = 20;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hit_vfx_style = [HIT_VFX.spin, HIT_VFX.normal_weak];
					}
				
				//VFX
				if (attack_frame % 2 == 0)
					{
					var _vfx = vfx_create(spr_fx_smoke, 1, 0, 26, x, y, 2, custom_attack_struct.fox_uspec_dir + prng_number(0, 15, -15), "VFX_Layer_Below");
					_vfx.vfx_yscale = prng_choose(0, -2, 2);
					_vfx.fade = true;
					}
				if (attack_frame % 3 == 0)
					{
					var _vfx = vfx_create(spr_fx_fire, 1, 0, 10, x, y, 2, custom_attack_struct.fox_uspec_dir + prng_number(1, 10, -10));
					_vfx.vfx_yscale = prng_choose(1, -2, 2);
					}
				if (attack_frame % 3 == 1)
					{
					var _vfx = vfx_create(spr_fx_spin, 1, 0, 14, x, y, 1, custom_attack_struct.fox_uspec_dir);
					_vfx.vfx_yscale = prng_choose(2, -1, 1);
					_vfx.shrink = 1.08;
					_vfx.vfx_blend = make_color_hsv(prng_number(0, 40, 0), 200, 255);
					}
				
				//Animation
				if (attack_frame % 3 == 0)
					{
					anim_frame++;
					if (anim_frame > 9)
						anim_frame = 5;
					}
				
				//Hit the ground
				if (on_ground())
					{
					if (abs(angle_difference(custom_attack_struct.fox_uspec_dir, 270)) < 45)
						{
						hitbox_destroy_attached_all();
						speed_set(hsp / 2, -6, false, false);
						attack_frame = 20;
						attack_phase = 3;
						//VFX
						vfx_create(spr_dust_land, 1, 0, 26, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
						break;
						}
					}
			
				//Grab ledges
				if (check_ledge_grab()) 
					{
					run = false;
					return;
					}
			
				//Speed
				var _len = 13;
				speed_set(lengthdir_x(_len, custom_attack_struct.fox_uspec_dir), lengthdir_y(_len, custom_attack_struct.fox_uspec_dir), false, false);
			
				if (attack_frame == 0)
					{
					speed_set(hsp / 2, vsp / 2, false, false);
						
					attack_frame = 20;
					attack_phase++;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 16)
					anim_frame = 10;
				if (attack_frame == 12)
					anim_frame = 11;
				if (attack_frame == 8)
					anim_frame = 12;
				if (attack_frame == 4)
					anim_frame = 13;
				
				//Grab ledges
				if (check_ledge_grab()) 
					{
					run = false;
					return;
					}
					
				//Wall jump cancel
				if (attack_frame <= 10 && check_wall_jump())
					{
					run = false;
					return;
					}
				if (attack_frame <= 10 && check_wall_cling())
					{
					run = false;
					return;
					}
				
				//Friction/gravity
				if (!on_ground())
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					aerial_drift();
					}
				else
					{
					friction_gravity(ground_friction, grav, max_fall_speed);
					}
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.helpless);
					run = false;
					}
				break;
				}
			//Grounded bounce
			case 3:
				{
				//Animation
				if (attack_frame == 16)
					anim_frame = 10;
				if (attack_frame == 12)
					anim_frame = 11;
				if (attack_frame == 8)
					anim_frame = 12;
				if (attack_frame == 4)
					anim_frame = 13;
				
				//Friction/gravity
				friction_gravity(air_friction, grav, max_fall_speed);
			
				//Drift
				aerial_drift();
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.helpless);
					run = false;
					}
				break;
				}
			//EX version
			case 4:
				{
				//Speeds
				friction_gravity(0.5, 1.1, 20);
				if (stick_tilted(Lstick, DIR.horizontal))
					{
					hsp = clamp(hsp + (stick_get_value(Lstick, DIR.horizontal) * 1), -20, 20);
					}
				
				var _dir = point_direction(0, 0, hsp, vsp);
				anim_angle = _dir;
				
				//VFX
				if (attack_frame % 4 == 0)
					{
					var _fx = vfx_create(spr_fx_smoke, 1, 0, 26, x, y, 2, _dir + prng_number(0, 15, -15), "VFX_Layer_Below");
					_fx.vfx_yscale = prng_choose(0, -2, 2);
					_fx.fade = true;
					}
				if (attack_frame % 6 == 0)
					{
					var _fx = vfx_create(spr_fx_fire, 1, 0, 10, x, y, 2, _dir + prng_number(1, 10, -10));
					_fx.vfx_yscale = prng_choose(1, -2, 2);
					}
				if (attack_frame % 7 == 1)
					{
					var _fx = vfx_create(spr_fx_spin, 1, 0, 14, x, y, 1, _dir);
					_fx.vfx_yscale = prng_choose(2, -1, 1);
					_fx.shrink = 1.08;
					_fx.vfx_blend = make_color_hsv(prng_number(0, 40, 0), 200, 255);
					}
					
				//Hitbox on the way down
				if (attack_frame == 84)
					{
					var _hitbox = hitbox_create_melee(0, 0, 0.8, 0.8, 7, 9, 0.75, 18, 270, 84, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.lines];
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.techable = false;
					}
				
				//Animation
				if (attack_frame % 3 == 0)
					{
					anim_frame++;
					if (anim_frame > 9)
						anim_frame = 5;
					}
				
				//Hit the ground
				if (on_ground())
					{
					hitbox_destroy_attached_all();
						
					//Strong hitbox
					var _hitbox = hitbox_create_melee(0, 0, 2, 2, 12, 10, 1.3, 20, 45, 1, SHAPE.circle, 2, FLIPPER.from_hitbox_center_horizontal);
					_hitbox.hitstun_scaling = 0.5;
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.emphasis, HIT_VFX.lines];
						
					speed_set(hsp / 2, -10, false, false);
					attack_frame = 20;
					attack_phase = 3;
					
					//VFX
					vfx_create(spr_dust_land, 1, 0, 26, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					vfx_create(spr_dspec_c4_explosion, 1, 3, 28, x, y, 2, 0);
					camera_shake(0, 5);
					break;
					}
			
				//Grab ledges
				if (check_ledge_grab()) 
					{
					run = false;
					return;
					}
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.helpless);
					}
				break;
				}
			}
		}
	//Movement
	move_hit_platforms();
	
	//Hurtbox
	if (run)
		{
		hurtbox_anim_match();
		}
}
/* Copyright 2023 Springroll Games / Yosi */