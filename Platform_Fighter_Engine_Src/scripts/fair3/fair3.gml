function fair3() {
	//Forward Aerial for character3
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
	fastfall_attack_try();
	allow_hitfall();
	aerial_drift();
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
				anim_sprite = spr_fair3;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 6;
				landing_lag = 12;
				speed_set(0, -1, true, true);
				
				hurtbox_anim_match();
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 3)
					anim_frame = 1;
					
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 8;
					
					var _hitbox = hitbox_create_melee(26, 10, 1.37, 0.42, 8, 7, 0.6, 5, 55, 5, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, -16);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hitstun_scaling = 3;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 3)
					anim_frame = 3;
					
				//Reduce landing lag on hit
				if (attack_connected())
					{
					landing_lag = 6;
					}
					
				if (attack_frame == 0)
					{
					anim_frame = 4;
					attack_phase++;
					attack_frame = attack_connected() ? 10 : 20;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 14)
					anim_frame = 5;
				if (attack_frame == 7)
					anim_frame = 6;
					
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
	
	//Hurtbox
	if (run)
		{
		hurtbox_anim_match();
		}
}
/* Copyright 2023 Springroll Games / Yosi */