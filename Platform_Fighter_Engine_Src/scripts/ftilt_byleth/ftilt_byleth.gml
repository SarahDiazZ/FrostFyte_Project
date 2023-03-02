function ftilt_byleth() {
	//Forward Tilt
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(ground_friction, grav, max_fall_speed);
	//Canceling
	if (run && cancel_air_check()) then run = false;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_ftilt_byleth;
				anim_speed = 0; 
				anim_frame = 0;
		
				attack_frame = 7;
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame == 0)
					{
					anim_frame = 1;
					attack_phase++;
					attack_frame = 6;
					speed_set(3 * facing, 0, true, true);
					var _hitbox = hitbox_create_melee(35, 2, 1.1, 0.6, 6, 8, 0.9, 4, 45, 4, SHAPE.circle, 0, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
					attack_phase++;
					attack_frame = 20;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 4;
			
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();


}

/* Copyright 2023 Springroll Games / Yosi */