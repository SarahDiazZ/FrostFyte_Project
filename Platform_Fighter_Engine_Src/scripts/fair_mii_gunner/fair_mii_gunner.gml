function fair_mii_gunner() {
	//Forward Aerial
	/*
	- Shoots out a projectile forward while sending you backwards
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
	fastfall_attack_try();
	aerial_drift_momentum();
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
				anim_sprite = spr_fair_mii_gunner;
				anim_speed = 0;
				anim_frame = 0;
			
				landing_lag = 10;
				speed_set(0, -1, true, true);
				attack_frame = 10;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 1;
				if (attack_frame == 6)
					anim_frame = 2;
				if (attack_frame == 3)
					anim_frame = 3;
				
				
				if (attack_frame == 0)
					{
					anim_frame = 4;
			
					attack_phase++;
					attack_frame = 30;
					//Momentum backwards
					speed_set(-6 * facing, 0, true, true);
					//Melee hit
					var _hitbox = hitbox_create_melee(40, 0, 0.7, 0.6, 5, 9, 0.55, 8, 45, 4, SHAPE.circle, 0, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					//Projectile
					var _proj = hitbox_create_projectile(48, 0, 0.5, 0.5, 8, 6, 0.9, 45, 13, SHAPE.circle, 10, 0);
					hitbox_overlay_sprite_set(_proj, spr_fair_mii_gunner_projectile, 0, 1, 2, 0, c_white, 1, facing);
					_proj.hit_vfx_style = HIT_VFX.normal_weak;
					_proj.destroy_on_blocks = true;
					}
				break;
				}
			//Finish
			case 1:
				{
				//Whiff lag
				if (attack_frame > 5 && attack_connected())
					attack_frame = 5;
				
				//Animation
				if (attack_frame == 29)
					anim_frame = 5;
				if (attack_frame == 26)
					anim_frame = 6;
				if (attack_frame == 21)
					anim_frame = 7;
				if (attack_frame == 17)
					anim_frame = 8;
				if (attack_frame == 11)
					anim_frame = 9;
				if (attack_frame == 5)
					anim_frame = 10;
			
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