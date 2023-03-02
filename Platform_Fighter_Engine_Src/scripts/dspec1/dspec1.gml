function dspec1() {
	//Down Special for character1
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				callback_add(callback_draw_end, dspec1_draw);
				
				//Charge variable
				if (!variable_struct_exists(custom_attack_struct, "dspec1_charge"))
					{
					custom_attack_struct.dspec1_charge = 0;
					}
				
				//Magnet Field
				if (custom_attack_struct.dspec1_charge >= 180)
					{
					//Animation
					anim_sprite = spr_dspec1;
					anim_frame = 0;
					anim_speed = anim_calculate_speed(spr_dspec1, 36);
				
					attack_frame = 35;
					attack_phase = 1;
				
					speed_set(0, 0, false, false);
					
					custom_attack_struct.dspec1_charge = 0;
					}
				//Charging
				else
					{
					//Animation
					anim_sprite = spr_idle1;
					anim_frame = 0;
					anim_speed = 0.3;
					
					attack_frame = 15;
					attack_phase = 0;
					
					//VFX
					for(var i = 0; i < 4; i++)
						{
						var _len = prng_number(i, 100, 50);
						var _ang = (i * 90) + 43;
						var _vfx = vfx_create(spr_dspec1_particle, 1, 0, 12, x + lengthdir_x(_len, _ang), y + lengthdir_y(_len, _ang), 2, prng_choose(i, 0, 90, 180, 270), "VFX_Layer_Below");
						_vfx.vfx_blend = palette_color_get(palette_data, 1);
						}
					}
					
				//EX
				ex_move_reset();
				break;
				}
			//Charging
			case 0:
				{
				//EX
				ex_move_allow(1);
				if (ex_move_is_activated())
					{
					//Animation
					anim_sprite = spr_dspec1;
					anim_frame = 0;
					anim_speed = anim_calculate_speed(spr_dspec1, 36);
				
					attack_frame = 31;
					attack_phase = 2;
				
					speed_set(0, 0, false, false);
					
					custom_attack_struct.dspec1_charge = 0;
					return;
					}
				
				//Timer
				attack_frame = max(--attack_frame, 0);
				
				//Speeds
				if (on_ground())
					{
					friction_gravity(ground_friction, grav, max_fall_speed);
					}
				else
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					
					//Aerial drift
					var _max_speed = jump_is_dash_jump ? max_air_speed_dash : max_air_speed;

					if (stick_tilted(Lstick, DIR.horizontal))
						{
						var _dir = sign(stick_get_value(Lstick, DIR.horizontal));
						hsp += 1 * _dir;
						}
	
					hsp = clamp(hsp, -_max_speed, _max_speed);
					}
					
				//VFX
				if (custom_attack_struct.dspec1_charge % 3 == 0)
					{
					var _len = prng_number(0, 75, 25);
					var _ang = custom_attack_struct.dspec1_charge * 27;
					var _vfx = vfx_create(spr_dspec1_particle, 1, 0, 12, x + lengthdir_x(_len, _ang), y + lengthdir_y(_len, _ang), 2, prng_choose(0, 0, 90, 180, 270), "VFX_Layer_Below");
					_vfx.vfx_blend = palette_color_get(palette_data, 1);
					_vfx.hsp = lengthdir_x(-3, _ang);
					_vfx.vsp = lengthdir_y(-3, _ang);
					_vfx.follow = id;
					_vfx.follow_offset_x = x - _vfx.x;
					_vfx.follow_offset_y = y - _vfx.y;
					}
					
				custom_attack_struct.dspec1_charge += 1;
				
				if (attack_frame == 0)
					{
					if (custom_attack_struct.dspec1_charge >= 180)
						{
						//Shine VFX
						vfx_create(spr_shine_attack, 1, 0, 8, x + (20 * facing), y, 1, 0);
						game_sound_play(snd_hit_sizzle);
						attack_stop();
						}
					else if (!input_held(INPUT.special))
						{
						attack_cooldown_set(15);
						attack_stop();
						}
					}
				break;
				}
			//Active
			case 1:
				{
				//Timer
				attack_frame = max(--attack_frame, 0);
				
				//Detectbox
				if (attack_frame == 30)
					{
					hitbox_create_detectbox(0, 0, 7, 7, 10, SHAPE.circle, 0);
					
					//VFX
					var _vfx = vfx_create(spr_hit_counter, -1, 12, 35, x, y, 2, prng_choose(1, 0, 90, 180, 270), "VFX_Layer_Below");
					_vfx.vfx_xscale = prng_choose(0, -2, 2);
					_vfx.vfx_blend = palette_color_get(palette_data, 1);
					}
					
				speed_set(0, 0, false, false);
					
				if (attack_frame == 0)
					{
					if (!on_ground())
						{
						speed_set(0, -4, false, false);
						}
					attack_stop();
					}
				break;
				}
			//Detection
			case PHASE.detection:
				{
				var _target = argument[1];
				if (!object_is(_target.object_index, obj_player)) then return;
				with(_target)
					{
					var _dis = point_distance(x, y, other.x, other.y);
					if (_dis > 100)
						{
						if (state == PLAYER_STATE.tumble || 
							state == PLAYER_STATE.helpless ||
							is_launched())
							{
							//Magnetize
							attack_stop_ext(PLAYER_STATE.magnetized) //no port priority
							var _dir = point_direction(other.x, other.y, x, y);
							var _len = min(_dis, 32);
							magnet_goal_x = other.x + lengthdir_x(_len, _dir);
							magnet_goal_y = other.y + lengthdir_y(_len, _dir);
							magnet_snap_speed = 11;
							state_frame = 35;
							self_hitlag_frame = 7;

							//The other player's attack cancels faster
							if (other.attack_frame > 5)
								{
								other.attack_frame = 5;
								other.self_hitlag_frame = 7;
								}
								
							//VFX
							var _vfx = vfx_create(spr_dspec1_strand, 1, 0, 18, other.x + lengthdir_x(90, _dir), other.y + lengthdir_y(90, _dir), 2, _dir, "VFX_Layer_Below");
							_vfx.vfx_blend = palette_color_get(other.palette_data, 1);
							}
						}
					}
				break;
				}
			//EX version
			case 2:
				{
				//Timer
				attack_frame = max(--attack_frame, 0);
				
				//Hitbox
				if (attack_frame == 30)
					{
					var _hitbox = hitbox_create_melee(0, 0, 2.5, 2.5, 10, 7, 0.6, 13, 0, 2, SHAPE.circle, 0, FLIPPER.from_hitbox_center);
					_hitbox.hit_vfx_style = [HIT_VFX.electric_weak, HIT_VFX.magic];
					_hitbox.hit_sfx = snd_hit_explosion2;
					invulnerability_set(INV.invincible, 5);
					}
					
				speed_set(0, 0, false, false);
					
				if (attack_frame == 0)
					{
					if (!on_ground())
						{
						speed_set(0, -4, false, false);
						}
					attack_stop();
					}
				break;
				}
			}
		}
		
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */