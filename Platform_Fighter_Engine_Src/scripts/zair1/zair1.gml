function zair1() {
	//Aerial Tether for character1
	/*
	- Grabs ledges when the ledge tether conditions are met
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
	aerial_drift();
	fastfall_attack_try();
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
				anim_sprite = spr_zair1;
				anim_speed = 0;
				anim_frame = 0;
				landing_lag = 12;
				speed_set(0, -1, true, true);
				attack_frame = 9;
				return;
				}
			//Startup -> Active
			case 0:
				{
				//Tether
				if (attack_frame == 1)
					{
					if (check_ledge_tether(280)) break;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 1;
					attack_phase++;
					attack_frame = 18;
					var _hitbox = hitbox_create_melee(36, 0, 0.8, 0.2, 1, 4, 0.4, 5, 90, 6, SHAPE.square, 0, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = HIT_VFX.electric_weak;
					_hitbox.can_lock = true;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				//Multiple Hitboxes
				if (attack_frame == 15)
					{
					anim_frame = 2;
					var _hitbox = hitbox_create_melee(78, 0, 0.8, 0.2, 1, 7, 0.3, 4, 90, 6, SHAPE.square, 0, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = HIT_VFX.electric_weak;
					_hitbox.can_lock = true;
					}
				if (attack_frame == 13)
					{
					anim_frame = 3;
					var _hitbox = hitbox_create_melee(114, 0, 0.8, 0.2, 1, 6, 0.25, 4, 90, 6, SHAPE.square, 0, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = HIT_VFX.electric_weak;
					_hitbox.can_lock = true;
					}
				if (attack_frame == 10)
					{
					anim_frame = 4;
					var _hitbox = hitbox_create_melee(128, 0, 0.8, 0.2, 1, 5, 0.2, 4, 90, 6, SHAPE.square, 0, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = HIT_VFX.electric_weak;
					_hitbox.can_lock = true;
					}
				if (attack_frame == 8)
					{
					anim_frame = 5;
					var _hitbox = hitbox_create_melee(140, 0, 0.8, 0.2, 1, 4, 0.15, 4, 90, 6, SHAPE.square, 0, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = HIT_VFX.electric_weak;
					_hitbox.can_lock = true;
					}
				if (attack_frame == 0)
					{
					anim_frame = 6;
				
					attack_phase++;
					//Whiff lag
					attack_frame = attack_connected() ? 12 : 18;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 9)
					anim_frame = 7;
				if (attack_frame == 5)
					anim_frame = 8;
				
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