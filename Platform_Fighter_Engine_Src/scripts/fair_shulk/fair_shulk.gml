function fair_shulk() {
	//Forward Aerial
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
				anim_sprite = spr_fair_shulk;
				anim_speed = 0;
				anim_frame = 0;
			
				landing_lag = 10;
				speed_set(0, -1, true, true);
				attack_frame = 7;
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame == 4)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
				
					attack_phase++;
					attack_frame = 5;
					var _hitbox = hitbox_create_melee(38, -32, 1.4, 0.8, 10, 6, 0.8, 6, 48, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.shieldstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Reduced landing lag on hit
				if (attack_connected())
					{
					landing_lag = 4;
					}
				if (attack_frame == 4)
					{
					anim_frame = 3;
					var _hitbox = hitbox_create_melee(62, 8, 1.2, 1.6, 10, 6, 0.8, 6, 48, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.shieldstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				if (attack_frame == 2)
					{
					anim_frame = 4;
					var _hitbox = hitbox_create_melee(32, 36, 1.4, 0.8, 10, 6, 0.8, 6, 48, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.shieldstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				if (attack_frame == 0)
					{
					//Animation
					anim_frame = 5;
					var _hitbox = hitbox_create_melee(-20, 36, 0.5, 0.6, 10, 6, 0.7, 6, 48, 2, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.shieldstun_scaling = 0.5;
				
					attack_phase++;
					attack_frame = attack_connected() ? 12 :  20;
					}
				break;
				}
			//Finish
			case 2:
				{
				if (attack_frame == 10)
					{
					//Animation
					anim_frame = 6;
					//Autocancel
					landing_lag = 6;
					}
			
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