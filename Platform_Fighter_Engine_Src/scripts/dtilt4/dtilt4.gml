function dtilt4() {
	//Downward Tilt
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
				anim_sprite = spr_dtilt4;
				anim_speed = 0;
				anim_frame = 0;
			
				hurtbox_anim_set(hurtbox_crouch_sprite, 0, facing, 1, 0);
		
				attack_frame = 4;
				return;
				}
			//Startup
			case 0:
				{
				if (attack_frame == 0)
					{
					speed_set(2 * facing, 0, false, false);
					
					anim_frame = 1;
					
					var _hitbox = hitbox_create_melee(38, 21, 0.7, 0.2, 4, 6, 0.6, 3, 65, 2, SHAPE.square, 0);
					_hitbox.hitstun_scaling = 1.5;
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.can_lock = true;
					
					//Ledge hitbox
					var _hitbox = hitbox_create_melee(38, 31, 0.7, 0.2, 4, 6, 0.6, 3, 65, 2, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hit_restriction = HIT_RESTRICTION.ledge_only;
				
					attack_phase++;
					attack_frame = 2;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 0)
					{
					anim_frame = 2;
					
					//Whiff lag
					attack_frame = attack_connected() ? 12 :  16;
					attack_phase++;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 3;
				if (attack_frame == 8)
					anim_frame = 4;

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