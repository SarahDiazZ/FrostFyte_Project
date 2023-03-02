function jab_rapid() {
	//Jab
	/*
	- Press the button multiple times to continue the combo
	- The first two hits can be canceled into tilts
	- The rapid attack continues for 20 frames or for as long as you hold the button
	- The last hit automatically happens when you release the button
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(ground_friction, grav, max_fall_speed);
	//Canceling
	if (run && cancel_air_check()) then run = false;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_jab_rapid;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 6;
				
				//Prevent Jab 2 from always buffering
				input_reset(INPUT.attack);
				return;
				}
			//First Jab Startup
			case 0:
				{
				//Animation
				if (attack_frame == 3)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
					attack_phase++;
					attack_frame = 4;
					speed_set(facing * 2, 0, true, false);
					var _hitbox = hitbox_create_melee(20, 0, 0.5, 0.3, 1, 4, 0, 3, 0, 4, SHAPE.circle, 0);
					_hitbox.knockback_state = PLAYER_STATE.flinch;
					_hitbox.custom_hitstun = 12;
					_hitbox.can_be_parried = false;
					_hitbox.can_lock = true;
					}
				break;
				}
			//First Jab Active
			case 1:
				{
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 5;
					}
				break;
				}
			//First Jab Endlag
			case 2:
				{
				//Animation
				if (attack_frame > 2)
					anim_frame = 3;
				else 
					anim_frame = 4;
			
				//Cancel into tilts from first jab
				if (stick_tilted(Lstick) && allow_ground_attacks())
					{
					break;
					}
				//Continue to next jab
				if (input_pressed(INPUT.attack, 12)) || (attack_connected() && input_held(INPUT.attack))
					{
					attack_phase++;
					attack_frame = 4;
					}
				//Auto end
				else if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			//Second Jab Startup
			case 3:
				{
				if (attack_frame == 0)
					{
					anim_frame = 5;
					//Continue jab combo
					attack_phase++;
					attack_frame = 4;
					speed_set(facing * 2, 0, false, false);
					var _hitbox = hitbox_create_melee(20, 5, 0.7, 0.3, 1, 4, 0, 2, 0, 4, SHAPE.circle, 1);
					_hitbox.techable = false;
					_hitbox.can_be_parried = false;
					_hitbox.custom_hitstun = 10;
					_hitbox.can_lock = true;
					}
				break;
				}
			//Second Jab Active
			case 4:
				{
				//Animation
				if (attack_frame > 2)
					anim_frame = 5;
				else
					anim_frame = 6;
			
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 16;
					}
				break;
				}
			//Second Jab Endlag
			case 5:
				{
				//Animation
				anim_frame = 4;
			
				//Cancel into tilts from the second jab
				if (stick_tilted(Lstick) && allow_ground_attacks())
					{
					break;
					}
				//Continue to next jab
				if (input_pressed(INPUT.attack, 12)) || (attack_connected() && input_held(INPUT.attack))
					{
					anim_frame = 7;
					attack_phase++;
					attack_frame = 2;
					speed_set(facing * 5, 0, true, false);
					}
				//Auto end
				else if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			//Third Jab Startup
			case 6:
				{
				//Animation
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 8;
			
					attack_phase++;
					attack_frame = 240;
					var _hitbox = hitbox_create_melee(30, 0, 0.9, 0.7, 1, 1, 0.1, 1, 45, 2, SHAPE.circle, 2);
					_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
					_hitbox.techable = false;
					_hitbox.di_angle = 0;
					_hitbox.asdi_multiplier = 1.5;
					_hitbox.custom_hitstun = 10;
					_hitbox.hitlag_scaling = 0;
					}
				break;
				}
			//Third Jab Active
			case 7:
				{
				//Animation
				if (attack_frame % 4 == 0)
					{
					anim_frame++;
					if (anim_frame > 12)
						{
						anim_frame = 8;
						}
					}
				//Hold to continue the attack
				if (input_held(INPUT.attack) || attack_frame > 220)
					{
					if (attack_frame % 3 == 0)
						{
						hitbox_group_reset_all();
						var _hitbox = hitbox_create_melee(38, 0, 0.9, 0.7, 1, 1, 0.1, 1, 45, 2, SHAPE.circle, 2);
						_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
						_hitbox.techable = false;
						_hitbox.di_angle = 0;
						_hitbox.asdi_multiplier = 1.5;
						_hitbox.custom_hitstun = 10;
						_hitbox.hitlag_scaling = 0;
						_hitbox.shieldstun_scaling = -5;
						}
					}
				if ((!input_held(INPUT.attack) || attack_frame <= 0) && attack_frame <= 220)
					{
					anim_frame = 15;
				
					attack_phase++;
					attack_frame = 10;
					speed_set(facing * 5, 0, false, false);
					}
				break;
				}
			//Third Jab Final Hit
			case 8:
				{
				//Animation
				if (attack_frame == 9)
					anim_frame = 14;
				if (attack_frame == 7)
					anim_frame = 15;
				if (attack_frame == 2)
					anim_frame = 17;
				
				if (attack_frame == 5)
					{
					anim_frame = 16;
					
					var _hitbox = hitbox_create_melee(40, -10, 0.7, 1.3, 4, 10, 0.45, 9, 45, 2, SHAPE.circle, 3);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					var _hitbox = hitbox_create_melee(10, 0, 0.5, 0.5, 4, 10, 0.4, 9, 55, 2, SHAPE.circle, 3);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					}
					
				if (attack_frame == 0)
					{
					attack_frame = attack_connected() ? 15 : 24;
					attack_phase++;
					}
				break;
				}
			//Third Jab Endlag
			case 9:
				{
				//Animation
				if (attack_frame == 19)
					anim_frame = 18;
				if (attack_frame == 14)
					anim_frame = 19;
				if (attack_frame == 7)
					anim_frame = 20;
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();
}
/* Copyright 2023 Springroll Games / Yosi */