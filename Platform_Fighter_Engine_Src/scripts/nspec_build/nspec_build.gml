function nspec_build() {
	//Neutral Special
	/*
	- Builds a solid block under you, snapped to the grid
	- Players are pushed upwards out of the block
	- Taking damage causes the block to disappear faster
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	
	//Timer
	attack_frame = max(--attack_frame, 0);
	if (on_ground())
		{
		friction_gravity(ground_friction);
		}
	else
		{
		friction_gravity(air_friction, grav, max_fall_speed);
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
				anim_sprite = spr_dspec_shine;
				anim_frame = 0;
				anim_speed = 0;
			
				attack_frame = 4;
			
				reverse_b();
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 2)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					b_reverse();

					anim_frame = 2;
				
					attack_phase++;
					attack_frame = 11;
				
					//Create the block entity
					var _x = 32 + (x div 64) * 64;
					var _y = 32 + (((bbox_bottom - 1) + 31) div 64) * 64;
					if (!position_meeting(_x, _y, obj_block) && !position_meeting(_x, _y, obj_nspec_build))
						{
						with(entity_create(_x, _y, obj_nspec_build))
							{
							//This entity can be hit by any player
							player_team = -1;
							}
						}
					}
				break;
				}
			//Active -> Finish
			case 1:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 3;

				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			}
		}
	//Movement
	if (on_ground())
		{
		move_grounded();
		}
	else
		{
		move();
		}
}
/* Copyright 2023 Springroll Games / Yosi */