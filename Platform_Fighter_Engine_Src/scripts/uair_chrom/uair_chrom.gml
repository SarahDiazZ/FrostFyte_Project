function uair_chrom() {
	//Up Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
	allow_hitfall();
	fastfall_attack_try();
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
				anim_sprite = spr_uair_ike;
				anim_speed = 0;
				anim_frame = 0;
			
				landing_lag = 4;
				speed_set(0, -1, true, true);
				attack_frame = 5;
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 1;
			
					attack_phase++;
					attack_frame = 8;
					var _hitbox = hitbox_create_melee(30, -38, 1.1, 1.6, 7, 8, 0.5, 10, 90, 3, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				if (attack_frame == 4)
					{
					anim_frame = 2;
				
					var _hitbox = hitbox_create_melee(0, -48, 1.2, 1, 8, 9, 0.5, 10, 90, 4, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					var _hitbox = hitbox_create_melee(-30, -16, 0.9, 1.1, 7, 6, 0.5, 10, 90, 5, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				if (attack_frame == 2)
					{
					anim_frame = 3;
					}
				if (attack_frame == 0)
					{
					anim_frame = 4;
			
					attack_phase++;
					attack_frame = 17;
					landing_lag = 4;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 7)
					anim_frame = 5;
					
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