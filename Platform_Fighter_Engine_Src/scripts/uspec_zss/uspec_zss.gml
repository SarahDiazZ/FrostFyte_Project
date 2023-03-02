function uspec_zss() {
	//Up Special
	/*
	- Grounded version goes higher than the aerial version
	- Press down or the attack input at the start to reduce the height
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
				anim_frame = 0;
				anim_sprite = spr_uspec_zss;
				anim_speed = 0;
			
				parry_stun_time = 60;
				landing_lag = 17;
				
				if (!on_ground())
					{
					speed_set(0, -1, false, false);
					}
					
				if (on_ground())
					{
					attack_frame = 5;
					}
				else
					{
					attack_frame = 8;
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
				
				friction_gravity(air_friction, grav, max_fall_speed);
			
				if (attack_frame == 4)
					anim_frame = 1;
				
				//EX version
				if (attack_frame <= 2 && ex_move_is_activated())
					{
					attack_phase = 3;
					attack_frame = 13;
					
					invulnerability_set(INV.superarmor, 3);
					
					//Initial hit
					var _hitbox = hitbox_create_magnetbox(16, -4, 0.6, 1.3, 1, 1, 13, -24, 15, 1, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hitlag_scaling = 0;
					
					if (!on_ground())
						{
						speed_set(2 * facing, -8, false, false);
						}
					else
						{
						speed_set(2 * facing, -6, false, false);
						//VFX
						vfx_create(spr_dust_jump, 1, 0, 18, x, (bbox_bottom - 1) - 1, 2, 0);
						}
						
					landing_lag = 45;
					break;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
				
					//Initial hit
					var _hitbox = hitbox_create_magnetbox(16, -4, 0.4, 0.9, 1, 3, 13, -24, 15, 1, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
					_hitbox.hitlag_scaling = 0;
					
					//Reducing the height
					if (!stick_tilted(Lstick, DIR.down) && !input_pressed(INPUT.shield, 8))
						{
						if (!on_ground())
							{
							speed_set(2 * facing, -10, false, false);
							}
						else
							{
							speed_set(2 * facing, -12, false, false);
							//VFX
							vfx_create(spr_dust_jump, 1, 0, 18, x, (bbox_bottom - 1) - 1, 2, 0);
							}
						}
					else
						{
						speed_set(2 * facing, -4, false, false);
						}
					attack_phase++;
					attack_frame = 20;
					}
				break;
				}
			//Active
			case 1:
				{
				friction_gravity(air_friction);
				
				//Drift
				aerial_drift();
				
				//Ledge grab
				if (check_ledge_grab()) return;
			
				//Animation
				if (attack_frame == 17)
					anim_frame = 3;
				if (attack_frame == 13)
					anim_frame = 4;
				if (attack_frame == 8)
					anim_frame = 5;
				if (attack_frame == 4)
					anim_frame = 6;
				
				//Looping hits
				if (attack_frame % 3 == 0)
					{
					hitbox_group_reset_all();
					var _hitbox = hitbox_create_magnetbox(16, -4, 0.4, 0.9, 1, 3, 13, -24, 15, 1, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
					_hitbox.hitlag_scaling = 0;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 7;
				
					attack_phase++;
					attack_frame = 20;
					speed_set(0, -1, false, false);
					}
				break;
				}
			//Final Hit
			case 2:
				{
				friction_gravity(air_friction, grav, max_fall_speed);
			
				//Animation
				if (attack_frame == 18)
					anim_frame = 8;
				if (attack_frame == 13)
					anim_frame = 10;
				if (attack_frame == 7)
					anim_frame = 11;
				if (attack_frame == 4)
					anim_frame = 12;
			
				if (attack_frame == 16)
					{
					anim_frame = 9;
					var _hitbox = hitbox_create_melee(26, -8, 1, 0.7, 6, 10, 0.7, 18, 60, 3, SHAPE.circle, 2);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_weak, HIT_VFX.slash_strong];
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					if (stick_tilted(Lstick, DIR.left))
						{
						speed_set(-5, -7, false, false);
						}
					else if (stick_tilted(Lstick, DIR.right))
						{
						speed_set(5, -7, false, false);
						}
					else
						{
						speed_set(2 * facing, -8, false, false);
						}
					}
				
				//Ledge grab
				if (check_ledge_grab()) return;
				
				//Wall Jump
				if (attack_frame < 16 && check_wall_jump()) return;
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.helpless);
					}
				break;
				}
			//EX Part 1
			case 3:
				{
				friction_gravity(air_friction);
				
				//Drift
				aerial_drift();
				
				//Ledge grab
				if (check_ledge_grab()) return;
			
				//Animation
				if (attack_frame == 12)
					anim_frame = 4;
				if (attack_frame == 8)
					anim_frame = 5;
				if (attack_frame == 4)
					anim_frame = 6;
				
				//Looping hits
				if (attack_frame % 3 == 0)
					{
					hitbox_group_reset_all();
					var _hitbox = hitbox_create_magnetbox(16, -4, 0.4, 0.9, 1, 1, 13, -24, 15, 1, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hitlag_scaling = 0;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 7;
				
					attack_phase++;
					attack_frame = 66;
					speed_set(0, -1, false, false);
					}
				break;
				}
			//EX Part 2
			case 4:
				{
				friction_gravity(air_friction, grav, max_fall_speed);
				
				//Animation
				if (attack_frame == 24)
					anim_frame = 8;
				if (attack_frame == 21)
					anim_frame = 9;
				if (attack_frame == 17)
					anim_frame = 10;
				if (attack_frame == 13)
					anim_frame = 11;
				if (attack_frame == 8)
					anim_frame = 12;
				
				//More multihits
				if (attack_frame > 24)
					{
					//Reset hitbox
					if (attack_frame % 12 == 0)
						{
						anim_frame = 9;
						hitbox_group_reset(2);
						var _hitbox = hitbox_create_magnetbox(6, -8, 1.4, 0.6, 2, 1, 28, -48, 15, 3, SHAPE.circle, 2, true);
						_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
						_hitbox.hit_sfx = snd_hit_strong2;
						_hitbox.hitlag_scaling = 0;
							
						if (stick_tilted(Lstick, DIR.left))
							{
							speed_set(-3, -5, false, false);
							}
						else if (stick_tilted(Lstick, DIR.right))
							{
							speed_set(3, -5, false, false);
							}
						else
							{
							speed_set(2 * facing, -8, false, false);
							}
						}
					//Animation
					else if (attack_frame % 3 == 0)
						{
						anim_frame++;
						if (anim_frame > 12)
							{
							anim_frame = 7;
							}
						}
					}
				else if (attack_frame == 24)
					{
					anim_frame = 9;
					var _hitbox = hitbox_create_melee(26, -8, 1, 0.7, 6, 10, 0.7, 18, 35, 3, SHAPE.circle, 3);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.emphasis];
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					if (stick_tilted(Lstick, DIR.left))
						{
						speed_set(-6, -7, false, false);
						}
					else if (stick_tilted(Lstick, DIR.right))
						{
						speed_set(6, -7, false, false);
						}
					else
						{
						speed_set(2 * facing, -8, false, false);
						}
					}
				
				//Wall Jump
				if (attack_frame < 16 && check_wall_jump()) return;
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.helpless);
					}
				break;
				}
			}
		}
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */