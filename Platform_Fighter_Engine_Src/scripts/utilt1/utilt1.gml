function utilt1() {
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
				anim_sprite = spr_utilt1;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 9;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
					var _hitbox = hitbox_create_melee(98, -77, 0.3, 0.3, 8, 9, 0.7, 10, 70, 5, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.electric_weak;
					_hitbox.hit_sfx = snd_hit_electro;
					_hitbox.extra_hitlag = 20;
					var _hitbox = hitbox_create_melee(50, -33, 1.6, 0.2, 6, 9, 0.7, 5, 70, 5, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 41);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					attack_phase++;
					attack_frame = 10;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 3;
				if (attack_frame == 5)
					anim_frame = 4;
				
				if (attack_frame == 0)
					{
					anim_frame = 5;
					attack_phase++;
					attack_frame = attack_connected() ? 5 : 15;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame <= 7)
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