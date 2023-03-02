function ftilt_arms() {
	//Forward Tilt
	/*
	- Tilt the left stick up or down to get a different angle
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;

	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(ground_friction, grav, max_fall_speed);

	//Canceling
	if (run && cancel_air_check()) then run = false;

	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				anim_sprite = spr_ftilt_arms;
				anim_speed = 0;
				anim_frame = 0;
				attack_frame = 14;
				callback_add(callback_draw_end, ftilt_arms_draw);
				
				//Variables
				custom_attack_struct.arm_x = 0;
				custom_attack_struct.arm_y = 0;
				custom_attack_struct.arm_angle = 0;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 9)
					anim_frame = 1;
				if (attack_frame == 4)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
					attack_phase++;
					attack_frame = 17;
				
					//Store angle
					var _val = stick_get_value(Lstick, DIR.vertical);
					if (_val < -0.15)
						{
						custom_attack_struct.arm_angle = -1;
						}
					else if (_val > 0.15)
						{
						custom_attack_struct.arm_angle = 1;
						}
					else 
						{
						custom_attack_struct.arm_angle = 0;
						}

					//Hitbox
					var _hitbox = hitbox_create_melee(0, 0, 0.5, 0.5, 9, 8, 0.8, 8, 45, 18, SHAPE.circle, 0, FLIPPER.sakurai);
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hitstun_scaling = 2;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 16)
					anim_frame = 4;
				
				//Move hitbox
				hitbox_move_attached_group(0, 13 * facing, custom_attack_struct.arm_angle * 2);
				custom_attack_struct.arm_x += (13 * facing);
				custom_attack_struct.arm_y += (custom_attack_struct.arm_angle * 2);
				
				//Cancel on hit
				if (attack_connected(true))
					{
					anim_frame = 5;
					attack_phase++;
					attack_frame = 20;
					hitbox_destroy_attached_all();
					}
				else if (attack_frame == 0)
					{
					anim_frame = 5;
					attack_phase++;
					attack_frame = 30;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 15)
					anim_frame = 6;
				
				//Move arm back
				custom_attack_struct.arm_x = lerp(custom_attack_struct.arm_x, 0, 0.15);
				custom_attack_struct.arm_y = lerp(custom_attack_struct.arm_y, 0, 0.15);

				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();


}

/* Copyright 2023 Springroll Games / Yosi */