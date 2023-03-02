function bair_forsburn() {
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
				anim_sprite = spr_bair_forsburn;
				anim_speed = 0;
				anim_frame = 0;
				landing_lag = 6;
				speed_set(0, -1, true, true);
				attack_frame = 13;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 7)
					anim_frame = 1;
					
				if (attack_frame == 0)
					{
					anim_frame = 2;
					attack_phase++;
					attack_frame = 14;
					var _hitbox = hitbox_create_melee(-34, 10, 0.5, 0.4, 13, 8, 1, 8, 135, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong2;
					var _hitbox = hitbox_create_melee(-54, 6, 0.75, 0.5, 4, 6, 0.6, 5, 135, 4, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 10)
					anim_frame = 3;
				if (attack_frame == 5)
					anim_frame = 4;
					
				if (attack_frame == 0)
					{
					anim_frame = 5;
					landing_lag = 3;
					attack_phase++;
					attack_frame = attack_connected() ? 4 : 8;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame <= 4)
					anim_frame = 6;
					
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