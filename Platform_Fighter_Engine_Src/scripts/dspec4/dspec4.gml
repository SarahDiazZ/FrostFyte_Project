function dspec4() {
	//Down Special
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Speeds
	if (on_ground())
		{
		friction_gravity(slide_friction, 0.3, 4);
		}
	else
		{
		friction_gravity(air_friction, 0.3, 4);
		aerial_drift();
		}
	var _on_ground = on_ground();
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				if (_on_ground)
					{
					anim_sprite = spr_dspec4;
					}
				else
					{
					anim_sprite = spr_dspec4_air;
					}
				anim_frame = 0;
				anim_speed = 0;
					
				attack_frame = 9;
				
				//EX
				ex_move_reset();
				return;
				}
			//Startup -> Active
			case 0:
				{
				//EX
				ex_move_allow(1);
				
				//Animation
				if (attack_frame == 5)
					anim_frame = 1;
				
				//B Reverse
				if (attack_frame == 4)
					{
					b_reverse();
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
				
					attack_phase++;
					attack_frame = 16;
				
					game_sound_play(snd_dspec4_spawn);
				
					var _entity;
					//Grounded placement
					if (_on_ground)
						{
						_entity = entity_create(x + (48 * facing), y - 16, obj_dspec4_gaze);
						}
					//Aerial placement
					else
						{
						speed_set(0, -4, true, false);
						_entity = entity_create(x, y + 32, obj_dspec4_gaze);
						}
					//EX modifier
					if (ex_move_is_activated())
						{
						_entity.custom_entity_struct.frame = 1;
						}
					else
						{
						attack_cooldown_set(164);
						}
					}
				break;
				}
			//Finish
			case 1:
				{
				//Animation
				if (attack_frame == 14)
					anim_frame = 3;
				if (attack_frame == 10)
					anim_frame = 4;
				if (attack_frame == 7)
					anim_frame = 5;
				if (attack_frame == 3)
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