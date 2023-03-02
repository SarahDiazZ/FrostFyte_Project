function bair_sephiroth() {
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
				anim_sprite = spr_bair_sephiroth;
				anim_speed = 0;
				anim_frame = 0;
				landing_lag = 6;
				speed_set(0, -1, true, true);
				attack_frame = 15;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 10)
					anim_frame = 1;
				if (attack_frame == 5)
					anim_frame = 2;
				if (attack_frame == 1)
					{
					anim_frame = 3;
					landing_lag = 16;
					}
					
				if (attack_frame == 0)
					{
					anim_frame = 4;
					attack_phase++;
					attack_frame = 2;
					
					speed_set(-1 * facing, 0, true, true);
					
					//Close hitbox
					var _hitbox = hitbox_create_melee(-28, -4, 0.7, 0.3, 10, 5, 0.9, 10, 150, 2, SHAPE.square, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_medium, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.shieldstun_scaling = 0.1;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					
					//Middle hitbox
					var _hitbox = hitbox_create_melee(-72, -10, 0.7, 0.5, 12, 6, 1, 13, 150, 2, SHAPE.square, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.shieldstun_scaling = 0.1;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					
					//Far hitbox
					var _hitbox = hitbox_create_melee(-112, -5, 1.0, 0.5, 8, 5, 0.8, 9, 150, 2, SHAPE.square, 0, FLIPPER.sakurai_reverse);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_medium, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.shieldstun_scaling = 0.1;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 1)
					anim_frame = 5;
					
				if (attack_frame == 0)
					{
					anim_frame = 6;
					attack_phase++;
					attack_frame = attack_connected() ? 15 : 25;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 23)
					anim_frame = 7;
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