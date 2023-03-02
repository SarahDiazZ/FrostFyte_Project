function dspec_nosferatu() {
	//Down Special
	/*
	- Command grabs opponents in front, and heals HP
	- Restores double jump on hit
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	if (on_ground())
		{
		friction_gravity(ground_friction);
		}
	else
		{
		friction_gravity(air_friction, 0.4, 4);
		}
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_dspec_nosferatu;
				anim_frame = 0;
				anim_speed = 0;
			
				attack_frame = 16;
				custom_ids_struct.nosferatu_target = noone;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 10)
					anim_frame = 1;
					
				if (attack_frame == 5)
					{
					speed_set(0, 0, false, false);
					anim_frame = 2;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
				
					attack_phase++;
					attack_frame = 45;
					invulnerability_set(INV.invincible, 3);
				
					//Hitboxes
					var _hitbox = hitbox_create_detectbox(64, 0, 0.9, 0.7, 3, SHAPE.square, 0);
					}
				break;
				}
			//Active / Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 42)
					anim_frame = 4;
				if (attack_frame == 39)
					anim_frame = 5;
				if (attack_frame == 35)
					anim_frame = 6;
				if (attack_frame == 31)
					anim_frame = 7;
				if (attack_frame == 26)
					anim_frame = 8;
				if (attack_frame == 21)
					anim_frame = 9;
				if (attack_frame == 16)
					anim_frame = 10;
				if (attack_frame == 11)
					anim_frame = 11;
				if (attack_frame == 5)
					anim_frame = 12;
			
				if (attack_frame == 0)
					{
					attack_cooldown_set(60);
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
						command_grab(_target, 64, -2);
						attack_phase = 2;
						attack_frame = 30;
						with(_target) 
							{
							player_move_to_back();
							}
						speed_set(0, 0, false, false);
						var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, mean(x, other.x), mean(y, other.y), 3, 0, "VFX_Layer_Below");
						_vfx.shrink = 0.88;
						_vfx.spin = 9;
						_vfx.fade = true;
						var _vfx = vfx_create(spr_hit_grab, 0, 0, 16, mean(x, other.x), mean(y, other.y), 3, 180, "VFX_Layer_Below");
						_vfx.shrink = 0.88;
						_vfx.spin = 9;
						_vfx.fade = true;
						custom_ids_struct.nosferatu_target = _target;
							
							//Destroy the detectbox
						hitbox_destroy(_hitbox);
						break;
					}
				return;
				}
			//Grab
			case 2:
				{
				speed_set(0, 0, false, false);
				
				//Animation
				if (attack_frame == 29)
					anim_frame = 4;
				if (attack_frame == 27)
					anim_frame = 5;
				if (attack_frame == 25)
					anim_frame = 6;
				if (attack_frame == 23)
					anim_frame = 7;
				if (attack_frame == 21)
					anim_frame = 8;
				if (attack_frame == 19)
					anim_frame = 9;
				if (attack_frame == 15)
					anim_frame = 10;
				if (attack_frame == 10)
					anim_frame = 11;
				if (attack_frame == 5)
					anim_frame = 12;
					
				//Looping Hits
				if (attack_frame == 29)
					{
					var _hitbox = hitbox_create_targetbox(64, -2, 2, 2, 1, 0, 0, 2, 35, 9, SHAPE.square, 1, custom_ids_struct.nosferatu_target);
					_hitbox.techable = false;
					_hitbox.custom_hitstun = 10;
					_hitbox.asdi_multiplier = 0;
					_hitbox.drift_di_multiplier = 0;
					_hitbox.hitlag_scaling = 0;
					_hitbox.di_angle = 0;
					_hitbox.hit_vfx_style = HIT_VFX.none;
					_hitbox.hit_sfx = snd_hit_wind;
					}
				if (attack_frame > 20)
					{
					hitbox_group_reset(1);
					//Healing
					apply_damage(id, -1);
					//Grab move
					grab_snap_move();
					}
					
				//Final Hit
				if (attack_frame == 20)
					{
					var _hitbox = hitbox_create_targetbox(64, -2, 2, 2, 3, 11, 0.1, 7, 45, 1, SHAPE.circle, 2, custom_ids_struct.nosferatu_target);
					_hitbox.custom_hitstun = 25;
					_hitbox.di_angle = 0;
					_hitbox.hit_vfx_style = [HIT_VFX.magic, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_explosion4;
					}
					
				if (attack_frame == 0)
					{
					custom_ids_struct.nosferatu_target = noone;
					//Restore double jump
					double_jumps = max_double_jumps;
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