function uair_mario() {
	//Up Aerial
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
				attack_frame = 3;
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
					anim_frame = 2;
					var _hitbox = hitbox_create_melee(26, 4, 0.4, 0.6, 6, 6, 0.6, 5, 75, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.pre_hit_script = uair_mario_pre_hit;
				
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
					var _hitbox = hitbox_create_melee(12, -36, 0.5, 0.5, 6, 6, 0.6, 4, 75, 3, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.pre_hit_script = uair_mario_pre_hit;
					var _hitbox = hitbox_create_melee(24, -20, 0.3, 0.3, 6, 6, 0.6, 4, 75, 3, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.pre_hit_script = uair_mario_pre_hit;
					}
				
				if (attack_frame == 5)
					{
					anim_frame = 4;
					var _hitbox = hitbox_create_melee(-20, -28, 0.6, 0.6, 6, 6, 0.6, 4, 75, 3, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.pre_hit_script = uair_mario_pre_hit;
					var _hitbox = hitbox_create_melee(0, -38, 0.5, 0.5, 6, 6, 0.6, 4, 75, 3, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.pre_hit_script = uair_mario_pre_hit;
					}
				
				if (attack_frame == 2)
					{
					anim_frame = 5;
					var _hitbox = hitbox_create_melee(-30, 4, 0.3, 0.3, 5, 6, 0.2, 3, 75, 6, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hitstun_scaling = 7;
					_hitbox.drift_di_multiplier = 0.5;
					_hitbox.can_lock = true;
					}
				
				if (attack_frame == 0)
					{
					//Whiff lag
					attack_phase++;
					attack_frame = attack_connected() ? 18 : 22;
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