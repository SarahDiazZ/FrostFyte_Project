function utilt0() {
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
				anim_sprite = spr_utilt0;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 11;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 7)
					anim_frame = 1;
					
				//Early hit
				if (attack_frame == 3)
					{
					anim_frame = 2;
					
					var _hitbox = hitbox_create_melee(-4, 0, 0.6, 0.4, 4, 11, 0.2, 5, 85, 3, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.force_reeling = true;
					}
				
				//Normal hit
				if (attack_frame == 0)
					{
					anim_frame = 3;
					
					var _hitbox = hitbox_create_melee(35, -34, 1.4, 0.5, 9, 9, 0.9, 9, 50, 4, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 35);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.hit_sfx = snd_hit_strong;
				
					attack_phase++;
					attack_frame = 4;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 3)
					anim_frame = 4;
					
				if (attack_frame == 0)
					{
					anim_frame = 5;
					attack_phase++;
					attack_frame = 14;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 7)
					anim_frame = 6;

				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					run = false;
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();
	
	//Hurtbox
	if (run)
		{
		hurtbox_anim_set(hurtbox_crouch_sprite, 0, facing, 1, 0);
		}
}
/* Copyright 2023 Springroll Games / Yosi */