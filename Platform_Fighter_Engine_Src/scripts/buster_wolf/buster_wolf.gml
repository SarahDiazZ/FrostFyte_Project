function buster_wolf() {
	/*
	- Rushes ahead until an opponent is hit, then attacks
	- Hitting a shield is the same as missing the attack
	- If used in the air, the attack is weaker
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
				anim_sprite = spr_buster_wolf;
				anim_frame = 0;
				anim_speed = 0;
			
				speed_set(0, 0, false, false);
				attack_frame = 14;
				landing_lag = 12;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 6)
					anim_frame = 1;
				if (attack_frame == 3)
					anim_frame = 2;
			
				if (attack_frame == 0)
					{
					anim_frame = 3;
					attack_frame = 9;
					attack_phase++;
					speed_set(16 * facing, 0, false, false);
					//Detection hitbox
					hitbox_create_detectbox(16, 0, 0.6, 0.6, 9, SHAPE.circle, 0);
					//VFX
					var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					}
				break;
				}
			//Rush
			case 1:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 4;
				if (attack_frame == 6)
					anim_frame = 5;
				if (attack_frame == 4)
					anim_frame = 6;
				if (attack_frame == 2)
					anim_frame = 7;
				
				//VFX
				if (attack_frame % 3 == 0)
					{
					var _vfx = vfx_create(spr_dust_run, 1, 0, 14, x, (bbox_bottom - 1), 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					}
			
				//Miss
				if (attack_frame == 0)
					{
					anim_frame = 8;
					speed_set(8 * facing, 0, false, false);
					attack_phase = 3;
					attack_frame = on_ground() ? 35 : 15;
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
					case INV.shielding:
					case INV.powershielding:
					case INV.reflector:
						//Hitting a shield counts as missing
						anim_frame = 8;
						speed_set(0, 0, false, false);
						attack_phase = 3;
						attack_frame = on_ground() ? 35 : 15;
						break;
					default:
					case INV.normal:
					case INV.parry_press:
					case INV.parry_shield:
					case INV.counter:
					case INV.heavyarmor:
					case INV.superarmor:
						invulnerability_set(INV.superarmor, 8);
						anim_frame = 12;	
						attack_phase = 2;
						attack_frame = 45;
						command_grab(_target, 32, -2);
						with(_target)
							{
							facing = -other.facing;
							//Grab VFX
							var _dir = 0;
							var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, mean(x, other.x), mean(y, other.y), 3, _dir, "VFX_Layer_Below");
							_vfx.shrink = 0.88;
							_vfx.spin = 9;
							_vfx.fade = true;
							var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, mean(x, other.x), mean(y, other.y), 3, _dir + 180, "VFX_Layer_Below");
							_vfx.shrink = 0.88;
							_vfx.spin = 9;
							_vfx.fade = true;
							}
						speed_set(0, 0, false, false);
						
						//Destroy the detectbox
						hitbox_destroy(_hitbox);
						break;
					}
				return;
				}
			//Explosion
			case 2:
				{
				//Grab
				if (attack_frame > 20)
					{
					grab_snap_move();
					}
				
				//Animation
				if (attack_frame == 38)
					anim_frame = 13;
				if (attack_frame == 30)
					anim_frame = 15;
				if (attack_frame == 12)
					anim_frame = 16;
				if (attack_frame == 6)
					anim_frame = 17;
			
				if (attack_frame == 20)
					{
					anim_frame = 14;
				
					//Hitbox
					if (on_ground())
						{
						var _hitbox = hitbox_create_melee(56, 0, 1.1, 0.7, 20, 6, 1.1, 15, 40, 4, SHAPE.square, 1);
						_hitbox.hit_sfx = snd_hit_explosion4;
						_hitbox.hit_vfx_style = [HIT_VFX.explosion, HIT_VFX.normal_strong];
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						_hitbox.hitstun_scaling = 0.5;
						}
					else
						{
						var _hitbox = hitbox_create_melee(56, 0, 1.1, 0.7, 15, 5, 1.1, 8, 45, 4, SHAPE.square, 1);
						_hitbox.hit_sfx = snd_hit_explosion4;
						_hitbox.hit_vfx_style = [HIT_VFX.explosion, HIT_VFX.normal_strong];
						_hitbox.hitstun_scaling = 0.5;
						}
					var _hitbox = hitbox_create_melee(108, 0, 3, 1.8, 5, 7, 0.6, 3, 50, 5, SHAPE.square, 1);
					_hitbox.hit_sfx = snd_hit_explosion4;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
				
					//VFX
					var _vfx = vfx_create(spr_buster_wolf_explosion, 1, 0, 40, x + (48 * facing), y, 2, 0);
					_vfx.vfx_xscale = 2 * facing;
					}
		
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			//Miss
			case 3:
				{
				//Animation
				if (attack_frame == 22)
					anim_frame = 9;
				if (attack_frame == 15)
					anim_frame = 10;

				//Speeds
				friction_gravity(ground_friction);
				
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