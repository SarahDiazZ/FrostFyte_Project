function uspec3() {
	//Up Special for character3
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
				anim_sprite = spr_uspec3;
				anim_speed = 0;
			
				speed_set(0, 0, false, false);
				
				landing_lag = 24;
				attack_frame = 27;
				
				//Shine VFX
				vfx_create(spr_shine_attack, 1, 0, 8, x + (20 * facing), y, 1, 0);
				
				custom_attack_struct.uspec3_tap = true;
				
				hurtbox_anim_match(spr_uspec3_hurtbox);
				
				//EX
				ex_move_reset();
				return;
				}
			//Startup -> Active
			case 0:
				{
				//EX
				ex_move_allow(2);
				
				//Animation
				if (attack_frame == 23)
					anim_frame = 1;
				if (attack_frame == 19)
					anim_frame = 2;
				
				//EX version
				if (ex_move_is_activated() && attack_frame <= 20)
					{
					custom_attack_struct.uspec3_tap = false;
					
					game_sound_play(snd_hit_wind);
					
					speed_set(6 * facing, -16, false, false);
					
					anim_frame = 3;
				
					attack_phase++;
					attack_frame = 11;
					hitbox_create_detectbox(12, -30, 0.6, 1, 11, SHAPE.square, 0);
					hitbox_create_detectbox(30, 10, 0.4, 0.5, 1, SHAPE.square, 0);
					
					//VFX
					if (on_ground())
						{
						vfx_create(spr_dust_jump, 1, 0, 18, x, (bbox_bottom - 1) - 1, 2, 0);
						}
					var _vfx = vfx_create(spr_fx_spin, 1, 0, 14, x, y, 1, 90, "VFX_Layer_Below");
					_vfx.vfx_xscale = prng_choose(0, 1, -1);
					break;
					}
				
				//Tapped
				if (attack_frame <= 15 && !input_held(INPUT.special))
					{
					custom_attack_struct.uspec3_tap = true;
					
					game_sound_play(snd_hit_wind);
					
					speed_set(4 * facing, -15, false, false);
					
					anim_frame = 3;
				
					attack_phase++;
					attack_frame = 11;
					hitbox_create_detectbox(12, -30, 0.6, 1, 11, SHAPE.square, 0);
					hitbox_create_detectbox(30, 10, 0.4, 0.5, 1, SHAPE.square, 0);
					
					//VFX
					if (on_ground())
						{
						vfx_create(spr_dust_jump, 1, 0, 18, x, (bbox_bottom - 1) - 1, 2, 0);
						}
					}
				//Held
				else if (attack_frame == 0)
					{
					custom_attack_struct.uspec3_tap = false;
					
					game_sound_play(snd_hit_wind);
					
					speed_set(4 * facing, -20, false, false);
					
					anim_frame = 3;
				
					attack_phase++;
					attack_frame = 11;
					hitbox_create_detectbox(12, -30, 0.6, 1, 11, SHAPE.square, 0);
					hitbox_create_detectbox(30, 10, 0.4, 0.5, 1, SHAPE.square, 0);
					
					//VFX
					if (on_ground())
						{
						vfx_create(spr_dust_jump, 1, 0, 18, x, (bbox_bottom - 1) - 1, 2, 0);
						}
					var _vfx = vfx_create(spr_fx_spin, 1, 0, 14, x, y, 1, 90, "VFX_Layer_Below");
					_vfx.vfx_xscale = prng_choose(0, 1, -1);
					}
				break;
				}
			//Active
			case 1:
				{
				//VFX
				if (attack_frame % 3 == 0)
					{
					vfx_create_color(spr_fspec3_trail, 1, 0, 18, x + prng_number(0, 15, -15), y + prng_number(1, 15, -15), 2, prng_choose(0, 0, 90, 180, 270), "VFX_Layer_Below");
					}
					
				//Animation
				if (attack_frame == 10)
					anim_frame = 4;
				if (attack_frame == 6)
					anim_frame = 5;
				if (attack_frame == 3)
					anim_frame = 6;
					
				//Grab ledges
				if (check_ledge_grab())
					{
					attack_stop_preserve_state();
					return;
					}
				
				//Drift while rising
				if (stick_tilted(Lstick, DIR.horizontal))
					{
					hsp += 1.5 * stick_get_value(Lstick, DIR.horizontal);
					}
				if (facing == 1)
					{
					hsp = clamp(hsp, -2, 7);
					}
				else
					{
					hsp = clamp(hsp, -7, 2);
					}
					
				//VFX
				if (!custom_attack_struct.uspec3_tap && attack_frame % 4 == 0)
					{
					var _vfx = vfx_create(spr_fx_spin, 1, 0, 14, x, y, 1, 90, "VFX_Layer_Below");
					_vfx.vfx_xscale = prng_choose(0, 1, -1);
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 7;
				
					if (vsp < 0)
						{
						speed_set(0, 6, true, true);
						}
						
					attack_phase++;
					attack_frame = 20;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 18)
					anim_frame = 8;
				if (attack_frame == 15)
					anim_frame = 9;
				if (attack_frame == 12)
					anim_frame = 10;
				if (attack_frame == 9)
					anim_frame = 11;
				if (attack_frame == 6)
					anim_frame = 12;
				if (attack_frame == 3)
					anim_frame = 13;
					
				//Gravity
				friction_gravity(air_friction, grav, max_fall_speed);
				
				//Grab ledges
				if (check_ledge_grab())
					{
					attack_stop_preserve_state();
					return;
					}
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.helpless);
					run = false;
					}
				break;
				}
			//Grabbing someone
			case PHASE.detection:
				{
				var _target = argument[1];
				var _hitbox = argument[2];
				var _hurtbox = argument[3];
				if (!object_is(_target.object_index, obj_player)) then return;
				switch(_hurtbox.inv_type)
					{
					case INV.invincible:
					case INV.deactivate:
					case INV.reflector:
						break;
					default:
					case INV.normal:
					case INV.parry_press:
					case INV.parry_shield:
					case INV.counter:
					case INV.shielding:
					case INV.powershielding:
					case INV.heavyarmor:
					case INV.superarmor:
						//Grab
						command_grab(_target, 22, 26);
						
						anim_frame = 14;
						attack_phase = 3;
						attack_frame = 40;
						
						speed_set(0, 0, false, false);
						
						with(_target)
							{
							player_move_to_front();
							}
						
						//Change target to face the player
						_target.facing = -facing;
						
						//Grab VFX
						var _dir = 41;
						var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, mean(x, other.x), mean(y, other.y), 3, _dir, "VFX_Layer_Below");
						_vfx.shrink = 0.88;
						_vfx.spin = 9;
						_vfx.fade = true;
						var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, mean(x, other.x), mean(y, other.y), 3, _dir + 180, "VFX_Layer_Below");
						_vfx.shrink = 0.88;
						_vfx.spin = 9;
						_vfx.fade = true;
						
						//Destroy all detectboxes
						hitbox_destroy_attached_all();
						break;
					}
				return;
				}
			//Explosion
			case 3:
				{
				//Animation
				if (attack_frame == 30)
					anim_frame = 15;
				if (attack_frame == 25)
					anim_frame = 16;
				if (attack_frame == 20)
					anim_frame = 17;
				if (attack_frame == 18)
					anim_frame = 18;
				if (attack_frame == 16)
					anim_frame = 19;
				if (attack_frame == 14)
					anim_frame = 20;
				if (attack_frame == 12)
					anim_frame = 21;
				if (attack_frame == 10)
					anim_frame = 22;
				if (attack_frame == 8)
					anim_frame = 23;
				if (attack_frame == 6)
					anim_frame = 24;
				if (attack_frame == 3)
					anim_frame = 25;
					
				//Grab Position
				if (attack_frame > 25)
					{
					grab_snap_move(grabbed_id, 10);
					//Move towards the target
					speed_set_towards_point
						(
						grabbed_id.x - grabbed_id.grab_hold_x * facing,
						grabbed_id.y - grabbed_id.grab_hold_y,
						15,
						);
					move();
					speed_set(0, 0, false, false);
					}
				if (attack_frame == 26)
					{
					self_hitlag_frame = 5;
					grabbed_id.self_hitlag_frame = 5;
					}
					
				if (attack_frame < 25)
					{
					//Speeds
					aerial_drift();
					friction_gravity(air_friction, grav, max_fall_speed);
					}
				
				//Airdodge / Jump cancel / Cancel with another Up Special
				if (attack_frame <= 15 && attack_frame != 0)
					{
					if (stick_tilted(Lstick, DIR.up) && input_pressed(INPUT.special))
						{
						attack_stop();
						change_facing();
						attack_start(uspec3);
						return;
						}
					if (cancel_jump_check()) then return;
					if (cancel_airdodge_check()) then return;
					}
			
				//Explosion hitbox
				if (attack_frame == 25)
					{
					//EX
					if (ex_move_is_activated())
						{
						var _hitbox = hitbox_create_targetbox(22, 26, 2, 2, 15, 10, 1, 7, 270, 1, SHAPE.square, 1, grabbed_id);
						_hitbox.hit_sfx = snd_hit_strong3;
						_hitbox.hit_vfx_style = [HIT_VFX.electric, HIT_VFX.normal_strong, HIT_VFX.emphasis];
						_hitbox.hitstun_scaling = 0.25;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						_hitbox.techable = false;
						speed_set(7 * facing, -14, false, false);
						}
					//Tapped
					else
						{
						if (custom_attack_struct.uspec3_tap)
							{
							var _hitbox = hitbox_create_targetbox(22, 26, 2, 2, 8, 7, 0.6, 7, 40, 1, SHAPE.square, 1, grabbed_id);
							_hitbox.hit_sfx = snd_hit_strong3;
							_hitbox.hit_vfx_style = [HIT_VFX.electric, HIT_VFX.normal_strong];
							_hitbox.hitstun_scaling = 0.25;
							_hitbox.knockback_state = PLAYER_STATE.balloon;
							}
						//Held
						else
							{
							var _hitbox = hitbox_create_targetbox(22, 26, 2, 2, 12, 8, 1, 7, 40, 1, SHAPE.square, 1, grabbed_id);
							_hitbox.hit_sfx = snd_hit_strong3;
							_hitbox.hit_vfx_style = [HIT_VFX.electric, HIT_VFX.normal_strong, HIT_VFX.lines];
							_hitbox.hitstun_scaling = 0.75;
							_hitbox.knockback_state = PLAYER_STATE.balloon;
							}
						speed_set(-6 * facing, -10, false, false);
						}
					}
				
				if (attack_frame == 0)
					{
					attack_stop();
					run = false;
					}
				break;
				}
			}
		}
	//Movement
	move();
	
	//Hurt matching
	if (run)
		{
		hurtbox_anim_match(spr_uspec3_hurtbox);
		}
}
/* Copyright 2023 Springroll Games / Yosi */