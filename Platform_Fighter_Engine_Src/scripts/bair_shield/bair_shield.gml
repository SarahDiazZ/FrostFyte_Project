function bair_shield() {
	//Backward Aerial
	/*
	- Attack behind with a shield
	- The shield has a small hurtbox that blocks attacks
	*/
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
				anim_sprite = spr_bair_shield;
				anim_speed = 0;
				anim_frame = 0;
				landing_lag = 8;
				speed_set(0, -1, true, true);
				attack_frame = 13;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 10)
					anim_frame = 1;
				if (attack_frame == 6)
					anim_frame = 2;
				if (attack_frame == 3)
					anim_frame = 3;
					
				if (attack_frame == 0)
					{
					anim_frame = 4;
					speed_set(-2 * facing, 0, true, true);
					
					//Initial hit
					var _hitbox = hitbox_create_melee(-44, 0, 0.45, 0.85, 18, 6, 0.9, 10, 148, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.electric, HIT_VFX.lines];
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					
					//Shield hurtbox + Reflector hurtbox
					var _hurtbox = hurtbox_create(-44, 0, 0.7, 1.2, 16, SHAPE.circle, INV.reflector);
					_hurtbox.check_first = false;
					var _hurtbox = hurtbox_create(-44, 0, 0.6, 1.1, 16, SHAPE.circle, INV.deactivate);
					_hurtbox.check_first = false;
					
					attack_frame = 15;
					attack_phase = 1;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 6;
				if (attack_frame == 10)
					anim_frame = 7;
				if (attack_frame == 7)
					anim_frame = 8;
				if (attack_frame == 4)
					anim_frame = 9;
				
				//Weaker hit
				if (attack_frame == 14)
					{
					anim_frame = 5;
					var _hitbox = hitbox_create_melee(-44, 0, 0.3, 0.7, 6, 7.5, 0.25, 4, 105, 15, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_weak2;
					}
					
				if (attack_frame == 0)
					{
					//Autocancel
					landing_lag = 3;
					attack_phase++;
					attack_frame = attack_connected() ? 5 : 15;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 13)
					anim_frame = 10;
				if (attack_frame == 8)
					anim_frame = 11;
				if (attack_frame == 4)
					anim_frame = 12;
				
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