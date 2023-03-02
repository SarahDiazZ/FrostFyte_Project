function fspec_afterburner_kick() {
	//Forward Special
	/*
	- Only has 2 uses until you touch the ground again (See fspec_afterburner_kick_passive)
	- Has no cooldown if the attack hits an opponent
	- Hold down during the startup of the aerial version to use the downward angled kick
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
				anim_sprite = spr_fspec_afterburner_kick;
				anim_speed = 0;
				anim_frame = 0;
				
				landing_lag = 10;
				
				speed_set(0, 0, true, false);
				
				if (on_ground())
					{
					attack_frame = 10;
					}
				else
					{
					attack_frame = 7;
					}
					
				hurtbox_anim_match(spr_fspec_afterburner_kick_hurtbox);
				
				//EX
				ex_move_reset();
				return;
				}
			//Startup -> Active
			case 0:
				{
				//EX
				ex_move_allow(1);
				
				if (on_ground())
					{
					friction_gravity(ground_friction);
					}
					
				//Animation
				if (attack_frame == 6)
					anim_frame = 1;
				if (attack_frame == 4)
					anim_frame = 2;
				if (attack_frame == 2)
					anim_frame = 3;
					
				if (attack_frame == 0)
					{
					//EX
					if (ex_move_is_activated())
						{
						anim_frame = 5;
						
						//Speed
						speed_set(27 * facing, -6, false, false);
				
						//Hitbox
						var _hitbox = hitbox_create_melee(24, -8, 1.1, 0.7, 18, 6, 1.2, 20, 30, 1, SHAPE.rotation, 0);
						hitbox_sprite_angle_set(_hitbox, 20);
						_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.lines];
						_hitbox.hit_sfx = snd_hit_strong3;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						
						attack_phase = 6;
						attack_frame = 11;
						}
					//Standard
					else if (!stick_tilted(Lstick, DIR.down) || on_ground())
						{
						anim_frame = 4;
					
						//Speed
						speed_set(13 * facing, -3, false, false);
				
						//Hitbox
						var _hitbox = hitbox_create_melee(24, -8, 1, 0.6, 5, 10, 0.2, 8, 65, 3, SHAPE.rotation, 0);
						hitbox_sprite_angle_set(_hitbox, 20);
						_hitbox.custom_hitstun = 33;
						_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					
						attack_phase++;
						attack_frame = 13;
						}
					//Downward angled
					else
						{
						anim_frame = 4;
						anim_angle = facing == 1 ? -65 : 65;
						
						//Speed
						speed_set(8 * facing, 8, false, false);
						landing_lag = 12;
				
						//Hitbox
						var _hitbox = hitbox_create_melee(16, 16, 0.9, 0.5, 4, 11, 0.20, 10, 80, 13, SHAPE.rotation, 0);
						hitbox_sprite_angle_set(_hitbox, -45);
						_hitbox.custom_hitstun = 35;
						_hitbox.di_angle = 3;
						_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
						
						//Collision box
						collision_box_change(spr_fspec_afterburner_kick_collision_box);
						
						attack_phase = 3;
						attack_frame = 14;
						}
					}
				break;
				}
			//Standard Active
			case 1:
				{
				//Grab ledges
				if (check_ledge_grab())
					{
					run = false;
					return;
					}
			
				//Speed - normal
				if (!attack_connected(true, true))
					{
					speed_set(14 * facing, -3, false, false);
					}
				//Speed - after hitting shield
				else
					{
					speed_set(5 * facing, -1, false, false);
					}
			
				//Animation
				if (attack_frame == 11)
					anim_frame = 5;
				if (attack_frame == 9)
					anim_frame = 6;
				if (attack_frame == 7)
					anim_frame = 7;
				if (attack_frame == 5)
					anim_frame = 8;
				if (attack_frame == 3)
					anim_frame = 9;
				if (attack_frame == 1)
					anim_frame = 10;
			
				if (attack_frame == 10)
					{
					var _hitbox = hitbox_create_melee(24, -8, 1, 0.5, 5, 8, 0.2, 8, 70, 3, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 20);
					_hitbox.di_angle = 3;
					_hitbox.custom_hitstun = 30;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					}
					
				if (attack_frame == 7)
					{
					var _hitbox = hitbox_create_melee(24, -8, 1, 0.5, 5, 8, 0.2, 8, 85, 2, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 20);
					_hitbox.di_angle = 3;
					_hitbox.custom_hitstun = 27;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					}
					
				if (attack_frame == 5)
					{
					var _hitbox = hitbox_create_melee(24, -8, 1, 0.4, 5, 8, 0.2, 6, 100, 5, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 20);
					_hitbox.di_angle = 3;
					_hitbox.custom_hitstun = 25;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 11;
					
					//Speed
					speed_set(0, -1, false, false);
				
					if (attack_connected())
						{
						attack_cooldown_set(0);
						attack_frame = 3;
						}
					else
						{
						attack_cooldown_set(45);
						attack_frame = 17;
						}
						
					attack_phase++
					}
				break;
				}
			//Standard Finish
			case 2:
				{
				//Cancel
				if (cancel_ground_check()) 
					{
					run = false;
					break;
					}
					
				//Animation
				if (attack_frame == 13)
					anim_frame = 12;
				if (attack_frame == 9)
					anim_frame = 13;
				if (attack_frame == 5)
					anim_frame = 14;
				if (attack_frame == 2 && anim_frame == 9)
					anim_frame = 12;
			
				//Speed
				friction_gravity(air_friction, grav, max_fall_speed);
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.aerial);
					run = false;
					}
				break;
				}
			//Downward Active
			case 3:
				{
				//Cancel
				if (cancel_ground_check()) 
					{
					run = false;
					break;
					}
				
				//Animation
				if (attack_frame == 12)
					anim_frame = 5;
				if (attack_frame == 10)
					anim_frame = 6;
				if (attack_frame == 8)
					anim_frame = 7;
				if (attack_frame == 6)
					anim_frame = 8;
				if (attack_frame == 4)
					anim_frame = 9;
				if (attack_frame == 2)
					anim_frame = 10;
					
				//Hit cancel
				if (attack_connected())
					{
					hitbox_destroy_attached_all();
					speed_set(0, -5, false, false);
					attack_phase = 5;
					attack_frame = 7;
					break;
					}
					
				if (attack_frame == 0)
					{
					attack_frame = 18;
					attack_phase++;
					}
				break;
				}
			//Downward Finish
			case 4:
				{
				//Cancel
				if (cancel_ground_check())
					{
					run = false;
					break;
					}
				
				//Animation
				if (attack_frame == 13)
					anim_frame = 12;
				if (attack_frame == 9)
					anim_frame = 13;
				if (attack_frame == 4)
					anim_frame = 14;
					
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.aerial);
					run = false;
					}
				break;
				}
			//Downward Jump Finish
			case 5:
				{
				//Drift
				aerial_drift();
				
				//Animation
				if (attack_frame == 6)
					anim_frame = 12;
				if (attack_frame == 4)
					anim_frame = 13;
				if (attack_frame == 2)
					anim_frame = 14;
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.aerial);
					run = false;
					}
				break;
				}
			//EX Active
			case 6:
				{
				//Animation
				if (attack_frame == 10)
					anim_frame = 6;
				if (attack_frame == 9)
					anim_frame = 7;
				if (attack_frame == 8)
					anim_frame = 8;
				if (attack_frame == 7)
					anim_frame = 9;
				if (attack_frame == 6)
					anim_frame = 10;
				if (attack_frame == 4)
					anim_frame = 11;
				if (attack_frame == 2)
					anim_frame = 12;
					
				//EX VFX
				if (attack_frame % 3 == 0)
					{
					var _vfx = vfx_create(spr_fx_spin, 1, 0, 20, x, y, 2, facing == 1 ? 20 : 160, "VFX_Layer_Below");
					_vfx.vfx_blend = c_ltgray;
					_vfx.vfx_xscale = prng_choose(0, -2, 2);
					_vfx.vfx_yscale = prng_choose(1, -2, 2);
					_vfx.shrink = 0.9;
					}
				
				//Late hitbox
				if (attack_frame == 10)
					{
					var _hitbox = hitbox_create_melee(24, -8, 1.0, 0.6, 10, 6, 1.1, 20, 30, 10, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 20);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
					
				//Grab ledges
				if (check_ledge_grab())
					{
					run = false;
					return;
					}
					
				if (attack_frame == 0)
					{
					anim_frame = 13;
					attack_cooldown_set(45);
					attack_frame = 11;
					attack_phase++
					}
				break;
				}
			//EX Finish
			case 7:
				{
				//Cancel
				if (cancel_ground_check()) 
					{
					run = false;
					return;
					}
					
				//Animation
				if (attack_frame == 6)
					anim_frame = 14;
					
				//Additional slowing down
				hsp = approach(hsp, 0, 1);
				
				//Speed
				friction_gravity(air_friction, grav, max_fall_speed);
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.aerial);
					run = false;
					}
				break;
				}
			}
		}
	//Movement
	move();
	
	//Hurtbox matching
	if (run)
		{
		hurtbox_anim_match(spr_fspec_afterburner_kick_hurtbox);
		}
}
/* Copyright 2023 Springroll Games / Yosi */