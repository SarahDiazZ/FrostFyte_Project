function bair5() {
	//Back Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
	fastfall_try();
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
				anim_sprite = spr_bair5;
				anim_speed = 0;
				anim_frame = 0;
				landing_lag = 5;
				speed_set(30 * facing, 0, false, false);
				attack_frame = 1;
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame == 1)
					anim_frame = 0;
				
				if (attack_frame == 0)
					{
					anim_frame = 1;
			
					attack_phase++;
					attack_frame = 4;
					
					//Initial hit
					var _hitbox = hitbox_create_melee(-13, 5, .29, .14, 9, 10, 1, 2, 180, 4, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.di_angle = 0;
					_hitbox.drift_di_multiplier = 0;
					_hitbox.asdi_multiplier = 0;
					_hitbox.techable = false;
					_hitbox.background_clear_allow = false;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 0)
					{
					anim_frame = 1;
				
					attack_phase++;
					//Whiff lag
					attack_frame = attack_connected() ? 7 : 16;
					}
				break;
				}
			//Finish
			case 2:
				{
				if (attack_frame == 11)
					anim_frame = 3;
				if (attack_frame == 5)
					anim_frame = 4;
				//Animation
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