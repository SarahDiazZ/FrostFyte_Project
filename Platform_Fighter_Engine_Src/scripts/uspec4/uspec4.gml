function uspec4() {
	//Up Special
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
				//Check if a log already exists or not
				var _log_exists = false;
				with(obj_uspec4_log)
					{
					if (owner == other.id)
						{
						custom_entity_struct.lifetime = 7; //Make sure the log doesn't get destroyed during the startup
						custom_entity_struct.frozen = true; //Make sure the log doesn't move
						_log_exists = true;
						break;
						}
					}
					
				//Do the attack phase if a log is already out
				if(_log_exists)
					{
					anim_sprite = spr_uspec4_act;
					attack_frame = 6;
					attack_phase = 2;
					if (_log_exists)
						{
						speed_set(0, 0, false, false);
						}
					}
				else
					{
					anim_sprite = spr_uspec4;
					attack_frame = 15;
					attack_phase = 0;
					}
					
				anim_speed = 0;
				anim_frame = 0;
				
				//EX
				ex_move_reset();
				return;
				}
			//Throw Startup
			case 0:
				{
				//EX
				ex_move_allow(1);
				
				//Switch to the uppercut if you release special, and aren't holding attack
				if (!input_held(INPUT.special) && attack_frame >= 8 && 
					!input_held(INPUT.attack, buffer_time_standard) && 
					!ex_move_is_activated())
					{
					anim_frame = 0;
					anim_sprite = spr_uspec4_act;
					attack_phase = 5;
					attack_frame = 4;
					break;
					}
				
				//Speeds
				if (!on_ground())
					{
					aerial_drift();
					friction_gravity(air_friction, grav, max_fall_speed);
					}
				else
					{
					friction_gravity(slide_friction, grav, max_fall_speed);
					}
					
				//Animation
				if (attack_frame == 12)
					anim_frame = 1;
				if (attack_frame == 8)
					anim_frame = 2;
				if (attack_frame == 5)
					anim_frame = 3;
				if (attack_frame == 2)
					anim_frame = 4;
				
				if (attack_frame == 0)
					{
					anim_frame = 5;
					
					attack_phase++;
					attack_frame = 6;

					if (!on_ground())
						{
						speed_set(1 * facing, -6, false, false);
						}
						
					game_sound_play(snd_uspec4_throw);

					var _ex = ex_move_is_activated();
					var _throw_dir = 72;
					var _verticle_angle = (sign(stick_get_value(Lstick, DIR.horizontal)) == -facing);
					_throw_dir += (stick_get_value(Lstick, DIR.horizontal) * -18 * facing);
					var _entity = entity_create(x + (facing * 32), y - 32, obj_uspec4_log);
					with(_entity)
						{
						move_out_of_blocks(other.facing == 1 ? 180 : 0);
						hsp = floor(lengthdir_x(14, _throw_dir)) * other.facing;
						vsp = floor(lengthdir_y(14, _throw_dir));
						
						//Vertical angled log has a longer lifetime
						if (_verticle_angle)
							{
							custom_entity_struct.lifetime = 240;
							}
							
						//EX version
						if (_ex)
							{
							custom_entity_struct.lifetime = -1; 
							//Make sure the log doesn't move
							custom_entity_struct.frozen = true; 
							}
						
						//VFX
						var _vfx = vfx_create(spr_uspec4_log_spawn, 1, 0, 26, x, y, 2, 0, "VFX_Layer_Below");
						_vfx.vfx_xscale = choose(-2, 2);
						}
					}
				break;
				}
			//Throw Finish
			case 1:
				{
				//Speeds
				if (!on_ground())
					{
					fastfall_attack_try();
					aerial_drift();
					friction_gravity(air_friction, grav, max_fall_speed);
					}
				else
					{
					friction_gravity(slide_friction, grav, max_fall_speed);
					}
					
				//Animation
				if (attack_frame == 5)
					anim_frame = 6;
				if (attack_frame == 4)
					anim_frame = 7;
				if (attack_frame == 3)
					anim_frame = 8;
				if (attack_frame == 2)
					anim_frame = 9;
				
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			//Attack Startup
			case 2:
				{
				//Animation
				if (attack_frame == 3)
					anim_frame = 1;
					
				//Uppercut
				if (!input_held(INPUT.special) && !input_held(INPUT.attack, buffer_time_standard))
					{
					attack_phase = 5;
					attack_frame = 4;
					break;
					}
					
				if (attack_frame == 0)
					{
					anim_frame = 2;
					
					game_sound_play(snd_uspec4_cut);
					
					//Landing lag
					landing_lag = 25;
					
					//Point towards the log
					var _dir = 90;
					var _log = noone;
					with(obj_uspec4_log)
						{
						if (owner == other.id)
							{
							_log = id;
							break;
							}
						}
						
					//Teleport and slash through the log if the log exists
					if (_log != noone)
						{
						_dir = point_direction(x, y, _log.x, _log.y);
						facing = (_log.x > x) ? 1 : -1;
						anim_angle = (facing == 1) ? _dir : (_dir - 180);
						
						//Teleport the correct distance from the log
						var _len = -25;
						x = round(_log.x + lengthdir_x(_len, _dir));
						y = round(_log.y + lengthdir_y(_len, _dir));
						move_out_of_blocks(90, 16);
						
						//Speeds
						var _spd = 30;
						speed_set(lengthdir_x(_spd, _dir), lengthdir_y(_spd, _dir), false, false);
						
						//Melee Hitbox
						var _hitbox = hitbox_create_melee(-abs(lengthdir_x(60, _dir)), -lengthdir_y(60, _dir), 3, 0.4, 6, 7, 0.7, 13, 45, 4, SHAPE.rotation, 0);
						hitbox_sprite_angle_set(_hitbox, _dir, true);
						_hitbox.hit_sfx = snd_hit_strong2;
						_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
						
						//Freeze frames
						self_hitlag_frame = 10;
						
						//VFX
						var _vfx = vfx_create_color(spr_uspec4_log_cut, 1, 0, 30, x, y, 2, _dir);
						_vfx.vfx_yscale *= prng_choose(0, -1, 1);
						
						//Destroy the log
						with(obj_uspec4_log)
							{
							if (owner == other.id)
								{
								instance_destroy();
								break;
								}
							}
						}
					else
						{
						//If the log doesn't exist, start an uppercut
						attack_phase = 5;
						attack_frame = 4;
						break;
						}
					
					attack_frame = 4;
					attack_phase++;
					}
				break;
				}
			//Attack active
			case 3:
				{
				//Animation
				if (attack_frame == 2)
					anim_frame = 3;
					
				if (attack_frame == 0)
					{
					move_out_of_blocks(90);
					speed_set(hsp / 3, vsp / 3, false, false);
					anim_frame = 4;
					attack_frame = 15;
					attack_phase++;
					}
				break;
				}
			//Attack Finish
			case 4:
				{
				//Speeds
				if (!on_ground())
					{
					fastfall_attack_try();
					aerial_drift();
					friction_gravity(air_friction, grav, max_fall_speed);
					}
				else
					{
					friction_gravity(slide_friction, grav, max_fall_speed);
					}
					
				//Ledge grab
				if (check_ledge_grab()) then return;
				
				//Wall Cling / Wall Jump
				if (check_wall_cling() || check_wall_jump()) then return;
				
				//Animation
				if (attack_frame == 10)
					anim_frame = 5;
				if (attack_frame == 5)
					anim_frame = 6;
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.helpless);
					}
				break;
				}
			//Uppercut Startup
			case 5:
				{
				//Animation
				if (attack_frame == 3)
					anim_frame = 1;
					
				if (attack_frame == 0)
					{
					anim_frame = 2;
					
					game_sound_play(snd_uspec4_cut);
					
					speed_set(0, -35, false, false);
					
					//Landing lag
					landing_lag = 25;
					
					//Uppercut Hitbox
					var _dir = 90;
					anim_angle = (facing == 1) ? _dir : (_dir - 180);
					var _hitbox = hitbox_create_melee(0, 0, 2, 0.3, 12, 5, 1.2, 13, 90, 4, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, _dir, true);
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.hit_vfx_style = [HIT_VFX.slash_medium, HIT_VFX.normal_medium];
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					
					attack_frame = 4;
					attack_phase = 3;
					}
				break;
				}
			}
		}
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */