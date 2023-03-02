function fair_mario() {
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
				anim_sprite = spr_fair_mario;
				anim_frame = 0;
				anim_speed = 0;
				landing_lag = 10;
				speed_set(0, -1, true, true);
				attack_frame = 14;
				
				//Shine VFX
				vfx_create(spr_shine_attack, 1, 0, 8, x + (-32 * facing), y, 1, 45);
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 9)
					anim_frame = 1;
				if (attack_frame == 4)
					anim_frame = 2;
				if (attack_frame = 2)
					anim_frame = 3;
  
				//Strong hitbox
				if (attack_frame == 0)
					{
					anim_frame = 4;
					
					//Spike sweetspot (grounded)
					var _hitbox1 = hitbox_create_melee(26, 16, 0.8, 0.5, 13, 7.5, 0.8, 6, 280, 2, SHAPE.circle, 0);
					_hitbox1.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox1.hit_sfx = snd_hit_strong;
					_hitbox1.shieldstun_scaling = 0.5;
					_hitbox1.hit_restriction = HIT_RESTRICTION.grounded_only;
					_hitbox1.techable = false;
					var _hurtbox1 = hurtbox_create(0, 0, 0, 0, 0, SHAPE.circle, INV.normal);
					hurtbox_copy_hitbox(_hurtbox1, _hitbox1);
					
					//Spike sweetspot (aerial)
					var _hitbox2 = hitbox_create_melee(26, 16, 0.8, 0.5, 13, 7.5, 0.8, 6, 300, 2, SHAPE.circle, 0);
					_hitbox2.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox2.hit_sfx = snd_hit_strong;
					_hitbox2.shieldstun_scaling = 0.5;
					_hitbox2.knockback_state = PLAYER_STATE.balloon;
					_hitbox2.hit_restriction = HIT_RESTRICTION.aerial_only;
					
					//Sourspot
					var _hurtbox2 = hurtbox_create(26, -8, 0.8, 0.9, 2, SHAPE.circle, INV.normal);
					var _hitbox3 = hitbox_create_melee(0, 0, 0, 0, 10, 10, 0.35, 5, 45, 0, SHAPE.circle, 0);
					hitbox_copy_hurtbox(_hitbox3, _hurtbox2);
					_hitbox3.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox3.shieldstun_scaling = 0.5;
					_hitbox3.hitstun_scaling = 0.4;
					
					//Next phase
					attack_phase++;
					attack_frame = 10;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 5;
				if (attack_frame == 6)
					anim_frame = 6;
				if (attack_frame == 4)
					anim_frame = 7;
	
				if (attack_frame == 0)
					{
					anim_frame = 8;
					
					//Whiff lag
					attack_phase++;
					attack_frame = attack_connected() ? 15 : 24;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (!attack_connected())
					{
					if (attack_frame == 20)
						anim_frame = 9;
					if (attack_frame == 16)
						anim_frame = 10;	
					if (attack_frame == 12)
						anim_frame = 11;
					if (attack_frame == 7)
						anim_frame = 12;	
					if (attack_frame == 3)
						anim_frame = 13;	
					}
				else
					{
					if (attack_frame == 10)
						anim_frame = 12;
					if (attack_frame == 5)
						anim_frame = 13;
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