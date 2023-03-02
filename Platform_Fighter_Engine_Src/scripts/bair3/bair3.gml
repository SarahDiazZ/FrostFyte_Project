function bair3() {
	//Backward Aerial for character3
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
				anim_sprite = spr_bair3;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 8;
				landing_lag = 17;
				speed_set(0, -1, true, true);
				
				hurtbox_anim_match();
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
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 8;
					
					speed_set(-1 * facing, 0, true, true);
					
					var _hitbox = hitbox_create_melee(-44, 2, 0.9, 0.8, 15, 9, 0.6, 9, 145, 2, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.hitstun_scaling = 0.5;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 6)
					{
					anim_frame = 3;
					
					var _hitbox = hitbox_create_melee(-38, 2, 0.9, 0.8, 13, 9, 0.6, 9, 145, 2, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.hitstun_scaling = 0.5;
					}
					
				if (attack_frame == 4)
					anim_frame = 4;
					
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = attack_connected() ? 15 : 25;
					
					//Autocancel
					landing_lag = 8;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 20)
					anim_frame = 5;
				if (attack_frame == 14)
					anim_frame = 6;
				if (attack_frame == 7)
					anim_frame = 7;
					
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
	
	//Hurtbox
	if (run)
		{
		hurtbox_anim_match();
		}
}
/* Copyright 2023 Springroll Games / Yosi */