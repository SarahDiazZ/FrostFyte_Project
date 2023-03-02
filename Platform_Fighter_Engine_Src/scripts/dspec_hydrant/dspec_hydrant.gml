function dspec_hydrant() {
	//Down Special
	/*
	- Drops a fire hydrant object
	- The hydrant periodically shoots out water
	- Once the hydrant takes enough damage, it will be launched with an active hitbox for the last player who hit it
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
				anim_sprite = spr_dspec_shine;
				anim_frame = 0;
				anim_speed = 0;
			
				attack_frame = 6;
				return;
				}
			//Create hydrant
			case 0:
				{
				//Animation
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 2;
				
					attack_phase++;
					attack_frame = 35;
					if (on_ground())
						{
						speed_set(0, -7, false, false);
						}
					else
						{
						speed_set(0, -4, true, false);
						}
					
					//Create the hydrant, but only if there isn't a user-owned hydrant in play currently
					var _existing = false;
					with(obj_dspec_hydrant)
						{
						if (owner == other.id)
							{
							_existing = true;
							break;
							}
						}
					if (!_existing)
						{
						var _hydrant = entity_create(x, y, obj_dspec_hydrant);
						//Fill the hydrant's hitbox groups with the player's ID so the player cannot be hit
						with(_hydrant)
							{
							facing = other.facing;
							custom_entity_struct.palette_base = other.palette_base;
							custom_entity_struct.palette_swap = other.palette_swap;
							custom_entity_struct.player_color = other.player_color;
							hitbox_group_whitelist_id(other.id, 0);
							hitbox_group_whitelist_id(other.id, 2);
							//This entity can be hit by any player
							player_team = -1;
							}
						}
					}
				break;
				}
			//Finish
			case 1:
				{
				//Animation
				if (attack_frame == 20)
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
	move();
}
/* Copyright 2023 Springroll Games / Yosi */