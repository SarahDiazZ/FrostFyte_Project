function dspec_earth_wall() {
	//Down Special
	/*
	- Creates a wall that reflects enemy projectiles on both sides
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
			
				attack_frame = 15;
			
				reverse_b();
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame == 11)
					{
					b_reverse();
					}
				
				if (attack_frame == 10)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
				
					attack_phase++;
					attack_frame = 18;
				
					//Find an open spot on the ground
					var _x = x + (96 * facing);
					var _y = y;
					for(var _y = bbox_bottom - 8; _y < room_height; _y += 8)
						{
						var _inst = instance_position(_x, _y, obj_block);
						if (_inst != noone)
							{
							if (!collision_point(_x, _y - 8, _inst, false, true))
								{
								//Create entity there
								var _entity = entity_create(_x, _inst.bbox_top, obj_dspec_earth_wall);
								_entity.facing = facing;
								_entity.image_xscale *= facing;
								
								with(_entity)
									{
									//Initial hitbox
									var _hitbox = hitbox_create_melee(6, -24, 0.7, 1.0, 11, 9, 1.0, 8, 75, 3, SHAPE.square, 0);
									_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
									_hitbox.hit_sfx = snd_hit_strong3;
									hitbox_group_whitelist_id(player_id, 0);
									
									//Hurtbox
									var _hurtbox = hurtbox_create_permanent(spr_hitbox_square);
									with(_hurtbox)
										{
										hurtbox_setup
											(
											-1,
											-1,
											-1,
											-1,
											-1,
											-1,
											dspec_earth_wall_projectile_hit,
											);
										}
									hurtbox_inv_set(_hurtbox, INV.reflector, -1);
									}
								
								camera_shake(0, 4);
								
								//Cooldown
								attack_cooldown_set(90);
								}
							break;
							}
						}
					}
				break;
				}
			//Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 3;
				if (attack_frame == 6)
					anim_frame = 4;
			
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