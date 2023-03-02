function dash_attack_leap() {
	//Dash Attack
	/*
	- Hold the button to delay the attack
	- You can airdodge out of the attack
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
				anim_sprite = spr_dash_attack_leap;
				anim_speed = 0;
				anim_frame = 0;
			
				attack_frame = 22;
				speed_set(8 * facing, -5.5, false, false);
				charge = 0;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 18)
					anim_frame = 1;
				if (attack_frame == 15)
					anim_frame = 2;
				if (attack_frame == 10)
					anim_frame = 3;
				if (attack_frame == 5)
					anim_frame = 4;
				
				//Friction and gravity
				if (on_ground())
					{
					friction_gravity(ground_friction);
					}
				else
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					}
			
				//Cancel with waveland
				if (cancel_airdodge_check()) return;
			
				if (attack_frame == 0 && input_held(INPUT.attack, 0))
					{
					charge++;
					}
				if (attack_frame == 0 && (!input_held(INPUT.attack, 0) || charge >= 15))
					{
					attack_phase++;
					attack_frame = 13;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				if (attack_frame == 11)
					{
					anim_frame = 5;
				
					var _hitbox = hitbox_create_melee(4, 8, 0.3, 0.7, 9, 7, 1, 10, 315, 3, SHAPE.rotation, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.techable = false;
					hitbox_sprite_angle_set(_hitbox, 25);
					speed_set(-6 * facing, -7, false, false);
					}
					
				//Animation
				if (attack_frame == 7)
					anim_frame = 6;
				if (attack_frame == 5)
					anim_frame = 7;

				friction_gravity(air_friction, grav, max_fall_speed);
			
				if (attack_frame == 0)
					{
					anim_frame = 8;
			
					attack_phase++;
					attack_frame = (15 - (charge div 2));
					}
				break;
				}
			//Finish
			case 2:
				{
				friction_gravity(air_friction, grav, max_fall_speed);
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.aerial);
					}
				break;
				}
			}
		}
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */