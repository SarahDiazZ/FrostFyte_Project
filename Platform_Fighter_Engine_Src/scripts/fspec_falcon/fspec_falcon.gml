function fspec_falcon() {
	//Forward Special
	/*
	- Rushes ahead until an opponent is hit, then attacks
	- The grounded move hits upwards; the aerial move hits downwards
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
				anim_sprite = spr_fspec_falcon;
				anim_frame = 0;
				anim_speed = 0;
		
				//Move backwards
				change_facing();
				if (on_ground())
					{
					speed_set(-6 * facing, 0, false, false);
					}
				else
					{
					speed_set(-1 * facing, 0, false, false);
					landing_lag = 15;
					}
					
				attack_frame = 12;
				
				//EX
				ex_move_reset();
				return;
				}
			//Startup
			case 0:
				{
				//EX
				ex_move_allow(1);
				
				//Animation
				if (attack_frame == 6)
					anim_frame = 1;
				if (attack_frame == 3)
					anim_frame = 2;
			
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 3;
					attack_phase++;
					
					//EX version
					if (ex_move_is_activated())
						{
						attack_frame = 15;
						
						//Detection hitbox
						hitbox_create_detectbox(30, 0, 0.3, 0.4, 15, SHAPE.circle, 0);
						
						//Speed
						if (on_ground()) then speed_set(30 * facing, 0, false, false);
						else speed_set(28 * facing, 0, false, false);
						
						//VFX
						vfx_create_speed_lines(15, x, y, facing == 1 ? 0 : 180);
						}
					else
						{
						attack_frame = 15;
						
						//Detection hitbox
						hitbox_create_detectbox(30, 0, 0.3, 0.4, 15, SHAPE.circle, 0);
						
						//Speed
						if (on_ground()) then speed_set(15 * facing, 0, false, false);
						else speed_set(13 * facing, 0, false, false);
						}
					
					//VFX
					var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					}
				break;
				}
			//Rush
			case 1:
				{
				if (check_ledge_grab()) return;
			
				//Animation
				if (attack_frame % 2 == 0)
					{
					anim_frame++;
					if (anim_frame > 8)
						{
						anim_frame = 5;
						}
					}
				
				//End attack in a failure
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 19;
				
					if (on_ground())
						{
						speed_set(4 * facing, 0, false, false);
						}
					else
						{
						speed_set(4 * facing, -1, false, false);
						}
					attack_phase = 5;
					attack_frame = 28;
					}
				break;
				}
			//Detection
			case PHASE.detection:
				{
				var _target = argument[1];
				var _hurtbox = argument[3];
				var _inv_type = INV.normal;
				if (object_is(_target.object_index, obj_player)) then _inv_type = _hurtbox.inv_type;
				switch(_inv_type)
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
						//Don't count as a hit
						any_hitbox_has_hit = false;
						
						if (attack_phase == 1)
							{
							//If the opponent is hit, auto attack
							if (on_ground())
								{
								//Animation
								anim_frame = 9;
								
								if (ex_move_is_activated())
									{
									speed_set(facing * 2, 0, false, false);
									}
								
								attack_phase = 2;
								attack_frame = 6;
								invulnerability_set(INV.superarmor, 7);
								}
							else
								{
								//Animation
								anim_frame = 14;
							
								speed_set(facing, -4, false, true);
								attack_phase = 4;
								attack_frame = 13;
								invulnerability_set(INV.superarmor, 5);
								}
							}
						break;
					}
				}
				return;
			//Grounded Hit
			case 2:
				{
				friction_gravity(4);
			
				//Animation
				if (attack_frame == 5)
					anim_frame = 10;
			
				if (attack_frame == 4)
					{
					anim_frame = 11;
					hitbox_destroy_attached_all();
				
					var _hitbox = hitbox_create_melee(38, -20, 0.5, 1, 9, 11, 0.1, 10, 80, 4, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.shieldstun_scaling = 0.25;
					_hitbox.drift_di_multiplier = 0.5;
					_hitbox.di_angle = 5;
					_hitbox.custom_shield_damage = 5;
					_hitbox.custom_hitstun = 37;
					var _hitbox = hitbox_create_melee(4, -10, 0.3, 0.5, 9, 11, 0.1, 4, 80, 4, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.shieldstun_scaling = 0.25;
					_hitbox.custom_shield_damage = 5;
					_hitbox.custom_hitstun = 37;
					}
		
				if (attack_frame == 0)
					{
					anim_frame = 12;
					attack_phase++;
					if (attack_connected())
						{
						attack_frame = 6;
						}
					else
						{
						attack_frame = 20;
						}
					}
				break;
				}
			//Grounded Hit Endlag
			case 3:
				{
				//Animation
				if (attack_connected() && attack_frame == 3)
					anim_frame = 13;
				else if (attack_frame == 10)
					anim_frame = 13;
					
				//Cooldown
				attack_cooldown_set(30);
					
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			//Aerial Hit
			case 4:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 16;
				if (attack_frame == 6)
					anim_frame = 17;
				if (attack_frame == 2)
					anim_frame = 18;
			
				if (attack_frame == 11)
					{
					//Animation
					anim_frame = 15;
				
					var _hitbox = hitbox_create_melee(30, 8, 0.5, 1, 9, 9, 0.7, 12, 300, 4, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.shieldstun_scaling = 0.8;
					_hitbox.custom_shield_damage = 5;
					hitbox_create_melee(4, 4, 0.3, 0.5, 9, 9, 0.7, 10, 300, 4, SHAPE.circle, 1);
					}
			
				if (attack_frame == 0)
					{
					//Cooldown
					attack_cooldown_set(30);
					
					//End in helpless if you hit a shield
					if (attack_connected(true, true))
						{
						attack_stop(PLAYER_STATE.helpless);
						}
					else
						{
						attack_stop(PLAYER_STATE.aerial);
						}
					}
				break;
				}
			//No attack finish
			case 5:
				{
				//Animation
				if (attack_frame == 25)
					anim_frame = 20;
				if (attack_frame == 20)
					anim_frame = 21;
				if (attack_frame == 15)
					anim_frame = 22;
				if (attack_frame == 10)
					anim_frame = 23;
			
				if (on_ground())
					{
					friction_gravity(ground_friction, grav, max_fall_speed);
					}
				else
					{
					if (check_ledge_grab()) return;
					friction_gravity(air_friction, grav, max_fall_speed);
					}
				if (attack_frame == 0)
					{
					//Cooldown
					attack_cooldown_set(30);
					
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