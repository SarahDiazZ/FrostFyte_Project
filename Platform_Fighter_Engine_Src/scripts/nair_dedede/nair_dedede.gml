function nair_dedede() {
	//Neutral Aerial
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
				anim_sprite = spr_nair_dedede;
				anim_speed = 0;
				anim_frame = 0;
				
				landing_lag = 13;
				
				attack_frame = 6;
				speed_set(0, -1, true, true);
				
				hurtbox_anim_match();
				return;
				}
			//Startup -> First hit
			case 0:
				{
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 1;
			
					attack_phase++;
					attack_frame = 20;
					var _hit1 = hitbox_create_melee(0, 0, 0.8, 0.8, 5, 6, 0.45, 4, 60, 4, SHAPE.rotation, 3);
					var _hit2 = hitbox_create_melee(0, 0, 0.7, 0.6, 3, 5, 0.4, 2, 70, 20, SHAPE.rotation, 3);
					if (facing == 1)
						{
						_hit1.image_angle = 55;
						_hit2.image_angle = 55;
						}
					else if (facing == -1)
						{
						_hit1.image_angle = 125;
						_hit2.image_angle = 125;
						}
					_hit1.custom_hitstun = 30;
					_hit2.custom_hitstun = 30;
					_hit1.shieldstun_scaling = 0.1;
					_hit2.shieldstun_scaling = 0.1;
					_hit1.hit_vfx_style = HIT_VFX.normal_medium;
					_hit2.hit_vfx_style = HIT_VFX.normal_weak;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 16)
					anim_frame = 2;
					
				//Reduce landing lag on hit
				if (attack_connected())
					{
					landing_lag = 4;
					}
					
				if (attack_frame == 0)
					{
					//Autocancel
					landing_lag = min(landing_lag, 8);
					
					anim_frame = 3;
					attack_phase++;
					attack_frame = 15;
					}
				break;
				}
			//Endlag
			case 2:
				{
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
		hurtbox_anim_match();
		}
}
/* Copyright 2023 Springroll Games / Yosi */