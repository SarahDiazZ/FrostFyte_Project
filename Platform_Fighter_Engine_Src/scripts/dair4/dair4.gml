function dair4() {
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
				anim_sprite = spr_dair4;
				anim_speed = 0;
				anim_frame = 0;
				
				landing_lag = 18;
				attack_frame = 7;
				speed_set(0, -1, true, true);
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
					attack_phase++;
					attack_frame = 13;
					
					var _hitbox = hitbox_create_melee(2, 38, 0.8, 0.4, 8, 6.5, 0.5, 8, 290, 1, SHAPE.circle, 0, FLIPPER.from_hitbox_center_horizontal);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.shine];
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.hitstun_scaling = 0.65;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 12)
					{
					anim_frame = 3;
					
					var _hitbox = hitbox_create_melee(3, 30, 1.2, 0.7, 5, 6, 0.4, 6, 320, 4, SHAPE.circle, 0, FLIPPER.from_hitbox_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hitstun_scaling = 0.45;
					_hitbox.hit_sfx = snd_hit_weak;
					}
					
				//Animation
				if (attack_frame == 8)
					anim_frame = 4;
				if (attack_frame == 4)
					anim_frame = 5;
				
				//Reduce landing lag on hit
				if (attack_connected())
					{
					landing_lag = 6;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 6;
					
					//Autocancel
					landing_lag = min(landing_lag, 9);
					attack_phase++;
					attack_frame = attack_connected() ? 6 : 15;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame <= 8)
					anim_frame = 7;
				
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