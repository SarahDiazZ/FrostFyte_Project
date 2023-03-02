function fair_slash() {
	//Forward Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	
	//Speeds
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
				anim_sprite = spr_fair_slash;
				anim_speed = 0;
				anim_frame = 0;
			
				landing_lag = 8;
				speed_set(0, -1, true, true);
				attack_frame = 7;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 5)
					anim_frame = 1;
				if (attack_frame == 3)
					anim_frame = 2;
				if (attack_frame == 1)
					anim_frame = 3;
					
				if (attack_frame == 0)
					{
					anim_frame = 4;
					attack_phase++;
					attack_frame = 5;
					
					//Sourspot (arm)
					var _hitbox = hitbox_create_melee(28, 4, 0.5, 0.4, 7, 4, 0.8, 6, 45, 2, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak;
					
					//Tipper (energy)
					var _hitbox = hitbox_create_melee(48, 3, 0.8, 0.6, 11, 5, 1.1, 9, 35, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_medium, HIT_VFX.magic];
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					
					//Grounded-only hitbox
					var _hitbox = hitbox_create_melee(38, 22, 0.8, 0.4, 7, 4, 0.8, 6, 45, 2, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 5;
				if (attack_frame == 3)
					anim_frame = 6;
					
				//Reduce landing lag on hit
				if (attack_connected())
					{
					landing_lag = 2;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 7;
					attack_phase++;
					attack_frame = 20;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 14)
					anim_frame = 8;
				if (attack_frame == 7)
					anim_frame = 9;
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.aerial);
					}
				break;
				}
			}
		}
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */