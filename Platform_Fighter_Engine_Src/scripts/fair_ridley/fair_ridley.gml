function fair_ridley() {
	//Forward Aerial
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
				anim_sprite = spr_fair_ridley;
				anim_speed = 0;
				anim_frame = 0;
			
				landing_lag = 12;
				speed_set(0, -1, true, true);
				attack_frame = 10;
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame == 7)
					anim_frame = 1;
				if (attack_frame == 3)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
				
					attack_phase++;
					attack_frame = 10;
					var _hitbox = hitbox_create_melee(68, 0, 0.2, 0.2, 4, 2, 0, 8, 25, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hitstun_scaling = 10;
					_hitbox.hitlag_scaling = 0;
					_hitbox.techable = false;
					_hitbox.background_clear_allow = false;
					_hitbox.can_lock = true;
					var _hitbox = hitbox_create_melee(32, 0, 1.1, 0.2, 3, 2, 0, 3, 25, 2, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak;
					_hitbox.hitstun_scaling = 10;
					_hitbox.hitlag_scaling = 0;
					_hitbox.techable = false;
					_hitbox.background_clear_allow = false;
					_hitbox.can_lock = true;
					
					//Shine VFX
					vfx_create(spr_shine_attack, 1, 0, 8, x + (68 * facing), y, 1, 45);
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				if (attack_frame == 9)
					{
					if (attack_connected()) then speed_set(0, -1, true, false);
					anim_frame = 4;
					}
				
				if (attack_frame == 8)
					{
					anim_frame = 5;
					var _hitbox = hitbox_create_melee(68, 10, 0.2, 0.2, 5, 3, 0, 8, 80, 2, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hitstun_scaling = 10;
					_hitbox.hitlag_scaling = 0;
					_hitbox.techable = false;
					_hitbox.background_clear_allow = false;
					_hitbox.can_lock = true;
					var _hitbox = hitbox_create_melee(32, 8, 1.1, 0.4, 3, 3, 0, 3, 80, 2, SHAPE.square, 1);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak;
					_hitbox.hitstun_scaling = 10;
					_hitbox.hitlag_scaling = 0;
					_hitbox.techable = false;
					_hitbox.background_clear_allow = false;
					_hitbox.can_lock = true;
					
					//Shine VFX
					vfx_create(spr_shine_attack, 1, 0, 8, x + (68 * facing), y + 10, 1, 0);
					}
				
				if (attack_frame == 6)
					{
					if (attack_connected()) then speed_set(0, -1, true, false);
					anim_frame = 6;
					}
				
				if (attack_frame == 4)
					{
					anim_frame = 7;
					var _hitbox = hitbox_create_melee(68, -14, 0.2, 0.2, 6, 8, 0.9, 10, 45, 3, SHAPE.circle, 2);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_strong2;
					var _hitbox = hitbox_create_melee(32, -8, 1.1, 0.6, 5, 8, 0.8, 10, 45, 3, SHAPE.square, 2);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					
					//Shine VFX
					vfx_create(spr_shine_attack, 1, 0, 8, x + (68 * facing), y - 14, 1, 125);
					}
				
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = attack_connected() ? 10 : 20;
					}
				break;
				}
			//Finish
			case 2:
				{
				if (attack_frame <= 14)
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