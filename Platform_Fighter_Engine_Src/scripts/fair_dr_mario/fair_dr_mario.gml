function fair_dr_mario() {
	//Forward Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Actions
	friction_gravity(air_friction, grav, max_fall_speed);
	fastfall_attack_try();
	allow_hitfall();
	aerial_drift();
	//Cancels
	if (run && cancel_ground_check()) then run = false;
	//Main Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				anim_sprite = spr_fair_dr_mario;
				anim_frame = 0;
				anim_speed = 0;
				landing_lag = 17;
				speed_set(0, -1, true, true);
				attack_frame = 16;
				return;
				}
			//Active
			case 0:
				{
				//Animation
				if (attack_frame == 10)
					anim_frame = 1;
				if (attack_frame == 6)
					anim_frame = 2;
  
				//Hitboxes
				if (attack_frame == 0)
					{
					anim_frame = 4;
					var _hitbox = hitbox_create_melee(34, 16, 0.6, 0.5, 17, 5, 1.3, 18, 45, 5, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.shieldstun_scaling = 0.6;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
				
					var _hitbox = hitbox_create_melee(32, -4, 0.7, 0.9, 12, 5, 1.3, 18, 45, 5, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.shieldstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					
					hurtbox_create(34, 16, 0.5, 0.4, 5, SHAPE.circle, INV.normal);
					hurtbox_create(32, -4, 0.6, 0.8, 5, SHAPE.circle, INV.normal);
					//Next phase
					attack_phase++;
					attack_frame = 10;
					}
				break;
				}
			//Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 7)
					anim_frame = 5;
	
				if (attack_frame == 0)
					{
					//Whiff lag
					attack_phase++;
					attack_frame = attack_connected() ? 15 : 28;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 20)
					anim_frame = 6;
				if (attack_frame == 12)
					{
					anim_frame = 7;	
					//Autocancel
					landing_lag = 4;
					}
				
				if (attack_frame == 0)
					{
					//Revert back to the original state
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