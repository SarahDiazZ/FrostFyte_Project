function nair3() {
	//Neutral Aerial for character3
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
				anim_sprite = spr_nair3;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 9;
				landing_lag = 8;
				speed_set(0, -1, true, true);
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 5)
					anim_frame = 1;
				if (attack_frame == 2)
					anim_frame = 2;
					
				if (attack_frame == 0)
					{
					anim_frame = 3;
			
					attack_phase++;
					attack_frame = 16;
					
					var _hitbox = hitbox_create_melee(0, 0, 1.3, 1.3, 1, 6, 0, 2, 0, 10, SHAPE.circle, 0, FLIPPER.toward_player_center);
					_hitbox.hit_vfx_style = HIT_VFX.normal_weak;
					_hitbox.custom_hitstun = 10;
					_hitbox.hitlag_scaling = 0;
					_hitbox.shieldstun_scaling = 0.1;
					_hitbox.background_clear_allow = false;
					_hitbox.techable = false;
					}
				break;
				}
			//Active
			case 1:
				{
				//Animation
				if (attack_frame == 14)
					anim_frame = 4;
				if (attack_frame == 12)
					anim_frame = 5;
				if (attack_frame == 9)
					anim_frame = 6;
				if (attack_frame == 6)
					anim_frame = 7;
				if (attack_frame == 3)
					anim_frame = 8;
					
				//Multihit
				if (attack_frame > 6 && attack_frame % 2 == 0)
					{
					hitbox_group_reset(0);
					}
				//Final
				else if (attack_frame == 6)
					{
					var _hitbox = hitbox_create_melee(0, 0, 1.5, 1.5, 5, 6, 0.8, 6, 45, 3, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.shieldstun_scaling = 0.2;
					_hitbox.custom_hitstun = 33;
					}
					
				if (attack_frame == 0)
					{
					anim_frame = 9;
					attack_phase++;
					attack_frame = attack_connected() ? 11 : 20;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 15)
					anim_frame = 10;
				if (attack_frame == 10)
					anim_frame = 11;
				if (attack_frame == 5)
					anim_frame = 12;
					
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
}
/* Copyright 2023 Springroll Games / Yosi */