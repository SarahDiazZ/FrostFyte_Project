function uair_dr_mario() {
	//Up Aerial
	//Logic Control Variable
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);

	//Actions
	friction_gravity(air_friction, grav, max_fall_speed);
	fastfall_attack_try();
	allow_hitfall();
	aerial_drift();

	//Cancels
	if (run && cancel_ground_check()) then run = false;

	//Main Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				anim_sprite = spr_uair_mario;
				anim_frame = 0;
				anim_speed = 0;
			
				landing_lag = 12;
				speed_set(0, -1, true, true);
				attack_frame = 4;
				return;
				}
			//Active
			case 0:
				{
				//Animation
				if (attack_frame == 2)
					anim_frame = 1;
  
				//Initial Hit
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 2;
				
					var _hitbox = hitbox_create_melee(26, 0, 0.4, 0.4, 9, 5.5, 0.75, 8, 35, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hitstun_scaling = 5;
				
					//Next phase
					attack_phase++;
					attack_frame = 8;
					}
				break;
				}
			//Endlag
			case 1:
				{
				if (attack_frame == 7)
					{
					anim_frame = 3;
					var _hitbox = hitbox_create_melee(12, -36, 0.5, 0.5, 8, 5, 0.75, 7, 35, 3, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hitstun_scaling = 4;
					var _hitbox = hitbox_create_melee(24, -20, 0.3, 0.3, 8, 5, 0.75, 7, 35, 3, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hitstun_scaling = 4;
					}
				
				if (attack_frame == 5)
					{
					anim_frame = 4;
					var _hitbox = hitbox_create_melee(-20, -28, 0.6, 0.6, 8, 5, 0.6, 7, 35, 3, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hitstun_scaling = 4;
					var _hitbox = hitbox_create_melee(0, -38, 0.5, 0.5, 8, 5, 0.6, 7, 35, 3, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hitstun_scaling = 4;
					}
				
				if (attack_frame == 2)
					{
					anim_frame = 5;
					var _hitbox = hitbox_create_melee(-30, 4, 0.3, 0.3, 7, 4, 0.5, 6, 35, 6, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hitstun_scaling = 7;
					_hitbox.di_angle = 5;
					_hitbox.drift_di_multiplier = 0.5;
					}
				
				if (attack_frame == 0)
					{
					//Whiff lag
					attack_phase++;
					attack_frame = attack_connected() ? 20 : 24;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 18)
					anim_frame = 6;
				if (attack_frame == 13)
					anim_frame = 7;
				if (attack_frame == 8)
					anim_frame = 8;
				if (attack_frame == 3)
					anim_frame = 9;
			
				//Autocancel
				if (attack_frame == 16)
					landing_lag = 3;
			
				if (attack_frame == 0)
					{
					//Revert back to the original state
					attack_stop(PLAYER_STATE.aerial);
					}
				break;
				}
			}
		}
	//Movement
	move();


}

/* Copyright 2023 Springroll Games / Yosi */