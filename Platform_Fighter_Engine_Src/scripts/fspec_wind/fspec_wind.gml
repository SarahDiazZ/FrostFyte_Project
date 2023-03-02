function fspec_wind() {
	//Forward Special
	/*
	- Halts momentum and creates a windbox
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);

	if (on_ground())
		{
		friction_gravity(ground_friction, grav, max_fall_speed);
		}
	else
		{
		friction_gravity(air_friction, grav, max_fall_speed);
		fastfall_attack_try();
		aerial_drift();
		}

	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_fspec_wind;
				anim_speed = 0;
				anim_frame = 0;
			
				speed_set(0, -1, true, true);
				attack_frame = 17;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 9)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
					attack_phase++;
					attack_frame = 20;
					
					if (!on_ground())
						{
						speed_set(0, -3, false, false);
						}
						
					hitbox_create_windbox(84, -2, 1.7, 0.7, 0, 8, 20, 10, SHAPE.circle, 0, FLIPPER.standard, true, true, false, 10, false);
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 17)
					anim_frame = 3;
				if (attack_frame == 15)
					anim_frame = 4;
				if (attack_frame == 10)
					anim_frame = 5;
				if (attack_frame == 5)
					anim_frame = 6;
				
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			}
		}
	//Movement
	move();
}

/* Copyright 2023 Springroll Games / Yosi */