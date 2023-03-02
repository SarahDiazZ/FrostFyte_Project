function uair_bowser_jr() {
	//Up Aerial
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
				anim_sprite = spr_uair_bowser_jr;
				anim_speed = 0;
				anim_frame = 0;
				landing_lag = 5;
				speed_set(0, -1, true, true);
				attack_frame = 7;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 1;
					
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 2;
					var _hitbox = hitbox_create_melee(0, -10, 0.8, 0.7, 8, 9, 0.2, 4, 110, 2, SHAPE.circle, 0);
					_hitbox.extra_hitlag = 2;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 3;
			
					attack_phase++;
					attack_frame = attack_connected() ? 4 : 16;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 11)
					anim_frame = 4;
				if (attack_frame == 3)
					anim_frame = 5;
				
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