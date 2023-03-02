function nair4() {
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
				anim_sprite = spr_nair4;
				anim_speed = 0;
				anim_frame = 0;
				
				landing_lag = 10;
				
				attack_frame = 11;
				speed_set(0, -1, true, true);
				return;
				}
			//Startup -> First hit
			case 0:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 1;
				if (attack_frame == 4)
					anim_frame = 2;
					
				if (attack_frame == 0)
					{
					anim_frame = 3;
			
					attack_phase++;
					attack_frame = 26;
					
					camera_shake(2);
					
					var _hitbox = hitbox_create_melee(0, 0, 1.2, 1.2, 8, 11, 0.35, 8, 65, 1, SHAPE.circle, 0, FLIPPER.from_hitbox_center_horizontal);
					_hitbox.custom_hitstun = 45;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 25)
					{
					anim_frame = 4;
					
					var _hitbox = hitbox_create_melee(0, 0, 1.4, 1.4, 4, 9, 0.3, 5, 70, 7, SHAPE.circle, 0, FLIPPER.from_hitbox_center_horizontal);
					_hitbox.custom_hitstun = 42;
					_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
					_hitbox.hit_sfx = snd_hit_weak;
					_hitbox.can_lock = true;
					}
					
				//Animation
				if (attack_frame == 22)
					anim_frame = 5;
				if (attack_frame == 18)
					anim_frame = 6;
				if (attack_frame == 9)
					anim_frame = 7;
					
				//Reduce landing lag on hit
				if (attack_connected())
					{
					landing_lag = 3;
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