function nair1() {
	//Neutral Aerial
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
				anim_sprite = spr_nair1;
				anim_speed = 0;
				anim_frame = 0;
		
				landing_lag = 12;
				speed_set(0, -1, true, true);
				attack_frame = 10;
				return;
				}
			//First Hit
			case 0:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 20;
					var _hitbox = hitbox_create_melee(20, 19, 1.1, 0.9, 7, 6, 0.4, 8, 45, 4, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					var _hitbox = hitbox_create_melee(33, 23, 1.1, 0.9, 7, 6, 0.4, 9, 45, 4, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_electro;
					_hitbox.hit_vfx_style = HIT_VFX.electric_weak;
					_hitbox.extra_hitlag = 20;
					}
				break;
				}
			//Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 18)
					anim_frame = 3;
				if (attack_frame == 16)
					anim_frame = 4;
				if (attack_frame == 9)
					anim_frame = 5;
				if (attack_frame == 5)
					anim_frame = 6;
				
				//Reduce landing lag on hit
				if (attack_connected())
					{
					landing_lag = 5;
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