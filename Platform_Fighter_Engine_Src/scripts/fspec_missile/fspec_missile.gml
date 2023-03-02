function fspec_missile() {
	//Forward Special
	/*
	- Fires a controllable missile
	- Hold the button to extend the attack (making it easier to control the missile without self destructing)
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
		}
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_fspec_missile;
				anim_speed = 0;
				anim_frame = 0;
		
				if (on_ground())
					{
					speed_set(0, 0, false, false);
					}
				else
					{
					speed_set(0, -1, true, true);
					}
				attack_frame = 10;
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
					attack_frame = 10;
					var _proj = hitbox_create_projectile_custom(obj_fspec_missile_projectile, 30, 0, 0.4, 0.4, 2, 4, 0.3, 90, 300, SHAPE.rotation, 0, 0);
					_proj.base_hitlag = 1;
					_proj.hit_vfx_style = HIT_VFX.normal_medium;
					_proj.can_lock = true;
					if (facing == 1)
						_proj.overlay_angle = 0;
					else
						_proj.overlay_angle = 180;
					}
				break;
				}
			//Endlag -> Finish
			case 1:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 3;
					
				//You can infinitely extend the attack by holding the button
				if (attack_frame == 0 && !input_held(INPUT.special, 0))
					{
					if (on_ground())
						{
						attack_stop(PLAYER_STATE.idle);
						}
					else
						{
						attack_stop(PLAYER_STATE.aerial);
						}
					}
				break;
				}
			}
		}
	//Movement
	move();


}

/* Copyright 2023 Springroll Games / Yosi */