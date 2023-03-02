function utilt3() {
	//Upward Tilt for character3
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
				anim_sprite = spr_utilt3;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 9;
				
				hurtbox_anim_match(spr_utilt3_hurtbox);
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 6)
					anim_frame = 1;
				if (attack_frame == 3)
					anim_frame = 2;
					
				if (attack_frame == 0)
					{
					anim_frame = 3;
			
					attack_phase++;
					attack_frame = 10;
					
					var _hitbox = hitbox_create_magnetbox(57, -20, 0.8, 1, 3, 6, 22, -68, 10, 1, SHAPE.circle, 0, true);
					_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					var _hitbox = hitbox_create_magnetbox(29, 6, 0.6, 0.8, 3, 6, 22, -68, 10, 1, SHAPE.circle, 0, true);
					_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
					_hitbox.hit_sfx = snd_hit_weak;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 9)
					{
					anim_frame = 4;
					
					var _hitbox = hitbox_create_magnetbox(50, -54, 0.6, 0.6, 3, 6, 22, -68, 8, 1, SHAPE.circle, 0, true);
					_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
					_hitbox.hit_sfx = snd_hit_weak;
					}
					
				if (attack_frame == 8)
					{
					anim_frame = 5;
					
					var _hitbox = hitbox_create_melee(22, -68, 0.75, 0.75, 6, 10, 0.9, 11, 90, 4, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				
				if (attack_frame == 4)
					{
					anim_frame = 6;
					}
					
				if (attack_frame == 0)
					{
					anim_frame = 7;
					
					attack_phase++;
					attack_frame = attack_connected() ? 14 : 23;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 16 || attack_frame == 12)
					anim_frame = 8;
				if (attack_frame == 6)
					anim_frame = 9;
				if (attack_frame == 3)
					anim_frame = 10;
					
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
		hurtbox_anim_match(spr_utilt3_hurtbox);
		}
}
/* Copyright 2023 Springroll Games / Yosi */