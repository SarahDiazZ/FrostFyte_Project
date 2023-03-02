function grab_tether() {
	//Tether Grab
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
				anim_sprite = spr_grab_tether;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 11;
				return;
				}
			//Startup
			case 0:
				{
				if (attack_frame == 8)
					{
					//Turnaround
					change_facing();
					}
					
				if (attack_frame == 5)
					anim_frame = 1;
					
				//First grab hitbox
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 8;
					var _hitbox = hitbox_create_grab(34, 2, 0.8, 0.3, 40, 0, 3, SHAPE.square);
					_hitbox.hit_restriction = HIT_RESTRICTION.not_ledge;
					}
				break;
				}
			//Active
			case 1:
				{
				//Second & longer grab hitbox
				if (attack_frame == 7)
					{
					anim_frame = 3;
					var _hitbox = hitbox_create_grab(65, -2, 0.6, 0.1, 40, 0, 7, SHAPE.square);
					_hitbox.hit_restriction = HIT_RESTRICTION.not_ledge;
					}
					
				if (attack_frame == 3)
					anim_frame = 4;
					
				if (attack_frame == 0)
					{
					anim_frame = 5;
			
					attack_phase++;
					attack_frame = 31;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 20)
					anim_frame = 6;
				if (attack_frame == 10)
					anim_frame = 7;
			
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