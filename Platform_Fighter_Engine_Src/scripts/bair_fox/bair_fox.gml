function bair_fox() {
	//Backward Aerial
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
				anim_sprite = spr_bair_fox;
				anim_speed = 0;
				anim_frame = 0;
			
				landing_lag = 4;
				speed_set(0, -1, true, true);
				attack_frame = 7;
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
					//Animation
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 3;
					landing_lag = 15;
					var _hitbox = hitbox_create_melee(-36, 4, 0.9, 0.5, 11, 5, 1.1, 7, 150, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hitstun_scaling = 1.25;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 2)
					anim_frame = 3;
				if (attack_frame == 1)
					anim_frame = 4;
				
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 5;
				
					attack_phase++;
					attack_frame = attack_connected() ? 15 : 20;
					landing_lag = 5;
					}
				break;
				}
			//Finish
			case 2:
				{
				if (attack_frame == 16)
					anim_frame = 6;
				if (attack_frame = 7)
					anim_frame = 7;
				
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