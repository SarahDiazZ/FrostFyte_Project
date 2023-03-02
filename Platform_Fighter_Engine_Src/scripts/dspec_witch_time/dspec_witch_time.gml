function dspec_witch_time() {
	//Counter
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Timer
				attack_frame = max(--attack_frame, 0);
			
				//Animation
				anim_sprite = spr_dspec_counter;
				anim_frame = 0;
				anim_speed = 0;
				
				attack_frame = 8;
				break;
				}
			//Startup
			case 0:
				{
				//Timer
				attack_frame = max(--attack_frame, 0);
			
				//Speeds
				if (on_ground())
					{
					friction_gravity(ground_friction);
					}
				else
					{
					friction_gravity(ground_friction);
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 1;
				
					attack_phase++;
					attack_frame = 20;
					invulnerability_set(INV.counter, 20);
					speed_set(-1 * facing, 1, false, false);
					}
				
				//Movement
				move();
				break;
				}
			//Check for attacks
			case 1:
				{
				//Timer
				attack_frame = max(--attack_frame, 0);
			
				//Speeds
				if (on_ground())
					{
					friction_gravity(ground_friction, grav, 2);
					}
				else
					{
					friction_gravity(air_friction, grav, 2);
					speed_set(0, 1, true, false);
					}
			
				//Animation
				if (attack_frame == 10)
					anim_frame = 2;
		
				if (attack_frame == 0)
					{
					anim_frame = 3;
				
					attack_phase++;
					attack_frame = 30;
					}
				
				//Movement
				move();
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 18)
					anim_frame = 4;
					
				//Timer
				attack_frame = max(--attack_frame, 0);
			
				//Speeds
				if (on_ground())
					{
					friction_gravity(ground_friction, grav, max_fall_speed);
					}
				else
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					}
					
				if (attack_frame == 0)
					{
					attack_stop();
					}
				
				//Movement
				move();
				break;
				}
			//Counter activate
			case PHASE.counter:
				{
				//Assign the Witch Time scripts
				var _attacking_hitbox = argument[1];
				with(_attacking_hitbox.player_id)
					{
					callback_add(callback_draw_begin, witch_time_draw_begin, CALLBACK_TYPE.permanent, id, false);
					callback_add(callback_passive, witch_time_passive, CALLBACK_TYPE.permanent, id, false);
					custom_passive_struct.witch_time_frame = 240;
					custom_passive_struct.witch_time_x = x;
					custom_passive_struct.witch_time_y = y;
					}
				
				//VFX
				vfx_create(spr_hit_counter, 1, 0, 36, x, y, 2, 0, "VFX_Layer");
				break;
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */