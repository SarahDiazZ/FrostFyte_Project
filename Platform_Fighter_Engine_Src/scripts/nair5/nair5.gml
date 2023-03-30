function nair5() {
	//Neutral Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
	fastfall_try();
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
				anim_sprite = spr_nair5;
				anim_speed = 0;
				anim_frame = 0;
				landing_lag = 14;
				attack_frame = 2;
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame = 1)
					anim_frame = 0;
				
				if (attack_frame == 0)
					{
					anim_frame = 1;
			
					attack_phase++;
					attack_frame = 4;
					
					//Initial hit
					var _hitbox = hitbox_create_melee(2, -4, .82, 1, 4, 3, 0.1, 8, 0, 2, SHAPE.square, 0, FLIPPER.autolink_center);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.di_angle = 0;
					_hitbox.drift_di_multiplier = 0;
					_hitbox.asdi_multiplier = 0;
					_hitbox.techable = false;
					_hitbox.background_clear_allow = false;
					}
				break;
				}
			case 1:
				{
				if (attack_frame == 0)
					{
					anim_frame = 2;
				
					attack_phase++;
					//Whiff lag
					attack_frame = attack_connected() ? 7 : 16;
					}
				break;
				}
			//Finish
			case 2:
				{
				if (attack_frame == 11)
					anim_frame = 3;
				if (attack_frame == 5)
					anim_frame = 4;
				//Animation
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