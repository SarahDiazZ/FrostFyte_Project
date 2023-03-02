function fspec1() {
	//Forward Special
	/*
	- Can only be used once before touching the ground again
	- Tilt the stick in a direction to have the turret move
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);

	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_fspec1;
				anim_speed = 0.3;
				anim_frame = 0;
			
				attack_frame = anim_calculate_length(anim_sprite, anim_speed);
				
				//EX
				ex_move_reset();
				return;
				}
			//Startup
			case 0:
				{
				//EX
				ex_move_allow(1);
				
				//Speeds
				if (anim_frame >= 3)
					{
					speed_set(0, 0, false, false);
					}
				else
					{
					if (!on_ground())
						{
						friction_gravity(air_friction, grav, max_fall_speed);
						aerial_drift();
						}
					else
						{
						friction_gravity(ground_friction, grav, max_fall_speed);
						}
					}
					
				//Creating the entity
				if (anim_frame == 6)
					{
					var _entity = entity_create(x + (70 * facing), y - 1, obj_fspec1_turret);
					_entity.facing = facing;
					_entity.image_xscale = facing * 2;
					_entity.image_yscale = 2;
					_entity.custom_entity_struct.timer = (input_held(INPUT.special) ? 90 : 20);
					_entity.hsp = (stick_tilted(Lstick, DIR.horizontal, 0) ? sign(stick_get_value(Lstick, DIR.horizontal, 0)) * 2 : 0);
					_entity.vsp = (stick_tilted(Lstick, DIR.vertical, 0) ? sign(stick_get_value(Lstick, DIR.vertical, 0)) * 2 : 0);
					_entity.custom_entity_struct.mode = (input_held(INPUT.special) ? 1 : 0);
					_entity.custom_entity_struct.count = 1;
					
					//EX version
					if (ex_move_is_activated())
						{
						_entity.custom_entity_struct.mode = 2;
						_entity.custom_entity_struct.timer = 1;
						_entity.custom_entity_struct.phase = 1;
						_entity.custom_entity_struct.count = 3;
						}
					
					//Move the turret out of blocks backwards
					with(_entity)
						{
						move_out_of_blocks(other.facing == 1 ? 180 : 0);
						}
					
					attack_cooldown_set(120);
					
					attack_phase = 1;
					}
				break;
				}
			//Endalg
			case 1:
				{
				//Speeds
				speed_set(0, 0, false, false);
				
				if (attack_frame <= 0)
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