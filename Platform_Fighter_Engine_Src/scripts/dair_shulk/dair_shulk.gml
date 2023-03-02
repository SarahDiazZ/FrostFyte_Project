function dair_shulk() {
	//Down Aerial
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
				anim_sprite = spr_dair_shulk;
				anim_speed = 0;
				anim_frame = 0;
				landing_lag = 14;
				speed_set(0, -1, true, true);
				attack_frame = 12;
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame == 8)
					anim_frame = 1;
				if (attack_frame == 4)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
			
					attack_phase++;
					attack_frame = 13;
					
					//Initial hit
					var _hitbox = hitbox_create_melee(8, 36, 0.5, 1, 4, 3, 0.1, 8, 0, 2, SHAPE.circle, 0, FLIPPER.autolink_center);
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
			//Active -> Endlag
			case 1:
				{
				if (attack_frame == 12)
					anim_frame = 4;
				
				if (attack_frame == 11)
					{
					anim_frame = 5;
					
					//Spike
					var _hitbox = hitbox_create_melee(0, 58, 0.4, 0.9, 8, 6, 0.8, 8, 270, 7, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				
				if (attack_frame == 9)
					anim_frame = 6;
				if (attack_frame == 4)
					anim_frame = 7;
			
				if (attack_frame == 0)
					{
					landing_lag = 6;
					attack_phase++;
					attack_frame = attack_connected() ? 12 : 22;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 18)
					anim_frame = 8;
				if (attack_frame == 9)
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