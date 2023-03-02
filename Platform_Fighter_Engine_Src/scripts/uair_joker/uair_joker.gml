function uair_joker() {
	//Up Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
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
				anim_sprite = spr_uair_joker;
				anim_speed = 0;
				anim_frame = 0;
				landing_lag = 12;
				speed_set(0, -1, true, true);
				attack_frame = 7;
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame == 3)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 13;
					var _hitbox = hitbox_create_melee(2, -10, 0.4, 0.8, 1, 5, 0.1, 3, 80, 13, SHAPE.square, 0, FLIPPER.autolink_center);
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.techable = false;
					_hitbox.custom_hitstun = 15;
					_hitbox.background_clear_allow = false;
					_hitbox.hitlag_scaling = 0;
					_hitbox.can_lock = true;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 11)
					anim_frame = 3;
				if (attack_frame == 9)
					anim_frame = 4;
				if (attack_frame == 7)
					anim_frame = 5;
				if (attack_frame == 5)
					anim_frame = 6;
				if (attack_frame == 3)
					anim_frame = 7;
				if (attack_frame == 1)
					anim_frame = 8;
				
				if (attack_frame % 3 == 0)
					{
					//Re-hit
					hitbox_group_reset(0);
					}
					
				//Decrease landing lag on hit
				if (attack_connected())
					{
					landing_lag = 4;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 9;
					
					//Final hit
					var _hitbox = hitbox_create_melee(2, -10, 0.45, 0.9, 5, 9, 1, 10, 80, 4, SHAPE.square, 1);
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					attack_phase++;
					attack_frame = attack_connected() ? 12 : 25;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 16)
					anim_frame = 10;
				if (attack_frame == 8)
					anim_frame = 11;
				
				if (attack_frame == 0)
					{
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