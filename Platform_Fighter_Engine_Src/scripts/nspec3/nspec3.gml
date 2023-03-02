function nspec3() {
	//Neutral Special
	/*
	- Grabs enemies in front
	- Hold the button to delay the grab
	- Throws the enemy forwards or upwards, depending on if the stick is tilted or not
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
				anim_sprite = spr_nspec3_grab;
				anim_speed = 0;
				anim_frame = 0;
			
				attack_frame = 20;
				
				reverse_b();
				
				if (on_ground())
					{
					speed_set(0, 0, true, false);
					}
				else
					{
					speed_set(0, -1, true, true);
					}
				
				//EX
				ex_move_reset();
				return;
				}
			//Startup
			case 0:
				{
				//EX
				ex_move_allow(1);
				
				var _on_ground = on_ground();
				
				//Speeds
				if (_on_ground)
					{
					friction_gravity(ground_friction, grav, max_fall_speed);
					}
				else
					{
					aerial_drift();
					fastfall_attack_try();
					friction_gravity(air_friction, grav, max_fall_speed);
					}
					
				//Animation
				if (attack_frame == 15)
					{
					change_facing();
					anim_frame = 1;
					}
				if (attack_frame == 13)
					anim_frame = 2;
				if (attack_frame == 11)
					anim_frame = 3;
				
				if ((attack_frame <= 10 && !input_held(INPUT.special)) || attack_frame == 0)
					{
					if (attack_frame == 0)
						{
						if (!_on_ground)
							{
							speed_set(0, -1, false, false);
							}
						anim_frame = 11;
						attack_phase = 2;
						attack_frame = 30;
						}
					else
						{
						anim_frame = 4;
						attack_phase = 1;
						attack_frame = 35;
						}
					//VFX
					if (_on_ground)
						{
						var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
						_vfx.vfx_xscale = 2 * facing;
						}
					}
				break;
				}
			//Active / Endlag (Uncharged)
			case 1:
				{
				//Hitbox
				if (attack_frame == 33)
					{
					anim_frame = 5;
					hitbox_create_detectbox(60, 9, 1.4, 0.8, 2, SHAPE.square, 0);
					
					//EX boost
					if (ex_move_is_activated())
						{
						speed_set(3 * facing, 0, false, true);
						}
					}
				
				//Speeds
				if (on_ground())
					{
					friction_gravity(ground_friction, grav, max_fall_speed);
					}
				else
					{
					aerial_drift();
					fastfall_attack_try();
					friction_gravity(air_friction, grav, max_fall_speed);
					}
					
				//Animation
				if (attack_frame == 31)
					anim_frame = 6;
				if (attack_frame == 27)
					anim_frame = 7;
				if (attack_frame == 21)
					anim_frame = 8;
				if (attack_frame == 15)
					anim_frame = 9;
				if (attack_frame == 7)
					anim_frame = 10;
				
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			//Active / Endlag (Charged)
			case 2:
				{
				//Hitbox
				if (attack_frame == 28)
					{
					anim_frame = 12;
					hitbox_create_detectbox(74, 5, 1.4, 0.8, 2, SHAPE.square, 0);
					}
				
				//Speeds
				if (on_ground())
					{
					friction_gravity(ground_friction, grav, max_fall_speed);
					}
				else
					{
					aerial_drift();
					fastfall_attack_try();
					friction_gravity(air_friction, grav, max_fall_speed);
					}
					
				//Animation
				if (attack_frame == 26)
					anim_frame = 13;
				if (attack_frame == 22)
					anim_frame = 7;
				if (attack_frame == 16)
					anim_frame = 8;
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
						command_grab(_target, 60, -6);
						
						//Restore double jump
						double_jumps = 1;
						
						anim_sprite = spr_nspec3_throw;
						anim_frame = 0;
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
						break;
					}
				return;
				}
			//Throw
			case 3:
				{
				//Animation
				if (attack_frame == 36)
					anim_frame = 1;
				if (attack_frame == 35)
					anim_frame = 2;
				if (attack_frame == 33)
					anim_frame = 3;
				if (attack_frame == 31)
					anim_frame = 4;
				if (attack_frame == 28)
					anim_frame = 5;
				if (attack_frame == 20)
					anim_frame = 6;
				if (attack_frame == 18)
					anim_frame = 7;
				if (attack_frame == 16)
					anim_frame = 8;
				if (attack_frame == 14)
					anim_frame = 9;
				if (attack_frame == 11)
					anim_frame = 10;
				if (attack_frame == 8)
					anim_frame = 11;
				if (attack_frame == 5)
					anim_frame = 12;
				if (attack_frame == 2)
					anim_frame = 13;
					
				//Grab Position
				if (attack_frame == 36)
					{
					self_hitlag_frame = 5;
					grabbed_id.self_hitlag_frame = 5;
					}
				if (anim_frame <= 1)
					{
					grab_snap_move();
					}
				if (anim_frame == 2)
					{
					grabbed_id.x = x + (facing * 14);
					grabbed_id.y = y + -2;
					}
				if (anim_frame == 3)
					{
					grabbed_id.x = x + (facing * -24);
					grabbed_id.y = y + 6;
					}
				if (anim_frame == 4)
					{
					grabbed_id.x = x + (facing * -56);
					grabbed_id.y = y + 22;
					}
				if (anim_frame == 5)
					{
					grabbed_id.x = x + (facing * -60);
					grabbed_id.y = y + 26;
					}
				if (anim_frame == 6)
					{
					grabbed_id.x = x + (facing * 4);
					grabbed_id.y = y + 6;
					}
				if (attack_frame == 18)
					{
					grabbed_id.x = x + (facing * 68);
					grabbed_id.y = y + -8;
					}
			
				//Throw hitbox
				if (attack_frame == 18)
					{
					//EX throw
					if (ex_move_is_activated())
						{
						var _hitbox = hitbox_create_targetbox(32, -8, 2, 2, 14, 11, 1.3, 4, 55, 1, SHAPE.square, 1, grabbed_id);
						_hitbox.hitstun_scaling = 0.5;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.lines];
						_hitbox.hit_sfx = snd_hit_strong2;
						_hitbox.force_reeling = true;
						}
					else
						{
						var _hitbox = hitbox_create_targetbox(32, -8, 2, 2, 6, 11, 0.2, 7, 95, 1, SHAPE.square, 1, grabbed_id);
						_hitbox.custom_hitstun = 40;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						_hitbox.hit_sfx = snd_hit_strong;
						_hitbox.hit_vfx_style = [HIT_VFX.normal_medium, HIT_VFX.lines];
						_hitbox.force_reeling = true;
						}
					
					//Cooldown on throw
					attack_cooldown_set(40);
					}
					
				//Early cancel
				if (attack_frame <= 10 && cancel_any_action_check()) then return;

				if (attack_frame == 0)
					{
					attack_stop();
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