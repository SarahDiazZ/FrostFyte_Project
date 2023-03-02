function utilt4() {
	//Upward Tilt
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
				//Animation
				anim_sprite = spr_utilt4;
				anim_speed = 0;
				anim_frame = 0;
				
				hurtbox_anim_set(hurtbox_crouch_sprite, 0, facing, 1, 0);
		
				attack_frame = 7;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 4)
					{
					anim_frame = 1;
					speed_set(2 * facing, 0, false, false);
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
					
					var _hitbox = hitbox_create_melee(5, -6, 0.3, 1.2, 5, 9, 0.4, 5, 70, 3, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, -41);
					_hitbox.hitstun_scaling = 1.0;
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak2;
				
					attack_phase++;
					attack_frame = 3;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 0)
					{
					attack_phase++;
					anim_frame = 3;
					attack_frame = attack_connected() ? 12 : 20;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Jump cancel	
				if (attack_connected() && cancel_jump_check())
					{
					return;
					}
				
				//Animation
				if (attack_frame == 16)
					anim_frame = 4;
				if (attack_frame <= 11)
					anim_frame = 5;
				if (attack_frame <= 5)
					anim_frame = 6;

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