function utilt_marth() {
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
				anim_sprite = spr_utilt_marth;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 6;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 1;
				if (attack_frame == 2)
					{
					anim_frame = 2;
					speed_set(2 * facing, 0, false, false);
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
					//Normal
					var _hitbox = hitbox_create_melee(26, -16, 0.55, 0.9, 6, 8, 0.4, 6, 95, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					//Tipper
					var _hitbox = hitbox_create_melee(52, -38, 0.4, 0.9, 9, 6, 1.1, 15, 95, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					var _hitbox = hitbox_create_melee(48, 0, 0.4, 0.5, 9, 6, 1.1, 15, 95, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_strong;
				
					attack_phase++;
					attack_frame = 6;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 5)
					{
					anim_frame = 4;
					//Normal
					var _hitbox = hitbox_create_melee(4, -48, 0.4, 0.6, 6, 8, 0.4, 6, 90, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					//Tipper
					var _hitbox = hitbox_create_melee(8, -78, 0.4, 0.5, 9, 6, 1.1, 15, 90, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					var _hitbox = hitbox_create_melee(32, -74, 0.45, 0.4, 9, 6, 1.1, 15, 90, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					}
				
				if (attack_frame == 4)
					{
					anim_frame = 5;
					//Normal
					var _hitbox = hitbox_create_melee(-8, -48, 0.4, 0.7, 6, 8, 0.4, 6, 90, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					//Tipper
					var _hitbox = hitbox_create_melee(-28, -68, 0.4, 0.5, 9, 6, 1, 15, 90, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					}
				
				if (attack_frame == 3)
					{
					anim_frame = 6;
					//Normal
					var _hitbox = hitbox_create_melee(-22, -40, 0.7, 0.5, 6, 8, 0.4, 6, 90, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					//Tipper
					var _hitbox = hitbox_create_melee(-48, -48, 0.4, 0.5, 9, 6, 1, 15, 90, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					}
				
				if (attack_frame == 2)
					{
					anim_frame = 7;
					//Normal
					var _hitbox = hitbox_create_melee(-24, -8, 0.7, 0.5, 5, 7, 0.3, 4, 90, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					//Tipper
					var _hitbox = hitbox_create_melee(-50, -16, 0.4, 0.6, 9, 5, 0.9, 15, 85, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hitstun_scaling = 3;
					}
			
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = attack_connected() ? 10 : 21;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 16)
					anim_frame = 8;
				if (attack_frame == 11)
					anim_frame = 9;
				if (attack_frame <= 5)
					anim_frame = 10;

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