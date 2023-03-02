function dspec_shine() {
	//Down Special
	/*
	- Can be jump canceled after the hitbox comes out
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
		//Actions
		aerial_drift();
		fastfall_try();
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
			
				attack_frame = 3;
			
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
					change_facing();
					
					//Animation
					anim_frame = 2;
				
					attack_phase++;
					attack_frame = 6;
				
					invulnerability_set(INV.reflector, 6);
				
					//Grounded versus aerial
					if (!on_ground())
						{
						var _hitbox = hitbox_create_melee(0, 0, 1, 1, 3, 4, 0.5, 2, 17, 3, SHAPE.circle, 0, FLIPPER.from_player_center);
						_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
						_hitbox.hitstun_scaling = 2;
						_hitbox.hitlag_scaling = 0;
						}
					else
						{
						var _hitbox = hitbox_create_melee(0, 0, 1, 1, 3, 5, 0.35, 2, 50, 3, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
						_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
						_hitbox.hitlag_scaling = 0;
						}
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 3;
				
				//Jump cancel
				if (run && cancel_jump_check())
					{
					//Reset the special input buffer, so it doesn't start another shine
					input_reset(INPUT.special);
					run = false;
					}
			
				if (run && attack_frame == 0)
					{
					attack_phase++;
					attack_frame = 10;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
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