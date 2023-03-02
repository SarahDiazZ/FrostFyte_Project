function fspec_wolf() {
	//Forward Special
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_fspec_wolf;
				anim_speed = 0;
				anim_frame = 0;
			
				landing_lag = 20;
				parry_stun_time = 60;
				speed_set(clamp(hsp, -2, 2), clamp(vsp, -2, 2), false, false);
				attack_frame = 8;
				
				hurtbox_anim_match(spr_fspec_wolf_hurtbox);
				return;
				}
			//Startup -> First Hitbox
			case 0:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
					speed_set(45 * facing, -10, false, false);
					attack_phase++;
					attack_frame = 5;
					var _hitbox = hitbox_create_melee(0, -7, 1, 0.3, 3, 10, 0.1, 8, 70, 3, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 25);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					}
				break;
				}
			//Second Hitbox
			case 1:
				{
				//Continue speed
				speed_set(45 * facing, -10, false, false);
			
				//Move up walls
				if (collision(x + facing, y, [FLAG.solid]))
					{
					speed_set(0, -20, true, false);
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
					speed_set(0, -1, false, false);
					attack_phase++;
					attack_frame = 10;
					var _hitbox = hitbox_create_melee(0, 0, 0.6, 0.6, 10, 9, 1, 15, 270, 3, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.normal_strong, HIT_VFX.shine];
					}
				break;
				}
			//Endlag -> Finish
			case 2:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 4;
				if (attack_frame == 5)
					anim_frame = 5;
				if (attack_frame == 3)
					anim_frame = 6;
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.helpless);
					run = false;
					}
				break;
				}
			}
		}
	//Movement
	move();

	//Hurtbox matching
	if (run)
		{
		hurtbox_anim_match(spr_fspec_wolf_hurtbox);
		}
}
/* Copyright 2023 Springroll Games / Yosi */