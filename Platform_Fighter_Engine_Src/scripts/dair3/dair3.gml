function dair3() {
	//Down Air
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Hitfalling
	allow_hitfall();
	//Canceling
	if (run && cancel_ground_check()) then run = false;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_dair3;
				anim_speed = 0;
				anim_frame = 0;
			
				attack_frame = 8;
				
				landing_lag = 11;
				
				speed_set(0, -1, true, true);
				
				hurtbox_anim_match(spr_dair3_hurtbox);
				return;
				}
			//Startup
			case 0:
				{
				//Speeds
				fastfall_attack_try();
				aerial_drift();
				friction_gravity(air_friction, grav, max_fall_speed);
					
				//Animation
				if (attack_frame == 5)
					anim_frame = 1;
				if (attack_frame == 2)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
					attack_phase++;
					attack_frame = 30;
					
					//Melee hitbox
					var _hitbox = hitbox_create_melee(64, 8, 0.5, 1.4, 8, 6, 0.75, 6, 290, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak2;
					}
				break;
				}
			//Active
			case 1:
				{
				//Speeds
				fastfall_attack_try();
				aerial_drift();
				friction_gravity(air_friction, grav, max_fall_speed);
				
				//Detectboxes
				if (attack_frame == 29)
					{
					anim_frame = 4;
					hitbox_create_detectbox(30, 50, 0.9, 0.8, 1, SHAPE.circle, 0);
					}
					
				if (attack_frame == 28)
					{
					anim_frame = 5;
					hitbox_create_detectbox(3, 58, 1, 0.5, 4, SHAPE.circle, 0);
					}
					
				//Animation
				if (attack_frame == 26)
					anim_frame = 6;
				if (attack_frame == 24)
					anim_frame = 7;
				if (attack_frame == 20)
					anim_frame = 8;
				if (attack_frame == 15)
					anim_frame = 9;
				if (attack_frame == 10)
					anim_frame = 10;
				if (attack_frame == 5)
					anim_frame = 11;
				
				//Normal ending / early cancel on hit
				if (attack_frame == 0 || (attack_connected() && attack_frame <= 18))
					{
					attack_stop(PLAYER_STATE.aerial);
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
					case INV.shielding:
					case INV.powershielding:
					case INV.parry_press:
					case INV.parry_shield:
					case INV.counter:
					case INV.heavyarmor:
					case INV.superarmor:
						//Don't allow regrabs
						if (grab_regrab_frame == 0)
							{
							//Grab
							command_grab(_target, 0, 62);
						
							anim_frame = 12;
							attack_phase = 2;
							attack_frame = 30;
						
							speed_set(0, 0, false, false);
						
							with(_target)
								{
								player_move_to_front();
								}
						
							//Change target to face the player
							_target.facing = -facing;
						
							//Grab VFX
							var _dir = 12;
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
							}
						break;
					}
				return;
				}
			//Throw
			case 2:
				{
				//Hitfalling
				allow_hitfall(false);
	
				//Speeds
				if (attack_frame < 10)
					{
					fastfall_attack_try();
					aerial_drift();
					friction_gravity(air_friction, grav, max_fall_speed);
					}
					
				//Animation
				if (attack_frame == 28)
					anim_frame = 12;
				if (attack_frame == 26)
					anim_frame = 13;
				if (attack_frame == 23)
					anim_frame = 14;
				if (attack_frame == 20)
					anim_frame = 15;
				if (attack_frame == 18)
					anim_frame = 16;
				if (attack_frame == 16)
					anim_frame = 17;
				if (attack_frame == 15)
					anim_frame = 18;
				if (attack_frame == 14)
					anim_frame = 19;
				if (attack_frame == 12)
					anim_frame = 20;
				if (attack_frame == 10)
					anim_frame = 21;
				if (attack_frame == 8)
					anim_frame = 22;
				if (attack_frame == 6)
					anim_frame = 23;
				if (attack_frame == 4)
					anim_frame = 24;
				if (attack_frame == 2)
					anim_frame = 25;
					
				//Grab Position
				if (attack_frame == 23)
					{
					self_hitlag_frame = 5;
					grabbed_id.self_hitlag_frame = 5;
					}
				if (anim_frame <= 14)
					{
					grab_snap_move();
					}
				if (anim_frame == 15)
					{
					grabbed_id.x = x + (facing * -21);
					grabbed_id.y = y + 56;
					}
				if (anim_frame == 16)
					{
					grabbed_id.x = x + (facing * -35);
					grabbed_id.y = y + 51;
					}
				if (anim_frame == 17)
					{
					grabbed_id.x = x + (facing * -59);
					grabbed_id.y = y + 19;
					}
				if (anim_frame == 18)
					{
					grabbed_id.x = x + (facing * -68);
					grabbed_id.y = y + -13;
					}
				
				//Regrab protection
				grab_regrab_frame = 60;
			
				//Throw hitbox
				if (attack_frame == 15)
					{
					var _hitbox = hitbox_create_targetbox(-68, -13, 2, 2, 5, 8, 0.15, 10, 115, 1, SHAPE.square, 1, grabbed_id);
					_hitbox.custom_hitstun = 30;
					_hitbox.di_angle = 0;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hit_vfx_style = [HIT_VFX.normal_medium, HIT_VFX.slash_weak];
					_hitbox.force_reeling = true;
					}
					
				//Jump cancel
				if (attack_frame < 10 && cancel_jump_check())
					{
					//Turnaround
					facing *= -1;
					
					//Jump canceling puts a cooldown on Side B so it isn't a broken kill confirm
					attack_cooldown_set(10, fspec3);
					
					run = false;
					return;
					}
				
				if (attack_frame == 0)
					{
					//Turnaround
					facing *= -1;
					
					attack_stop(PLAYER_STATE.aerial);
					run = false;
					}
				break;
				}
			}
		}
	//Movement
	move();
	
	//Hurtbox
	if (run)
		{
		hurtbox_anim_match(spr_dair3_hurtbox);
		}
}
/* Copyright 2023 Springroll Games / Yosi */