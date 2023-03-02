function nspec_shot_put() {
	//Neutral Special
	/*
	- Tilt the left stick to change the trajectory
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Actions / Cancels
	if (on_ground())
		{
		friction_gravity(ground_friction, grav, max_fall_speed);
		}
	else
		{
		aerial_drift();
		friction_gravity(air_friction, grav, max_fall_speed);
		}
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_nspec_shot_put;
				anim_frame = 0;
				anim_speed = 0;
		
				attack_frame = 20;
				return;
				}
			//Startup -> Throw
			case 0:
				{
				//Animation
				if (attack_frame == 17)
					anim_frame = 1;
				if (attack_frame == 14)
					anim_frame = 2;
				if (attack_frame == 11)
					anim_frame = 3;
				if (attack_frame == 8)
					anim_frame = 4;
				if (attack_frame == 4)
					anim_frame = 5;
				
				if (attack_frame == 0)
					{
					var _len = 11;
					var _dir = 60;
					if (facing == 1)
						{
						_dir += ((stick_get_value(Lstick, DIR.horizontal)) *-20);
						}
					else
						{
						_dir += ((stick_get_value(Lstick, DIR.horizontal)) * 20);
						}
					var proj = hitbox_create_projectile_custom(obj_nspec_shot_put_projectile, 30, -22, 0.4, 0.4, 5, 10, 0.2, 80, 120, SHAPE.circle, lengthdir_x(_len, _dir), lengthdir_y(_len, _dir));
					proj.grav = 0.5;
					proj.base_hitlag = 50;
					proj.vbounce = true;
					proj.bounce_multiplier = 0.6;
					proj.destroy_on_blocks = true;
					attack_phase++;
					attack_frame = 16;
					}
				break;
				}
			//Throw -> Finish
			case 1:
				{
				//Animation
				if (attack_frame > 8)
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