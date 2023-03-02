function uair_luigi() {
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
			
				landing_lag = 10;
				speed_set(0, -1, true, true);
				attack_frame = 5;
				return;
				}
			//Active
			case 0:
				{
				//Animation
				if (attack_frame == 3)
					anim_frame = 1;
  
				//Initial Hit
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 2;
				
					var _hitbox = hitbox_create_melee(26, 0, 0.4, 0.4, 10, 3, 0.25, 5, 70, 3, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.custom_hitstun = 35;
					_hitbox.di_angle = 10;
				
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
					var _hitbox = hitbox_create_melee(12, -36, 0.5, 0.5, 9, 3, 0.25, 5, 70, 3, SHAPE.circle, 0);
					_hitbox.custom_hitstun = 35;
					_hitbox.di_angle = 10;
					var _hitbox = hitbox_create_melee(24, -20, 0.3, 0.3, 9, 3, 0.25, 5, 70, 3, SHAPE.circle, 0);
					_hitbox.custom_hitstun = 35;
					_hitbox.di_angle = 10;
					}
				
				if (attack_frame == 5)
					{
					anim_frame = 4;
					var _hitbox = hitbox_create_melee(-20, -28, 0.6, 0.6, 8, 3, 0.25, 5, 70, 3, SHAPE.circle, 0);
					_hitbox.custom_hitstun = 35;
					_hitbox.di_angle = 10;
					var _hitbox = hitbox_create_melee(0, -38, 0.5, 0.5, 8, 3, 0.25, 5, 70, 3, SHAPE.circle, 0);
					_hitbox.custom_hitstun = 35;
					_hitbox.di_angle = 10;
					}
				
				if (attack_frame == 2)
					{
					anim_frame = 5;
					var _hitbox = hitbox_create_melee(-30, 4, 0.3, 0.3, 7, 3, 0.25, 5, 70, 6, SHAPE.circle, 0);
					_hitbox.custom_hitstun = 30;
					_hitbox.di_angle = 10;
					}
				
				if (attack_frame == 0)
					{
					//Whiff lag
					attack_phase++;
					attack_frame = attack_connected() ? 6 : 13;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 6;
				if (attack_frame == 9)
					anim_frame = 7;
				if (attack_frame == 6)
					anim_frame = 8;
				if (attack_frame == 3)
					anim_frame = 9;
			
				//Autocancel
				if (attack_frame <= 6)
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