function fspec4() {
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
				anim_frame = 0;
				anim_speed = 0;
		
				change_facing();
				
				//Struct variables
				custom_attack_struct.fspec4_aerial = false;
				custom_attack_struct.fspec4_ex = false;
				
				if (on_ground())
					{
					speed_set(-1 * facing, 0, false, false);
					attack_frame = 23;
					
					anim_sprite = spr_fspec4_start;
					
					attack_cooldown_set(60);
					
					//VFX
					vfx_create(spr_shine_attack_long, 1, 0, 16, x + (190 * facing), y - 16, 1, prng_number(0, 360));
					
					game_sound_play(snd_fspec4_travel);
					}
				else
					{
					speed_set(-1 * facing, -1, false, false);
					attack_frame = 7;
					landing_lag = 1;
					
					anim_sprite = spr_fspec4_air;
					attack_phase = 3;
					attack_cooldown_set(60);
					}
				
				//EX
				ex_move_reset();
				return;
				}
			//Startup Ground
			case 0:
				{
				//EX
				ex_move_allow(1);
				
				//Animation
				if (attack_frame == 20)
					anim_frame = 1;
				if (attack_frame == 18)
					anim_frame = 2;
				if (attack_frame == 16)
					anim_frame = 3;
				
				if (attack_frame == 12)
					{
					anim_frame = 3;
					
					speed_set(0, 0, false, false);
					
					//Held version
					if (input_held(INPUT.special))
						{
						custom_attack_struct.fspec4_aerial = true;
						}
					else
						{
						custom_attack_struct.fspec4_aerial = false;
						}
					
					//VFX
					var _vfx = vfx_create(spr_dust_dash, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					}
				
				//Moving
				if (custom_attack_struct.fspec4_aerial)
					{
					if (attack_frame == 5) 
						{
						move_x(160 * facing);
						move_y(false, -96);
						}
					}
				else
					{
					if (attack_frame == 4)
						{
						move_x_grounded(sprite_get_bbox_right(mask_index) - sprite_get_bbox_left(mask_index), 192 * facing, false, true);
						}
					}
					
				//Hitbox
				if (attack_frame == 0) 
					{
					if (custom_attack_struct.fspec4_aerial)
						{
						var _hitbox = hitbox_create_melee(-61, 53, 3.6, 0.5, 5, 12, 0.2, 5, 83, 3, SHAPE.rotation, 0);
						hitbox_sprite_angle_set(_hitbox, 23);
						_hitbox.hitstun_scaling = 1.5;
						_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
						_hitbox.hit_sfx = snd_hit_weak2;
						_hitbox.force_reeling = true;
						anim_sprite = spr_fspec4_air_attack;
						
						//EX momentum
						if (custom_attack_struct.fspec4_ex)
							{
							speed_set(10 * facing, -7, false, false);
							}
						else
							{
							speed_set(0, 0, false, false);
							}
						} 
					else 
						{
						var _hitbox = hitbox_create_melee(-61, 14, 3.6, 0.3, 5, 12, 0.2, 5, 78, 3, SHAPE.rotation, 0);
						hitbox_sprite_angle_set(_hitbox, 0);
						_hitbox.hitstun_scaling = 1.5;
						_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
						_hitbox.hit_sfx = snd_hit_weak2;
						_hitbox.force_reeling = true;
						anim_sprite = spr_fspec4;
						
						speed_set(7 * facing, 0, false, false);
						}
					
					anim_frame = 0;
					attack_frame = 7;
					attack_phase++;
					}
				break;
				}
			//Ground
			case 1:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 1;
				
				if (!custom_attack_struct.fspec4_aerial)
					{
					friction_gravity(ground_friction, grav, max_fall_speed);
					}
				else if (custom_attack_struct.fspec4_ex)
					{
					friction_gravity(air_friction, grav / 2, max_fall_speed);
					}
					
				if (attack_frame == 0)
					{
					anim_frame = 2;
					if (custom_attack_struct.fspec4_aerial)
						{
						attack_frame = attack_connected() ? 10 : 16;
						}
					else
						{
						attack_frame = attack_connected() ? 10 : 24;
						}
					attack_phase++;
					}
				break;
				}
			//Finish Ground
			case 2:
				{
				//Animation
				if (attack_frame == 16)
					anim_frame = 3;
				if (attack_frame <= 8)
					anim_frame = 4;
			
				if (!custom_attack_struct.fspec4_aerial)
					{
					friction_gravity(ground_friction, grav, max_fall_speed);
					}
				else if (custom_attack_struct.fspec4_ex)
					{
					friction_gravity(air_friction, grav / 2, max_fall_speed);
					}
				
				//EX repeat
				if (ex_move_is_activated())
					{
					ex_move_reset();
					speed_set(-1 * facing, 0, false, false);
					attack_frame = 6;
					attack_phase = 0;
					custom_attack_struct.fspec4_aerial = true;
					custom_attack_struct.fspec4_ex = true;
					anim_sprite = spr_fspec4_start;
					attack_cooldown_set(60);
					game_sound_play(snd_fspec4_travel);
					break;
					}
				
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			//Startup Air
			case 3:
				{
				//EX
				ex_move_allow(1);
				
				if (attack_frame == 3)
					anim_frame = 1;
			
				if (attack_frame == 0)
					{
					anim_frame = 2;
					attack_frame = 14;
				
					//VFX
					var _vfx = vfx_create(spr_dust_dash, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					
					//Speeds
					speed_set(14 * facing, 27, false, false);
					attack_phase++;
					}
				break;
				}
			//Air
			case 4:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 3;
				if (attack_frame < 10 && attack_frame % 2 == 0)
					{
					anim_frame++;
					if (anim_frame > 6)
						{
						anim_frame = 4;
						}
					}
					
				//Wall Jump Cancel
				if (check_wall_jump())
					{
					attack_stop_preserve_state();
					return;
					}
				
				//Ledge Grab
				if (check_ledge_grab()) return;
				
				//EX repeat
				if (ex_move_is_activated() && attack_frame == 10)
					{
					ex_move_reset();
					speed_set(-1 * facing, 0, false, false);
					attack_frame = 6;
					attack_phase = 0;
					custom_attack_struct.fspec4_aerial = true;
					custom_attack_struct.fspec4_ex = true;
					anim_sprite = spr_fspec4_start;
					attack_cooldown_set(60);
					game_sound_play(snd_fspec4_travel);
					break;
					}
				
				//Jump at the end
				if (attack_frame == 0) 
					{
					attack_stop(PLAYER_STATE.aerial);
					speed_set(0, -12, false, false);
					
					//VFX
					vfx_create(spr_dust_air_jump, 1, 0, 7, x, (bbox_bottom - 1), 2, 0);
					}
					
				if (on_ground())
					{
					anim_frame = 7;
					attack_phase++;
					attack_frame = 5;
					speed_set(hsp / 2, 0, false, false);
					}
				break;
				}
			//Landing from the air version
			case 5:
				{
				friction_gravity((ground_friction * 1.75), grav, max_fall_speed);
				
				//EX repeat
				if (ex_move_is_activated())
					{
					ex_move_reset();
					speed_set(-1 * facing, 0, false, false);
					attack_frame = 6;
					attack_phase = 0;
					custom_attack_struct.fspec4_aerial = true;
					custom_attack_struct.fspec4_ex = true;
					anim_sprite = spr_fspec4_start;
					attack_cooldown_set(60);
					game_sound_play(snd_fspec4_travel);
					}
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
	//Movement
	if (on_ground())
		{
		move_grounded();
		}
	else
		{
		move();
		}
}
/* Copyright 2023 Springroll Games / Yosi */