function grab0() {
	//Grab for character0
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
				anim_sprite = spr_grab0;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 6;
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame = 3)
					{
					//Turnaround
					change_facing();
					anim_frame = 1;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 40;
					var _hitbox = hitbox_create_grab(20, 4, 0.6, 0.6, 35, 0, 3, SHAPE.square);
					_hitbox.hit_restriction = HIT_RESTRICTION.not_ledge;
					}
				break;
				}
			//Active -> Finish
			case 1:
				{
				//Animation
				if (attack_frame == 30)
					anim_frame = 3;
				if (attack_frame == 20)
					anim_frame = 4;
				if (attack_frame == 10)
					anim_frame = 5;
			
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