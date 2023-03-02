function bair_k_rool() {
	//Backward Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
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
				anim_sprite = spr_bair_k_rool;
				anim_speed = 0;
				anim_frame = 0;
				
				landing_lag = 12;
				speed_set(0, -2, true, true);
				attack_frame = 18;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 9)
					anim_frame = 1;
				if (attack_frame == 4)
					anim_frame = 2;
					
				if (attack_frame == 0)
					{
					anim_frame = 3;
			
					attack_phase++;
					attack_frame = 4;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				if (attack_frame == 3)
					{
					anim_frame = 4;
					
					//Early hit
					var _hitbox = hitbox_create_melee(-38, 0, 0.7, 0.7, 12, 8, 1.2, 18, 255, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					hurtbox_create(-38, 0, 0.6, 0.6, 3, SHAPE.circle, INV.normal);
					}
					
				if (attack_frame == 0)
					{
					anim_frame = 5;
				
					attack_phase++;
					attack_frame = 25;
					
					//Late hit
					var _hitbox = hitbox_create_melee(-38, 0, 0.7, 0.7, 9, 7, 1.1, 15, 255, 5, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					var _hitbox = hitbox_create_melee(-30, 24, 0.7, 0.7, 9, 7, 1.1, 15, 255, 5, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					hurtbox_create(-38, 0, 0.6, 0.6, 5, SHAPE.circle, INV.normal);
					hurtbox_create(-30, 24, 0.6, 0.6, 5, SHAPE.circle, INV.normal);
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 22)
					anim_frame = 6;
				if (attack_frame == 20)
					anim_frame = 7;
				if (attack_frame == 17)
					anim_frame = 8;
				if (attack_frame == 13)
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