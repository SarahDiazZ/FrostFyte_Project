function ftilt4() {
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
				anim_sprite = spr_ftilt4;
				anim_speed = 0; 
				anim_frame = 0;
		
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
					attack_frame = 7;
					var _hitbox = hitbox_create_melee(40, 10, 1.3, 0.5, 6, 8, 0.6, 4, 35, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hitstun_scaling = 0.5;
					_hitbox.shieldstun_scaling = 0.3;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 3;
				
				if (attack_frame == 0)
					{
					anim_frame = 4;
					attack_phase++;
					attack_frame = 15;
					
					//Whiff lag
					attack_frame = attack_connected() ? 7 :  17;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 5;
				if (attack_frame == 7)
					anim_frame = 6;
			
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