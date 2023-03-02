function fspec_cloudburst() {
	//Forward Special
	/*
	- Fires a controllable cloud
	- Hold the button to keep controlling the cloud
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	if (on_ground())
		friction_gravity(ground_friction, grav, max_fall_speed);
	else
		friction_gravity(air_friction, grav, max_fall_speed);
	
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_dspec_shine;
				anim_speed = 0;
				anim_frame = 0;

				attack_frame = 10;
				
				custom_ids_struct.cloud = noone;
				return;
				}
			//Startup -> Shoot
			case 0:
				{
				//Animation
				if (attack_frame == 5)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
				
					attack_phase++;
					attack_frame=10;
					var _cloud = entity_create(x + (25 * facing), y, obj_fspec_cloudburst, "Player_Front");
					_cloud.hsp = 15 * facing;
					_cloud.vsp = 0;
					custom_ids_struct.cloud = _cloud;
					}
				break;
				}
			//Endlag -> Finish
			case 1:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 3;
				
				if (instance_exists(custom_ids_struct.cloud))
					{
					//Curve
					if (stick_tilted(Lstick))
						{
						var _cloud = custom_ids_struct.cloud;
						var _newdir = stick_get_direction(Lstick);
						var _olddir = point_direction(0, 0, _cloud.hsp, _cloud.vsp);
						var _dir = _olddir - clamp(angle_difference(_olddir, _newdir), -4, 4);
						_cloud.hsp = lengthdir_x(15, _dir);
						_cloud.vsp = lengthdir_y(15, _dir);
						}
						
					//You can extend the attack by holding the button
					//If the cloud is already placed, the attack is canceled
					if ((attack_frame <= 0 && !input_held(INPUT.special, 1)) || custom_ids_struct.cloud.custom_entity_struct.mode != 0)
						{
						custom_ids_struct.cloud.custom_entity_struct.mode = 1;
						custom_ids_struct.cloud.custom_entity_struct.lifetime = 120;
						attack_cooldown_set(60);
						attack_stop();
						break;
						}
					}
				else
					{
					attack_cooldown_set(60);
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