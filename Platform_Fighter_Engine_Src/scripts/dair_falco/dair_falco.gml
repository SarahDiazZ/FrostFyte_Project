function dair_falco() {
	//Downward Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
	fastfall_try();
	aerial_drift();
	allow_hitfall();
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
				anim_sprite = spr_dair_falco;
				anim_speed = 0;
				anim_frame = 0;
				
				landing_lag = 18;
				speed_set(0, -1, true, true);
				attack_frame = 6;
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
					attack_frame = 20;
					var _hitbox = hitbox_create_melee(10, 26, 0.4, 0.4, 8, 5, 1.3, 10, 290, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.shine];
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hitstun_scaling = 1.1;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 19)
					anim_frame = 3;
				if (attack_frame == 17)
					anim_frame = 4;
				if (attack_frame == 16)
					anim_frame = 5;
				if (attack_frame == 14)
					anim_frame = 6;
				if (attack_frame == 13)
					anim_frame = 7;
				if (attack_frame == 11)
					anim_frame = 8;
				if (attack_frame == 10)
					anim_frame = 9;
				if (attack_frame == 9)
					anim_frame = 3;
				if (attack_frame == 7)
					anim_frame = 4;
				if (attack_frame == 6)
					anim_frame = 5;
				if (attack_frame == 5)
					anim_frame = 6;
				if (attack_frame == 3)
					anim_frame = 7;
				if (attack_frame == 2)
					anim_frame = 8;
				if (attack_frame == 1)
					anim_frame = 9;
				
				if (attack_frame == 18)
					{
					var _hitbox = hitbox_create_melee(10, 26, 0.4, 0.4, 4, 5, 0.9, 4, 290, 18, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hitstun_scaling = 1.1;
					_hitbox.hit_sfx = snd_hit_weak;
					}
				
				if (attack_frame == 0)
					{
					//Autocancel
					landing_lag = 9;
					attack_phase++;
					attack_frame = attack_connected() ? 15 : 20;
					}
					
				//Reduce landing lag on hit
				if (attack_connected())
					{
					landing_lag = 4;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Reduce landing lag on hit
				if (attack_connected())
					{
					landing_lag = 4;
					}
					
				//Animation
				if (attack_frame <= 17)
					anim_frame = 1;
				if (attack_frame <= 7)
					anim_frame = 0;
				
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