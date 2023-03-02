function fair_clairen() {
	//Forward Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Speeds
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
				anim_sprite = spr_fair_clairen;
				anim_speed = 0;
				anim_frame = 0;
			
				landing_lag = 12;
				speed_set(0, -1, true, true);
				attack_frame = 6;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 1;
				if (attack_frame == 2)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
				
					attack_phase++;
					attack_frame = 10;
					
					//Normal
					var _hitbox = hitbox_create_melee(34, 8, 1.0, 0.7, 3, 5, 0.2, 3, 70, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak;
					_hitbox.background_clear_allow = false;
					
					//Tipper
					var _hitbox = hitbox_create_melee(54, 2, 0.9, 0.6, 7, 5, 1, 5, 40, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_medium, HIT_VFX.electric_weak];
					_hitbox.hit_sfx = snd_hit_electro;
					_hitbox.extra_hitlag = 15;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 9)
					anim_frame = 4;
				if (attack_frame == 8)
					anim_frame = 5;
				if (attack_frame == 6)
					anim_frame = 6;
				if (attack_frame == 4)
					anim_frame = 7;
				if (attack_frame == 3)
					anim_frame = 8;
				if (attack_frame == 1)
					anim_frame = 10;
				
				if (attack_frame == 2)
					{
					anim_frame = 9;
					
					//Normal
					var _hitbox = hitbox_create_melee(32, 4, 0.9, 0.9, 4, 5, 0.7, 8, 45, 2, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					
					//Tipper
					var _hitbox = hitbox_create_melee(50, 0, 0.9, 0.7, 7, 5, 1.2, 8, 40, 2, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_medium, HIT_VFX.electric_weak];
					_hitbox.hit_sfx = snd_hit_electro;
					_hitbox.extra_hitlag = 15;
					}
					
				//Reduce landing lag on hit
				if (attack_connected())
					{
					landing_lag = 8;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 11;
					attack_phase++;
					attack_frame = attack_connected() ? 14 : 21;
					}
				break;
				}
			//Finish
			case 2:
				{
				if (attack_frame <= 14)
					anim_frame = 12;
				if (attack_frame == 7)
					anim_frame = 13;
			
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