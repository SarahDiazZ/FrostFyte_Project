function ftilt_sheik() {
	//Forward Tilt
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
				anim_sprite = spr_ftilt_sheik;
				anim_speed = 0; 
				anim_frame = 0;
		
				attack_frame = 5;
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
					anim_frame = 2;
					attack_phase++;
					attack_frame = 3;
					var _hitbox = hitbox_create_melee(16, 2, 1.0, 0.6, 4, 5, 0.55, 4, 75, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.custom_hitstun = 34;
					_hitbox.shieldstun_scaling = 2;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 2)
					anim_frame = 3;
				
				if (attack_frame == 0)
					{
					anim_frame = 4;
					attack_phase++;
					attack_frame = attack_connected() ? 15 : 18;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 14)
					anim_frame = 5;
				if (attack_frame == 9)
					anim_frame = 6;
				if (attack_frame == 5)
					anim_frame = 7;
			
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