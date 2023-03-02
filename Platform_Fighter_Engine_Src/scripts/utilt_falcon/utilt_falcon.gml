function utilt_falcon() {
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
				anim_sprite = spr_utilt_falcon;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 13;
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 11)
					anim_frame = 1;
				if (attack_frame == 8)
					anim_frame = 2;
				if (attack_frame == 5)
					anim_frame = 3;
				if (attack_frame == 2)
					anim_frame = 4;
				
				if (attack_frame == 0)
					{
					anim_frame = 5;
					var _hitbox = hitbox_create_melee(16, -48, 0.2, 1, 9, 7, 0.8, 7, 290, 1, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.custom_hitstun = 30;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.hit_restriction = HIT_RESTRICTION.aerial_only;
					var _hitbox = hitbox_create_melee(16, -48, 0.2, 1, 9, 8, 0.5, 7, 70, 1, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak;
					_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
				
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
					anim_frame = 6;
					var _hitbox = hitbox_create_melee(32, -48, 0.8, 0.9, 9, 7, 0.8, 7, 290, 1, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.custom_hitstun = 30;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.hit_restriction = HIT_RESTRICTION.aerial_only;
					var _hitbox = hitbox_create_melee(32, -48, 0.8, 0.9, 9, 8, 0.5, 7, 70, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak;
					_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
					}
				
				if (attack_frame == 4)
					{
					anim_frame = 7;
					var _hitbox = hitbox_create_melee(48, -16, 1.1, 0.6, 9, 7, 0.8, 3, 290, 1, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.custom_hitstun = 30;
					_hitbox.hit_restriction = HIT_RESTRICTION.aerial_only;
					var _hitbox = hitbox_create_melee(48, -16, 1.1, 0.6, 9, 8, 0.5, 7, 70, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak;
					_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
					}
				
				if (attack_frame == 3)
					{
					anim_frame = 8;
					var _hitbox = hitbox_create_melee(36, 8, 0.9, 0.4, 9, 7, 0.8, 3, 290, 1, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.custom_hitstun = 30;
					_hitbox.hit_restriction = HIT_RESTRICTION.aerial_only;
					var _hitbox = hitbox_create_melee(36, 8, 0.9, 0.4, 9, 8, 0.5, 7, 70, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak;
					_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
					}
				
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = attack_connected() ? 6 : 16;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 10)
					anim_frame = 9;
				if (attack_frame == 5)
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