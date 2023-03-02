function bair4() {
	//Backward Aerial
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
				anim_sprite = spr_bair4;
				anim_speed = 0;
				anim_frame = 0;
			
				landing_lag = 10;
				attack_frame = 7;
				speed_set(0, -1, true, true);
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
					attack_frame = 3;

					var _hitbox = hitbox_create_melee(-24, -2, 1, 1, 5, 6, 0.7, 4, 120, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_medium, HIT_VFX.normal_strong];
					_hitbox.hit_sfx = snd_hit_strong2;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_connected()) then landing_lag = 4;
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
					attack_phase++;
					attack_frame = attack_connected() ? 15 : 23;
					}
				break;
				}
			//Finish
			case 2:
				{
				if (attack_frame == 20)
					anim_frame = 4;
				if (attack_frame == 15)
					anim_frame = 5;
				if (attack_frame == 10)
					anim_frame = 6;
				if (attack_frame = 8)
					{
					anim_frame = 7;
					landing_lag = 4;
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