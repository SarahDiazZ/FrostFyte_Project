function nair_ike() {
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
				anim_sprite = spr_dair_marth;
				anim_speed = 0;
				anim_frame = 0;
		
				landing_lag = 8;
				speed_set(0, -1, true, true);
				attack_frame = 9;
				return;
				}
			//Startup
			case 0:
				{
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 1;
			
					attack_phase++;
					attack_frame = 12;
					var _hitbox = hitbox_create_melee(32, -28, 0.6, 0.5, 7, 6, 0.5, 9, 80, 4, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hitstun_scaling = 4;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 9)
					{
					//Animation
					anim_frame = 2;
					var _hitbox = hitbox_create_melee(30, 26, 0.7, 0.8, 7, 6, 0.5, 9, 80, 4, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hitstun_scaling = 3;
					var _hitbox = hitbox_create_melee(45, 0, 0.7, 0.7, 7, 6, 0.5, 9, 80, 4, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hitstun_scaling = 3;
					}
				if (attack_frame == 6)
					{
					//Animation
					anim_frame = 3;
					var _hitbox = hitbox_create_melee(-18, 32, 1, 0.7, 6, 6, 0.5, 9, 75, 4, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hitstun_scaling = 2;
					}
				if (attack_frame == 3)
					{
					//Animation
					anim_frame = 4;
					var _hitbox = hitbox_create_melee(-48, -4, 0.6, 0.7, 6, 6, 0.5, 9, 70, 4, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hitstun_scaling = 2;
					}
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 5;
			
					attack_phase++;
					attack_frame = attack_connected() ? 14 : 20;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 13)
					anim_frame = 6;
				//Autocancel
				if (attack_frame < 14)
					{
					landing_lag = 4;
					}
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			}
		}
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */