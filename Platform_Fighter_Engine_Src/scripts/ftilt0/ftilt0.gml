function ftilt0() {
	//Forward Tilt for character0
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
				anim_sprite = spr_ftilt0;
				anim_frame = 0;
				anim_speed = 0;
		
				attack_frame = 7;
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
					
					attack_phase++;
					attack_frame = 23;
					
					var _hitbox = hitbox_create_magnetbox(40, 5, 0.9, 0.6, 1, 1, 84, -4, 10, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					}
				break;
				}
			//Active
			case 1:
				{
				//Multihit
				if (attack_frame == 21)
					{
					anim_frame = 3;
					var _hitbox = hitbox_create_magnetbox(94, -2, 0.8, 0.8, 1, 1, 94, -4, 6, 18, SHAPE.circle, 1, true);
					_hitbox.hitlag_scaling = 0;
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = [snd_hit_weak, snd_hit_weak2];
					}
				if (attack_frame > 3 && attack_frame % 4 == 0)
					{
					hitbox_group_reset(1);
					}
					
				//Animation
				if (attack_frame == 18)
					anim_frame = 4;
				if (attack_frame == 15)
					anim_frame = 5;
				if (attack_frame == 11)
					anim_frame = 6;
				if (attack_frame == 7)
					anim_frame = 7;
					
				//Final hit
				if (attack_frame == 3)
					{
					anim_frame = 8;
					var _hitbox = hitbox_create_melee(94, -2, 0.8, 0.8, 3, 7, 0.85, 11, 70, 2, SHAPE.circle, 2);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 9;
					
					attack_phase++;
					attack_frame = attack_connected() ? 10 : 16;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame <= 10)
					anim_frame = 10;
				if (attack_frame <= 5)
					anim_frame = 11;
					
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			}
		}
	//Movement
	move_grounded();
}
/* Copyright 2023 Springroll Games / Yosi */