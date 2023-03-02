function bair_joker() {
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
				anim_sprite = spr_bair_joker;
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
				if (attack_frame == 5)
					anim_frame = 1;
				if (attack_frame == 3)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
					attack_phase++;
					attack_frame = 3;
					landing_lag = 9;
					var _hitbox = hitbox_create_melee(-26, 24, 0.7, 0.5, 8, 7, 1.1, 4, 135, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.di_angle = 10;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 2)
					{
					anim_frame = 4;
					var _hitbox = hitbox_create_melee(-46, -4, 0.9, 0.6, 8, 7, 1.1, 4, 135, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.di_angle = 10;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				if (attack_frame == 1)
					{
					anim_frame = 5;
					var _hitbox = hitbox_create_melee(-52, -16, 0.6, 1, 8, 7, 1.1, 4, 135, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.di_angle = 10;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				if (attack_frame == 0)
					{
					anim_frame = 6;
					attack_phase++;
					attack_frame = attack_connected() ? 18 : 23;
					}
				break;
				}
			//Finish
			case 2:
				{
				if (attack_frame == 17)
					anim_frame = 7;
				if (attack_frame = 9)
					{
					anim_frame = 8;
					landing_lag = 4;
					}
				
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