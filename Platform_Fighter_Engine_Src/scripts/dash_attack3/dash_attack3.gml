function dash_attack3() {
	//Dash Attack for character3
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	
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
				anim_sprite = spr_dash_attack3;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 11;
				return;
				}
			//Startup
			case 0:
				{
				//Speeds
				friction_gravity(ground_friction, grav, max_fall_speed);
				
				//Animation
				if (attack_frame == 9)
					anim_frame = 1;
				if (attack_frame == 5)
					anim_frame = 2;
				if (attack_frame == 2)
					anim_frame = 3;
					
				if (attack_frame == 0)
					{
					speed_set(11 * facing, 0, false, false);
					
					anim_frame = 4;
			
					attack_phase++;
					attack_frame = 10;
					
					//Strong initial hit
					var _hitbox = hitbox_create_melee(12, 6, 1.1, 0.5, 13, 9, 1.1, 10, 45, 2, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 8)
					{
					anim_frame = 5;
					//Weak late hit
					var _hitbox = hitbox_create_melee(12, 6, 1.1, 0.5, 7, 8, 0.9, 6, 50, 8, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong2;
					}
				
				//Animation
				if (attack_frame == 4)
					anim_frame = 6;
				
				if (attack_frame == 0)
					{
					anim_frame = 7;
					attack_phase++;
					attack_frame = attack_connected() ? 15 : 22;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Speeds
				friction_gravity(ground_friction, grav, max_fall_speed);
				
				//Animation
				if (attack_frame <= 15)
					anim_frame = 8;
				if (attack_frame <= 10)
					anim_frame = 9;
				if (attack_frame <= 5)
					anim_frame = 10;
					
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
}
/* Copyright 2023 Springroll Games / Yosi */