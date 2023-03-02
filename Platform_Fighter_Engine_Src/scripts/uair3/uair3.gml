function uair3() {
	//Up Aerial for character3
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
				anim_sprite = spr_uair3;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 9;
				landing_lag = 11;
				speed_set(0, -1, true, true);
				
				hurtbox_anim_match();
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
					attack_frame = 8;
					
					var _hitbox = hitbox_create_melee(28, 4, 0.7, 0.9, 13, 8, 1, 7, 85, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong2;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 7)
					{
					anim_frame = 4;
					var _hitbox = hitbox_create_melee(0, -22, 1.2, 0.7, 12, 7, 0.98, 7, 85, 1, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					}
				if (attack_frame == 6)
					{
					anim_frame = 5;
					var _hitbox = hitbox_create_melee(-8, -22, 1.2, 0.7, 12, 7, 0.98, 7, 85, 1, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong2;
					}
				if (attack_frame == 5)
					{
					anim_frame = 6;
					var _hitbox = hitbox_create_melee(-28, -5, 1, 0.7, 11, 6, 0.9, 7, 85, 2, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					}
				
				if (attack_frame == 3)
					anim_frame = 7;
					
				//Reduce landing lag on hit
				if (attack_connected())
					{
					landing_lag = 6;
					}
					
				if (attack_frame == 0)
					{
					anim_frame = 8;
					attack_phase++;
					attack_frame = attack_connected() ? 20 : 30;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 25)
					anim_frame = 9;
				if (attack_frame == 20)
					anim_frame = 10;
				if (attack_frame == 17)
					anim_frame = 11;
				if (attack_frame == 14)
					anim_frame = 12;
				if (attack_frame == 11)
					anim_frame = 13;
				if (attack_frame == 8)
					anim_frame = 14;
				if (attack_frame == 5)
					anim_frame = 15;
				if (attack_frame == 3)
					anim_frame = 16;
					
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
	
	//Hurtbox
	if (run)
		{
		hurtbox_anim_match();
		}
}
/* Copyright 2023 Springroll Games / Yosi */