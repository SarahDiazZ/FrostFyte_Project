function final_smash4() {
	//Final Smash
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Phases
	if (run)
		{
		//Local vars
		var _cx = mean(obj_stage_manager.blastzones.left, obj_stage_manager.blastzones.right);
		var _cy = (obj_stage_manager.blastzones.top + 256);
		
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_final_smash4;
				anim_speed = 0;
				anim_frame = 0;
				
				//No speed in the first few frames
				reverse_b();
				speed_set(0, 0, false, false);
				
				//Move to foreground
				player_renderer_set(obj_player_renderer_foreground);
				player_move_to_front();
				
				//Store variables
				custom_ids_struct.final_smash_target = noone;
				
				final_smash_startup_script();
				
				attack_frame = 12;
				return;
				}
			//Rush forward
			case 0:
				{
				move();
				
				//Turnaround + Start the rush
				if (attack_frame == 8)
					{
					anim_frame = 1;
					change_facing();
					speed_set(40 * facing, 0, false, false);
					
					//VFX
					var _vfx = vfx_create(spr_dust_dash_large, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					
					//Initial hitbox
					var _hitbox = hitbox_create_detectbox(16, 0, 2, 0.6, 12, SHAPE.square, 0);
					_hitbox.detect_multihit = true;
					}
				
				//Animation
				if (attack_frame <= 8)
					{
					anim_frame += 0.5;
					if (anim_frame >= 5)
						anim_frame = 1;
					}
					
				//Whiff ending
				if (attack_frame == 0)
					{
					//No more invincibility
					invulnerability_set(INV.normal, -1);
					
					speed_set(hsp / 2, 0, false, false);
					
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
					case INV.shielding:
					case INV.powershielding:
						with(_target)
							{
							hitbox_register_hit(_hitbox, false, true);
							}
						break;
					default:
					case INV.normal:
					case INV.parry_press:
					case INV.parry_shield:
					case INV.counter:
					case INV.heavyarmor:
					case INV.superarmor:
						//Store opponent's id
						custom_ids_struct.final_smash_target = _target;
						
						attack_phase = 1;
						attack_frame = 250;
						self_hitlag_frame = 15;
						
						ignore_blastzones = true;

						//Target variables
						with(_target)
							{
							self_hitlag_frame = 250 + 15;
							invulnerability_set(INV.deactivate, -1);
							hurtbox.sprite_index = -1;
							state_set(PLAYER_STATE.tumble);
							
							//FX
							hit_vfx_style_create(HIT_VFX.slash_medium, other.facing == 1 ? 0 : 180, _hitbox, 10);
							hit_sfx_play(snd_hit_strong);
							}
						
						//Destroy the detectbox
						hitbox_destroy(_hitbox);
				
						//Camera
						with(obj_game)
							{
							cam_auto = false;
							if (camera_can_zoom())
								{
								cam_w_goal = camera_width_start;
								cam_h_goal = camera_height_start;
								}
							cam_x_goal = round(_cx - (cam_w_goal div 2));
							cam_y_goal = round(_cy - (cam_h_goal div 2));
							}
						break;
					}
				return;
				}
			//Attack
			case 1:
				{
				//Animation
				if (attack_frame > 75)
					{
					anim_frame += 0.2;
					if (anim_frame >= 5)
						anim_frame = 1;
					}
					
				//Move target opponent to the center
				var _target = custom_ids_struct.final_smash_target;
				if (_target != noone && instance_exists(_target))
					{
					if (_target.self_hitlag_frame < 1)
						{
						_target.self_hitlag_frame = 1;
						}
					_target.x = round(lerp(_target.x, _cx, 0.2));
					_target.y = round(lerp(_target.y, _cy, 0.2));
					}
				
				//Camera
				with(obj_game)
					{
					if (camera_can_zoom())
						{
						cam_w = lerp(cam_w, cam_w_goal, setting().camera_zoom_speed_out);
						cam_h = lerp(cam_h, cam_h_goal, setting().camera_zoom_speed_out);
						}
					}
				
				//Slashes
				if (attack_frame == 200)
					{
					with(_target)
						{
						invulnerability_set(INV.normal, -1);
						hurtbox_reset();
						}
					}
				else if (attack_frame < 200 && attack_frame > 75)
					{
					speed_set(0, 0, false, false);
					
					//Always face right so the angle doesn't mess up
					facing = 1;
					
					var _frame = 9 - (attack_frame % 10);
					if (_frame == 0)
						{
						var _angle = prng_number(0, 360);
						anim_angle = _angle;
						var _hitbox = hitbox_create_melee(0, 0, 1, 1, 1, 10, 0.2, 0, _angle, 10, SHAPE.circle, 1);
						_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
						_hitbox.techable = false;
						_hitbox.background_clear_activate = false;
						_hitbox.extra_hitlag = 15;
						_hitbox.hitlag_scaling = 0;
						hitbox_group_reset(1);
						var _len = -200;
						x = round(_cx + lengthdir_x(_len, anim_angle));
						y = round(_cy + lengthdir_y(_len, anim_angle));
						}
					else
						{
						var _len = -200 + (_frame * 40);
						x = round(_cx + lengthdir_x(_len, anim_angle));
						y = round(_cy + lengthdir_y(_len, anim_angle));
						}
					}
				else if (attack_frame <= 75 && attack_frame > 15)
					{
					//Animation
					anim_angle = 0;
					if (attack_frame == 75)
						anim_frame = 5;
					if (attack_frame == 50)
						anim_frame = 6;
					if (attack_frame == 25)
						anim_frame = 7;
						
					
					x = round(_cx);
					y = round(_cy + (attack_frame * 2) - 150);
					}
				else if (attack_frame == 15)
					{
					anim_frame = 8;
					
					var _hitbox;
					if (stick_tilted(Lstick, DIR.horizontal))
						{
						change_facing();
						speed_set(2 * facing, 33, false, false);
						_hitbox = hitbox_create_melee(0, 0, 1, 2, 17, 6, 2, 10, 290, 15, SHAPE.circle, 2);
						}
					else
						{
						speed_set(0, 34, false, false);
						_hitbox = hitbox_create_melee(0, 0, 1, 2, 17, 6, 2, 10, 270, 15, SHAPE.circle, 2);
						}
						
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.slash_weak, HIT_VFX.lines, HIT_VFX.emphasis];
					_hitbox.hit_sfx = snd_hit_explosion4;
					_hitbox.techable = false;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					}

				move();
				
				if (attack_frame == 0 || (on_ground() && attack_frame < 15))
					{
					ignore_blastzones = false;
					
					//Reset camera
					obj_game.cam_auto = true;
					
					//No more invincibility
					invulnerability_set(INV.normal, -1);
					
					speed_set(0, vsp / 2, false, false);
					
					attack_stop();
					}
				break;
				}
			}
		}
	//No movement
}
/* Copyright 2023 Springroll Games / Yosi */