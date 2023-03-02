function nair_joker() {
	//Neutral Aerial
	/*
	- Jump cancelable on hit
	*/
	//Logic Control Variable
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Actions
	friction_gravity(air_friction, grav, max_fall_speed);
	fastfall_attack_try();
	aerial_drift();
	allow_hitfall();
	//Cancels
	if (run && cancel_ground_check()) then run = false;
	//Main Phases
	if (run)
		{
		switch(_phase)
			{
			//Initialize
			case PHASE.start:
				{
				anim_sprite = spr_nair_joker;
				anim_speed = 0;
				anim_frame = 0;
			
				landing_lag = 8;
				attack_frame = 8;
				speed_set(0, -1, true, true);
				return;
				}
			//Startup
			case 0:
				{
				if (attack_frame == 5)
					anim_frame = 1;

				if (attack_frame == 0)
					{
					anim_frame = 2;
					var _hitbox = hitbox_create_melee(-38, -24, 0.3, 0.3, 7, 6, 0.4, 3, 50, 2, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					var _hitbox = hitbox_create_melee(0, 0, 0.6, 0.6, 7, 6, 0.4, 3, 50, 8, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					attack_frame = 8;
					attack_phase++;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 7)
					{
					anim_frame = 3;
					var _hitbox = hitbox_create_melee(2, -42, 0.5, 0.5, 7, 6, 0.4, 3, 50, 2, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					}
				if (attack_frame == 6)
					{
					anim_frame = 4;
					var _hitbox = hitbox_create_melee(40, -20, 0.5, 0.5, 7, 6, 0.4, 3, 50, 2, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					}
				if (attack_frame == 5)
					{
					anim_frame = 5;
					var _hitbox = hitbox_create_melee(40, 8, 0.5, 0.5, 7, 6, 0.4, 3, 50, 3, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					}
				if (attack_frame == 4)
					{
					anim_frame = 6;
					var _hitbox = hitbox_create_melee(10, 42, 0.5, 0.5, 4, 6, 0.4, 3, 50, 2, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					}
				if (attack_frame == 2)
					{
					anim_frame = 7;
					var _hitbox = hitbox_create_melee(-26, 44, 0.4, 0.4, 4, 6, 0.4, 3, 50, 2, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 8;
					if (attack_connected())
						{
						attack_frame = 7;
						landing_lag = 4;
						}
					else
						{
						attack_frame = 20;
						}
					attack_phase++;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame == 18)
					anim_frame = 9;
				if (attack_frame == 14)
					anim_frame = 10;
				if (attack_frame == 10)
					anim_frame = 11;
				if (attack_frame == 6)
					anim_frame = 12;
				if (attack_frame == 2)
					anim_frame = 13;
			
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