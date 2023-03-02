function fspec_ganon() {
	//Forward Special
	/*
	- Lunges forward and grabs enemies, then spikes them
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
				anim_sprite = spr_fspec_ganon;
				anim_speed = 0;
				anim_frame = 0;
			
				landing_lag = 10;
				attack_frame = 16;
				speed_set(0, 0, false, false);
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 1;
				if (attack_frame == 9)
					anim_frame = 2;
				if (attack_frame == 6)
					anim_frame = 3;
				if (attack_frame == 3)
					anim_frame = 4;
				
				if (attack_frame == 0)
					{
					anim_frame = 5;
			
					attack_phase++;
					attack_frame = 15;
					hitbox_create_detectbox(32, 0, 0.6, 0.6, 15, SHAPE.square, 0);
					speed_set(10 * facing, 0, false, false);
					}
				break;
				}
			//Lunge
			case 1:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 6;
				if (attack_frame == 9)
					anim_frame = 7;
				if (attack_frame == 6)
					anim_frame = 8;
				if (attack_frame == 3)
					anim_frame = 7;
				
				//VFX
				vfx_create_color(spr_fspec_ganon_trail, 1, 0, 18, x + 32 * facing, y -15 + dcos(attack_frame * 10) * 15, 2, prng_number(0, 360));
			
				//Grab ledges
				if (check_ledge_grab()) then return;
				
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 25;
					speed_set(8 * facing, 0, false, false);
					}
				break;
				}
			//Endlag
			case 2:
				{
				if (on_ground())
					{
					friction_gravity(ground_friction);
					}
				else
					{
					friction_gravity(0.5, grav, max_fall_speed);
					}
				
				//Animation
				if (attack_frame == 19)
					anim_frame = 9;
				if (attack_frame == 13)
					anim_frame = 10;
				if (attack_frame == 6)
					anim_frame = 11;
			
				//Grab ledges
				if (check_ledge_grab()) then return;
			
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
						if (on_ground())
							{
							anim_frame = 12;	
							attack_phase = 3;
							attack_frame = 55;
							command_grab(_target, 48, -32);
							speed_set(0, 0, false, false);
							}
						else
							{
							anim_frame = 18;
							attack_phase = 4;
							attack_frame = 15;
							command_grab(_target, 38, 28);
							with(_target)
								{
								player_move_to_front();
								}
							speed_set(2 * facing, -10, false, false);
							}
						
						//Change target to face the player
						_target.facing = -facing;
						
						//Destroy the detectbox
						hitbox_destroy(_hitbox);
						break;
					}
				return;
				}
			//Grounded attack
			case 3:
				{
				//Grab
				if (attack_frame > 18)
					{
					grab_snap_move();
					}
					
				if (attack_frame == 40)
					anim_frame = 13;
				if (attack_frame == 32)
					anim_frame = 14;
				if (attack_frame == 10)
					anim_frame = 16;
				if (attack_frame == 5)
					anim_frame = 17;
			
				if (attack_frame == 18)
					{
					anim_frame = 15;
					var _hitbox = hitbox_create_melee(32, -16, 0.5, 0.5, 12, 10, 0, 5, 270, 1, SHAPE.square, 1);
					_hitbox.hit_sfx = snd_hit_explosion4;
					_hitbox.hit_vfx_style = [HIT_VFX.explosion, HIT_VFX.magic];
					_hitbox.di_angle = 0;
					}
				
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			//Aerial attack
			case 4:
				{
				friction_gravity(air_friction, grav, 18);
				
				//Move grabbed opponents, even if they would go through a block
				grabbed_id.x = x + (38 * facing);
				grabbed_id.y = y + 28;
			
				if (attack_frame == 13)
					anim_frame = 19;
				if (attack_frame == 10)
					anim_frame = 20;
				if (attack_frame == 6)
					{
					anim_frame = 21;
					speed_set(0, 8, true, false);
					}
				
				//VFX
				vfx_create_color(spr_fspec_ganon_trail, 1, 0, 18, x + 38 * facing, y + 28, 2, prng_number(0, 360), "VFX_Layer_Below");
				
				if (on_ground())
					{
					attack_phase++;
					attack_frame = 20;
					var _hitbox = hitbox_create_melee(16, 16, 1, 0.4, 15, 5, 1, 15, 60, 4, SHAPE.square, 1);
					_hitbox.hit_sfx = snd_hit_explosion4;
					_hitbox.hit_vfx_style = [HIT_VFX.explosion, HIT_VFX.normal_strong];
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					speed_set(0, 0, false, false);
					}
				break;
				}
			//Aerial hitting the ground
			case 5:
				{
				if (attack_frame == 15)
					anim_frame = 22;
				if (attack_frame == 10)
					anim_frame = 23;
				if (attack_frame == 5)
					anim_frame = 24;
				
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