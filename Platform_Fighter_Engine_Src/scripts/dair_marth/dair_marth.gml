function dair_marth() {
	//Downward Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
	fastfall_try();
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
				anim_sprite = spr_dair_marth;
				anim_speed = 0;
				anim_frame = 0;
		
				landing_lag = 14;
				speed_set(0, -1, true, true);
				attack_frame = 9;
				return;
				}
			//Startup
			case 0:
				{
				if (attack_frame == 0)
					{
					anim_frame = 1;
					attack_phase++;
					attack_frame = 6;
					var _hitbox = hitbox_create_melee(32, -28, 0.6, 0.5, 10, 6, 0.7, 6, 290, 2, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 5)
					{
					anim_frame = 2;
					var _hitbox = hitbox_create_melee(30, 26, 0.7, 0.8, 10, 6, 0.7, 6, 290, 2, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					var _hitbox = hitbox_create_melee(45, 0, 0.7, 0.7, 10, 6, 0.7, 6, 290, 2, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					}
				if (attack_frame == 4)
					{
					anim_frame = 3;
					var _hitbox = hitbox_create_melee(-18, 32, 1, 0.7, 10, 6, 0.7, 5, 290, 2, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					}
				if (attack_frame == 3)
					{
					anim_frame = 4;
					var _hitbox = hitbox_create_melee(-48, -4, 0.6, 0.7, 10, 6, 0.7, 5, 290, 4, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					}
				if (attack_frame == 0)
					{
					anim_frame = 5;
					attack_phase++;
					attack_frame = attack_connected() ? 20 : 32;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 13)
					anim_frame = 6;
				
				//Autocancel
				if (attack_frame < 10)
					{
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