function utilt2() {
	//Up Tilt for character2
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
				anim_sprite = spr_utilt2;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 6;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 3)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 9;
					
					//Strong hits
					var _hitbox = hitbox_create_melee(0, -15, 0.5, 0.4, 6, 7, 0.45, 7, 90, 9, SHAPE.square, 0);
					_hitbox.hitstun_scaling = 1.4;
					_hitbox.shieldstun_scaling = 0.5;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					var _hitbox = hitbox_create_melee(0, 15, 0.8, 0.2, 6, 7, 0.45, 7, 90, 2, SHAPE.square, 0);
					_hitbox.hitstun_scaling = 1.4;
					_hitbox.shieldstun_scaling = 0.5;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				if (attack_frame == 6)
					{
					anim_frame = 3;
					
					//Weak hit
					var _hitbox = hitbox_create_melee(0, -15, 0.5, 0.8, 6, 7, 0.45, 5, 90, 9, SHAPE.square, 0);
					_hitbox.hitstun_scaling = 1.2;
					_hitbox.shieldstun_scaling = 0.5;
					_hitbox.hit_sfx = snd_hit_weak2;
					}
			
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = attack_connected() ? 4 : 10;
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