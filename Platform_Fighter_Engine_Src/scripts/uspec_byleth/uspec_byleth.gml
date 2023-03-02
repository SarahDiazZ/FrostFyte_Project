function uspec_byleth() {
	//Up Special
	/*
	- Grabs ledges when the ledge tether conditions are met
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Constants
	var _dist_x = 120;
	var _dist_y = -310;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_uspec_byleth;
				anim_speed = 0;
				anim_frame = 0;
				
				//Drawing
				callback_add(callback_draw_begin, uspec_byleth_draw);
				
				//Variables
				custom_attack_struct.byleth_grab_x = x;
				custom_attack_struct.byleth_grab_y = y;
				custom_attack_struct.byleth_stage_grab_dist = 0;
				
				attack_frame = 10;
				
				//VFX
				if (on_ground())
					{
					var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1), 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = (facing * 2);
					}
				return;
				}
			//Startup -> Active
			case 0:
				{
				var _on_ground = on_ground();
				if (_on_ground)
					{
					friction_gravity(ground_friction, grav, max_fall_speed);
					}
				else
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					}
				
				//Animation
				if (attack_frame == 8)
					anim_frame = 1;
				if (attack_frame == 6)
					anim_frame = 2;
				if (attack_frame == 4)
					anim_frame = 3;
				if (attack_frame == 2)
					anim_frame = 4;
				
				//Tether
				if (attack_frame == 0)
					{
					if (!_on_ground)
						{
						if (check_ledge_tether(370)) break;

						//Grabbing the stage
						if (collision_line(x, y, x + (_dist_x * facing), y + _dist_y, obj_block, true, true))
							{
							//Find the closest point
							var _dist = point_distance(x, y, x + (_dist_x * facing), y + _dist_y);
							for(var i = 0; i < _dist; i += 2)
								{
								var _percent = (i / _dist);
								var _x = lerp(x, x + (_dist_x * facing), _percent);
								var _y = lerp(y, y + _dist_y, _percent);
								if (position_meeting(_x, _y, obj_solid) || position_meeting(_x, _y, obj_slope))
									{
									custom_attack_struct.byleth_grab_x = lerp(x, x + (_dist_x * facing), _percent);
									custom_attack_struct.byleth_grab_y = lerp(y, y + _dist_y, _percent);
									custom_attack_struct.byleth_stage_grab_dist = i;
							
									//Move to a different attack phase
									attack_phase = 3;
									attack_frame = 10;
									self_hitlag_frame = 10;
									anim_sprite = spr_ledge_tether0;
									anim_speed = 0.3;
					
									//Grab VFX
									camera_shake(2);
									var _dir = 65;
									var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, custom_attack_struct.byleth_grab_x, custom_attack_struct.byleth_grab_y, 3, _dir, "VFX_Layer_Below");
									_vfx.shrink = 0.88;
									_vfx.spin = 9;
									_vfx.fade = true;
									var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, custom_attack_struct.byleth_grab_x, custom_attack_struct.byleth_grab_y, 3, _dir + 180, "VFX_Layer_Below");
									_vfx.shrink = 0.88;
									_vfx.spin = 9;
									_vfx.fade = true;
									break;
									}
								}
							}
						}

					//If you didn't grab the stage or are on the ground
					if (attack_phase == 0)
						{
						//Vertical speed boost
						if (!_on_ground)
							{
							speed_set(0, -3, true, false);
							}
					
						anim_frame = 5;
						attack_phase++;
						attack_frame = 26;
					
						//Front hitbox
						var _hitbox = hitbox_create_detectbox(32, 6, 0.6, 0.6, 1, SHAPE.circle, 0);
						_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
					
						//Grab point
						custom_attack_struct.byleth_grab_x = x;
						custom_attack_struct.byleth_grab_y = y;
						}
						}
					break;
				}
			//Active -> Endlag
			case 1:
				{
				friction_gravity(0.35, grav, max_fall_speed);
				
				//Move the grab point
				if (attack_frame >= 15)
					{
					if (attack_frame == 15)
						{
						custom_attack_struct.byleth_grab_x = x + (_dist_x * facing);
						custom_attack_struct.byleth_grab_y = y + _dist_y;
						}
					else
						{
						custom_attack_struct.byleth_grab_x = lerp(custom_attack_struct.byleth_grab_x, x + (_dist_x * facing), 0.4);
						custom_attack_struct.byleth_grab_y = lerp(custom_attack_struct.byleth_grab_y, y + _dist_y, 0.4);
						}
					
					//Hitbox
					var _dir = point_direction(x, y, custom_attack_struct.byleth_grab_x, custom_attack_struct.byleth_grab_y);
					var _hitbox = hitbox_create_detectbox((custom_attack_struct.byleth_grab_x - x - lengthdir_x(32, _dir)) * facing, custom_attack_struct.byleth_grab_y - y - lengthdir_y(32, _dir), 1, 0.3, 1, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, _dir, true);
					}
				else if (attack_frame >= 10)
					{
					custom_attack_struct.byleth_grab_x = x + (_dist_x * facing); 
					custom_attack_struct.byleth_grab_y = y + _dist_y;
					}
				else
					{
					var _time = (attack_frame / 10);
					custom_attack_struct.byleth_grab_x = lerp(x, x + (_dist_x * facing), _time); 
					custom_attack_struct.byleth_grab_y = lerp(y, y + _dist_y, _time);
					}
				
				//Animation
				if (attack_frame == 24)
					anim_frame = 6;
				if (attack_frame == 20)
					anim_frame = 7;
				if (attack_frame == 15)
					{
					anim_frame = 8;
					
					//Shine VFX
					vfx_create(spr_shine_attack_long, 1, 0, 16, x + (_dist_x * facing), y + _dist_y, 1, prng_number(0, 360));
					}
				if (attack_frame == 10)
					anim_frame = 9;
				if (attack_frame == 5)
					anim_frame = 10;
				
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			//Grabbing someone
			case PHASE.detection:
				{
				var _target = argument[1];
				var _hitbox = argument[2];
				var _hurtbox = argument[3];
				
				//Only grab players
				if (!object_is(_target.object_index, obj_player)) then return;
				switch(_hurtbox.inv_type)
					{
					case INV.invincible:
					case INV.deactivate:
					case INV.reflector:
					case INV.shielding:
					case INV.powershielding:
						break;
					default:
					case INV.normal:
					case INV.parry_press:
					case INV.parry_shield:
					case INV.counter:
					case INV.heavyarmor:
					case INV.superarmor:
						//Grab - Grounded version hits opponents upward
						if (on_ground())
							{
							command_grab(_target, _dist_x, _dist_y);
							}
						else
							{
							command_grab(_target, (_target.x - x) * facing, _target.y - y);
							}
						
						anim_sprite = spr_ledge_tether0;
						anim_speed = 0.3;
						
						attack_phase = 2;
						attack_frame = 40;
						
						speed_set(0, 0, false, false);
						
						with(_target)
							{
							player_move_to_front();
							}
						
						//Change target to face the player
						_target.facing = -facing;
						
						//Hitlag
						self_hitlag_frame = 8;
						_target.self_hitlag_frame = 8;
						
						//Destroy the detectbox
						hitbox_destroy(_hitbox);
						break;
					}
				return;
				}
			//Grab
			case 2:
				{
				//Move opponent to the grab position
				if (attack_frame >= 30)
					{
					grab_snap_move();
					}
					
				//Move toward the opponent
				if (attack_frame < 30 && attack_frame >= 20)
					{
					var _spd = 40;
					var _distance = point_distance(x, y, grabbed_id.x, grabbed_id.y);
					
					//Snap to the other player
					if (attack_frame == 20 || _distance < _spd)
						{
						x = grabbed_id.x;
						y = grabbed_id.y;
						}
					else
						{
						var _dir = point_direction(x, y, grabbed_id.x, grabbed_id.y);
						var _len = min(_distance, _spd);
						x += round(lengthdir_x(_len, _dir));
						y += round(lengthdir_y(_len, _dir));
						}
					
					if (x == grabbed_id.x && y == grabbed_id.y) then attack_frame = 10;
					}
					
				//Grab VFX
				if (attack_frame == 30)
					{
					var _dir = 65;
					var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, grabbed_id.x, grabbed_id.y, 3, _dir, "VFX_Layer_Below");
					_vfx.shrink = 0.88;
					_vfx.spin = 9;
					_vfx.fade = true;
					var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, grabbed_id.x, grabbed_id.y, 3, _dir + 180, "VFX_Layer_Below");
					_vfx.shrink = 0.88;
					_vfx.spin = 9;
					_vfx.fade = true;
					}
				
				//Explosion
				if (attack_frame == 10)
					{
					//Decide which way to launch the opponent
					var _meteor = false;
					if (match_has_stamina_set())
						{
						if (grabbed_id.stamina < (setting().match_stamina / 2))
							{
							_meteor = true;
							}
						}
					else if (grabbed_id.damage >= 50)
						{
						_meteor = true;
						}
						
					if (_meteor)
						{
						var _hitbox = hitbox_create_targetbox(0, 0, 2, 2, 6, 5, 2, 1, 260, 1, SHAPE.square, 1, grabbed_id);
						_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.explosion];
						_hitbox.hit_sfx = snd_hit_explosion;
						_hitbox.techable = false;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						}
					else
						{
						var _hitbox = hitbox_create_targetbox(0, 0, 2, 2, 6, 8, 0.3, 1, 114, 1, SHAPE.square, 1, grabbed_id);
						_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
						_hitbox.hit_sfx = snd_hit_weak2;
						}
						
					//Jump
					speed_set(6 * facing, -9, false, false);
					}
					
				//Jumping off the opponent
				if (attack_frame < 10)
					{
					aerial_drift();
					friction_gravity(air_friction, grav, max_fall_speed);
					}
				
				if (attack_frame <= 0)
					{
					attack_cooldown_set(15);
					attack_stop();
					}
				break;
				}
			//Grabbing the stage
			case 3:
				{
				//Move toward the stage
				if (attack_frame >= 0)
					{
					var _speed = 40;
					speed_set_towards_point(custom_attack_struct.byleth_grab_x, custom_attack_struct.byleth_grab_y, _speed);
					}
					
				//Jump off the wall when you reach the wall
				if (attack_frame == 0 || distance_to_point(custom_attack_struct.byleth_grab_x, custom_attack_struct.byleth_grab_y) < 10)
					{
					//Turn away from the wall
					if (collision(x + 1, y, [FLAG.solid]))
						{
						facing = -1;
						
						var _vfx = vfx_create(spr_dust_wall_jump, 1, 0, 18, (bbox_right - 1), y, 2, 0);
						_vfx.vfx_xscale = -2;
						}
					else if (collision(x - 1, y, [FLAG.solid]))
						{
						facing = 1;
						
						var _vfx = vfx_create(spr_dust_wall_jump, 1, 0, 18, bbox_left, y, 2, 0);
						_vfx.vfx_xscale = 2;
						}
					
					move_out_of_blocks(facing == 1 ? 0 : 180);
					speed_set(facing * 6, -11, false, false);
					attack_cooldown_set(45);
					attack_stop(PLAYER_STATE.aerial);
					break;
					}
				break;
				}
			}
		}
	//Movement
	move();
}

/* Copyright 2023 Springroll Games / Yosi */