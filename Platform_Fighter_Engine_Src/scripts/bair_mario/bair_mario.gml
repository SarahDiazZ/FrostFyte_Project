function bair_mario() {
	//Backward Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction,grav, max_fall_speed);
	fastfall_attack_try();
	allow_hitfall();
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
				anim_sprite = spr_bair_mario;
				anim_speed = 0;
				anim_frame = 0;
				landing_lag = 13;
				speed_set(0, -1, true, true);
				attack_frame = 9;
				
				hurtbox_anim_match();
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 5)
					anim_frame = 1;
					
				if (attack_frame == 3)
					{
					anim_frame = 2;
				
					var _hitbox = hitbox_create_melee(-22, 0, 0.5, 0.7, 8, 8, 0.6, 7, 35, 4, SHAPE.square, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hitstun_scaling = 0.4;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					}
					
				if (attack_frame == 0)
					{
					anim_frame = 3;
			
					attack_phase++;
					attack_frame = 7;
					var _hitbox = hitbox_create_melee(-36, 0, 1, 0.7, 6, 8, 0.6, 6, 140, 3, SHAPE.square, 0);
					_hitbox.hitstun_scaling = 0.4;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 4;
				if (attack_frame == 4)
					anim_frame = 5;
					
				if (attack_frame == 0)
					{
					attack_phase++;
					
					//Whiff lag
					attack_frame = attack_connected() ? 12 : 20;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 10)
					anim_frame = 6;
				if (attack_frame == 5)
					anim_frame = 7;
					
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
		hurtbox_anim_match();
		}
}

/* Copyright 2023 Springroll Games / Yosi */