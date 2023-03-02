function jab3() {
	//Jab for character3
	/*
	- Press the button multiple times to continue the combo
	- The first two hits can be canceled into tilts
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
				anim_sprite = spr_jab3;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 4;
				
				hurtbox_anim_match();
				return;
				}
			//First Jab Startup
			case 0:
				{
				//Animation
				if (attack_frame == 2)
					anim_frame = 1;
					
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 8;
					var _hitbox = hitbox_create_magnetbox(54, 2, 0.57, 0.36, 4, 3, -16, 6, 16, 4, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
					_hitbox.can_be_parried = false;
					_hitbox.can_lock = true;
					var _hitbox = hitbox_create_magnetbox(20, 12, 0.6, 0.6, 4, 3, -16, 6, 16, 4, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
					_hitbox.can_be_parried = false;
					_hitbox.can_lock = true;
					}
				break;
				}
			//First Jab Active
			case 1:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 3;
					
				//Cancel into tilts from first jab
				if (attack_connected() && stick_tilted(Lstick) && allow_ground_attacks())
					{
					run = false;
					break;
					}
					
				if (attack_frame == 0)
					{
					anim_frame = 4;
					attack_phase++;
					attack_frame = 15;
					}
				break;
				}
			//First Jab Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 10)
					anim_frame = 5;
				if (attack_frame == 5)
					anim_frame = 6;
			
				//Cancel into tilts from first jab
				if (stick_tilted(Lstick) && allow_ground_attacks())
					{
					run = false;
					break;
					}
					
				//Continue to next jab
				if (input_pressed(INPUT.attack, 12)) || (attack_connected() && input_held(INPUT.attack))
					{
					anim_frame = 7;
					attack_phase++;
					attack_frame = 6;
					}
				//Auto end
				else if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					run = false;
					}
				break;
				}
			//Second Jab Startup
			case 3:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 8;
				if (attack_frame == 2)
					anim_frame = 9;
					
				if (attack_frame == 0)
					{
					anim_frame = 10;
					attack_phase++;
					attack_frame = 10;
					camera_shake(0, 4);
					speed_set(facing * 6, 0, false, false);
					//Finisher
					var _hitbox = hitbox_create_melee(15, 12, 1.4, 0.6, 16, 10, 0.4, 10, 50, 4, SHAPE.square, 1);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.hitstun_scaling = 0.5;
					}
				break;
				}
			//Second Jab Active
			case 4:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 11;
				if (attack_frame == 3)
					anim_frame = 12;
			
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 20;
					}
				break;
				}
			//Second Jab Endlag
			case 5:
				{
				//Animation
				if (attack_frame == 18)
					anim_frame = 13;
				if (attack_frame == 9)
					anim_frame = 14;
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					run = false;
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();
	
	//Hurtbox
	if (run)
		{
		hurtbox_anim_match();
		}
}
/* Copyright 2023 Springroll Games / Yosi */