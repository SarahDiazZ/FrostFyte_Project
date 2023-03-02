function grab3() {
	//Normal Grab for character3
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(slide_friction, grav, max_fall_speed);
	
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
				anim_sprite = spr_grab3;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 5;
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame = 2)
					{
					//Turnaround
					change_facing();
					anim_frame = 1;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 41;
					
					var _hitbox = hitbox_create_grab(40, 0, 1, 0.6, 55, 0, 4, SHAPE.square);
					_hitbox.hit_restriction = HIT_RESTRICTION.not_ledge;
					
					//Reset attack inputs to avoid accidental pummels
					input_reset(INPUT.grab);
					}
				break;
				}
			//Active -> Finish
			case 1:
				{
				//Animation
				if (attack_frame == 32)
					anim_frame = 3;
				if (attack_frame == 22)
					anim_frame = 4;
				if (attack_frame == 11)
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