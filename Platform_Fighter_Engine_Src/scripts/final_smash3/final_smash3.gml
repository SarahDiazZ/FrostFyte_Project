function final_smash3() {
	//Final Smash
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	var _blastzones = obj_stage_manager.blastzones;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_final_smash3;
				anim_speed = 0;
				anim_frame = 0;
				
				reverse_b();
					
				callback_add(callback_draw_end, final_smash3_draw);
					
				attack_frame = 25;
				
				final_smash_startup_script();
				return;
				}
			//Startup
			case 0:
				{
				//Speeds
				if (on_ground())
					{
					friction_gravity(ground_friction);
					}
				else
					{
					aerial_drift();
					friction_gravity(air_friction, grav, max_fall_speed);
					}
				move();
				
				//Animation
				if (attack_frame == 21)
					anim_frame = 1;
				if (attack_frame == 18)
					anim_frame = 2;
				if (attack_frame == 13)
					anim_frame = 4;
				if (attack_frame == 9)
					anim_frame = 5;
				if (attack_frame == 5)
					anim_frame = 6;
					
				//Grab hitbox
				if (attack_frame == 15)
					{
					anim_frame = 3;
					
					change_facing();
					
					var _hitbox = hitbox_create_detectbox(70, -4, 1.6, 1.1, 2, SHAPE.square, 0);
					_hitbox.detect_multihit = true;
					_hitbox.hit_restriction = HIT_RESTRICTION.not_ledge;
					}
				
				//Whiff ending
				if (attack_frame == 0)
					{
					//No more invincibility
					invulnerability_set(INV.normal, -1);
					
					attack_stop();
					}
				break;
				}
			//Detection
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
						command_grab(_target, -8, -48);
						
						attack_phase = 1;
						attack_frame = 60;
						
						ignore_blastzones = true;

						//Target variables
						with(_target)
							{
							facing = -other.facing;
							ignore_blastzones = true;
							invulnerability_set(INV.deactivate, -1);
							hurtbox.sprite_index = -1;
							}
						
						//Grab VFX
						var _dir = 65;
						var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, mean(x, other.x), mean(y, other.y), 3, _dir, "VFX_Layer_Below");
						_vfx.shrink = 0.88;
						_vfx.spin = 9;
						_vfx.fade = true;
						var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, mean(x, other.x), mean(y, other.y), 3, _dir + 180, "VFX_Layer_Below");
						_vfx.shrink = 0.88;
						_vfx.spin = 9;
						_vfx.fade = true;
						
						//Destroy the detectbox
						hitbox_destroy(_hitbox);
						
						//Move the player to the foreground
						player_renderer_set(obj_player_renderer_foreground);
						player_move_to_front();
				
						//Camera
						with(obj_game)
							{
							cam_auto = false;
							if (camera_can_zoom())
								{
								cam_w_goal = camera_width_start;
								cam_h_goal = camera_height_start;
								}
							cam_x_goal = round(other.x - (cam_w_goal div 2));
							cam_y_goal = round(other.y - (cam_h_goal div 2));
							}
					
						//Stop other players
						freeze_gameplay(60, false);
						break;
					}
				return;
				}
			//Rising
			case 1:
				{
				with(obj_game)
					{
					//Camera zoom
					if (camera_can_zoom())
						{
						cam_w = lerp(cam_w, cam_w_goal, setting().camera_zoom_speed_out);
						cam_h = lerp(cam_h, cam_h_goal, setting().camera_zoom_speed_out);
						}
					cam_y_goal = other.y - (cam_h div 2);
					}
				
				//Jump VFX
				if (attack_frame == 41)
					{
					if (on_ground())
						{
						vfx_create(spr_dust_jump, 1, 0, 18, x, (bbox_bottom - 1) - 1, 2, 0);
						}
					else
						{
						vfx_create(spr_dust_air_jump, 1, 0, 7, x, y, 2, 0);
						}
					}
					
				//Rising up
				if (attack_frame <= 41)
					{
					y = round(lerp(y, _blastzones.top, 0.1));
					}
					
				//Move the opponent
				if (attack_frame > 41)
					{
					grab_snap_move();
					}
				else if (instance_exists(grabbed_id))
					{
					grabbed_id.x = x + (grabbed_id.grab_hold_x * facing);
					grabbed_id.y = y + grabbed_id.grab_hold_y;
					}
				
				//Animation
				if (attack_frame == 58)
					anim_frame = 7;
				if (attack_frame == 56)
					anim_frame = 8;
				if (attack_frame == 53)
					anim_frame = 9;
				if (attack_frame == 50)
					anim_frame = 10;
				if (attack_frame == 46)
					anim_frame = 11;
				if (attack_frame == 41)
					anim_frame = 12;
				if (attack_frame == 38)
					anim_frame = 13;
				if (attack_frame == 25)
					anim_frame = 14;
				if (attack_frame == 15)
					anim_frame = 15;
					
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 15;
					
					//Move down to the bottom of the screen and become invisible
					anim_alpha = 0;
					vsp = -14;
					y = camera_height_start;
					if (instance_exists(grabbed_id))
						{
						grabbed_id.x = x + (grabbed_id.grab_hold_x * facing);
						grabbed_id.y = y + grabbed_id.grab_hold_y;
						}
						
					//Freeze all other players and make them invisible
					freeze_gameplay(15 + 120 + 120 + 15, false);
					with(obj_player)
						{
						if (id != other.id)
							{
							invisible = true;
							}
						}
						
					//Set the game in cutscene mode
					obj_game.state = GAME_STATE.cutscene;
					
					//Make sure the camera is 100% correct
					if (camera_can_zoom())
						{
						with(obj_game)
							{
							cam_w = cam_w_goal;
							cam_h = cam_h_goal;
							}
						}
					}
				break;
				}
			//Transition
			case 2:
				{
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 120;
					
					//Make the player visible
					anim_alpha = 1;
					}
				break;
				}
			//Cutscene
			case 3:
				{
				y = round(y + vsp);
				
				//Gravity
				if (abs(vsp) < 1)
					{
					vsp += 0.1;
					}
				else
					{
					vsp += 0.3;
					}
					
				//VFX
				if (attack_frame == 60)
					{
					vfx_create(spr_shine_large, 1, 0, 14, x, y, 2, 41, layer);
					}
				
				//Move the grabbed player
				if (instance_exists(grabbed_id))
					{
					grabbed_id.x = x + (grabbed_id.grab_hold_x * facing);
					grabbed_id.y = y + grabbed_id.grab_hold_y;
					}
				
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 15;
					
					//Snap to the top
					y = round(_blastzones.top);
					grabbed_id.y = y + grabbed_id.grab_hold_y;
					
					//Set the game out of cutscene mode
					obj_game.state = GAME_STATE.normal;
					
					//Make players visible again
					with(obj_player)
						{
						invisible = false;
						}
					}
				break;
				}
			//Transition
			case 4:
				{
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 120;
					}
				break;
				}
			//Falling down
			case 5:
				{
				//Move opponent
				if (instance_exists(grabbed_id))
					{
					grabbed_id.grab_hold_y = -16;
					grabbed_id.x = x + (grabbed_id.grab_hold_x * facing);
					grabbed_id.y = y + grabbed_id.grab_hold_y;
					}
				
				//Animation
				if (attack_frame == 90)
					anim_frame = 16;
					
				//Speeds
				speed_set(0, 0, false, true);
				friction_gravity(0, grav, 20);
				move_hit_platforms();
				
				//Camera
				obj_game.cam_y_goal = y - (obj_game.cam_h div 2);
				
				//Hitting the ground
				if (on_ground())
					{
					attack_phase++;
					attack_frame = 30;
					
					anim_frame = 17;
					
					speed_set(0, 0, false, false);
					
					//Enable blastzones again
					ignore_blastzones = false;
					
					//Target variables
					with(grabbed_id)
						{
						ignore_blastzones = false;
						invulnerability_set(INV.normal, -1);
						hurtbox_reset();
						}
					
					var _hitbox = hitbox_create_melee(0, 8, 2, 1.4, 30, 12, 1.0, 30, 90, 4, SHAPE.square, 1);
					_hitbox.hit_vfx_style = [HIT_VFX.emphasis, HIT_VFX.normal_strong, HIT_VFX.lines];
					_hitbox.hit_sfx = snd_hit_explosion4;
					_hitbox.hitstun_scaling = 0.25;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					
					//VFX
					var _vfx = vfx_create(spr_final_smash3_impact, 1, 0, 32, x, (bbox_bottom - 1) + 1, 2, 0);
					_vfx.vfx_xscale *= prng_choose(0, -1, 1);
					_vfx.vfx_blend = c_ltgray;
					
					//Dramatic zoom
					/*
					with(obj_game)
						{
						cam_w = camera_special_zoom_width;
						cam_h = camera_special_zoom_height;
						cam_x_goal = round(other.x - (cam_w div 2));
						cam_y_goal = round(other.y - (cam_h div 2));
						cam_x = cam_x_goal;
						cam_y = cam_y_goal;
						}
					*/
					}
					
				//Out of bounds check
				if (grabbed_id.bbox_top > _blastzones.bottom && 
					(instance_exists(grabbed_id) && grabbed_id.bbox_top > _blastzones.bottom))
					{
					var _opponent = grabbed_id;
						
					//Knock out you
					knock_out();
					
					//Knock out the opponent if you still have stocks left
					with(_opponent)
						{
						self_hitlag_frame = 0;
						if (other.stock > 0)
							{
							knock_out();
							}
						}
						
					//Reset camera
					obj_game.cam_auto = true;
					break;
					}
				break;
				}
			//Endlag
			case 6:
				{
				//Animation
				if (attack_frame == 25)
					anim_frame = 18;
				if (attack_frame == 17)
					anim_frame = 19;
				if (attack_frame == 8)
					anim_frame = 20;
					
				//Reset camera
				obj_game.cam_auto = true;
					
				//Whiff ending
				if (attack_frame == 0)
					{
					//No more invincibility
					invulnerability_set(INV.normal, -1);
					
					attack_stop();
					}
				break;
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */