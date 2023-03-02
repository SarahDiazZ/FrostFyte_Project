function dair_snake() {
	//Down Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
	fastfall_try();
	aerial_drift();
	//Canceling
	if (run && cancel_ground_check()) then run = false;

	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_dair_snake;
				anim_speed = 0;
				anim_frame = 0;
				landing_lag = 20;
				speed_set(0, -1, true, true);
				attack_frame = 3;
				
				collision_box_change(spr_dair_snake_collision_box);
				hurtbox_anim_match(spr_dair_snake_hurtbox);
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame == 0)
					{
					anim_frame = 1;
			
					attack_phase++;
					attack_frame = 25;
					var _hitbox = hitbox_create_melee(0, 36, 0.6, 1, 4, 3, 0, 5, 270, 2, SHAPE.circle, 0, FLIPPER.autolink);
					_hitbox.techable = false;
					_hitbox.extra_hitlag = 3;
					_hitbox.hitlag_scaling = 0;
					_hitbox.background_clear_allow = false;
					_hitbox.can_lock = true;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 23)
					anim_frame = 2;
				
				if (attack_frame == 18)
					{
					anim_frame = 3;
					var _hitbox = hitbox_create_melee(0, 36, 0.6, 1, 3, 2, 0, 6, 270, 2, SHAPE.circle, 1, FLIPPER.autolink);
					_hitbox.techable = false;
					_hitbox.extra_hitlag = 3;
					_hitbox.hitlag_scaling = 0;
					_hitbox.background_clear_allow = false;
					_hitbox.can_lock = true;
					}
					
				if (attack_frame == 16)
					anim_frame = 4;
					
				if (attack_frame == 11)
					{
					anim_frame = 5;
					var _hitbox = hitbox_create_melee(0, 36, 0.6, 1, 3, 2, 0, 7, 270, 2, SHAPE.circle, 2, FLIPPER.autolink);
					_hitbox.techable = false;
					_hitbox.extra_hitlag = 3;
					_hitbox.hitlag_scaling = 0;
					_hitbox.background_clear_allow = false;
					_hitbox.can_lock = true;
					}
					
				if (attack_frame == 9)
					anim_frame = 6;
					
				if (attack_frame == 4)
					{
					anim_frame = 7;
					speed_set(0, -4, true, true);
					var _hitbox = hitbox_create_melee(0, 36, 0.6, 1, 10, 6, 0.6, 10, 40, 2, SHAPE.circle, 3);
					_hitbox.di_angle = 10;
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.hitstun_scaling = 2;
					}
				
				if (attack_frame == 2)
					anim_frame = 8;

				if (attack_frame == 0)
					{
					landing_lag = 15;
					attack_phase++;
					attack_frame = attack_connected() ? 5 : 25;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 20)
					anim_frame = 9;
				if (attack_frame <= 10)
					anim_frame = 10;
				
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.aerial);
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
		hurtbox_anim_match(spr_dair_snake_hurtbox);
		}
}
/* Copyright 2023 Springroll Games / Yosi */