function uair4() {
	//Up Aerial
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(air_friction, grav, max_fall_speed);
	allow_hitfall();
	fastfall_attack_try();
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
				anim_sprite = spr_uair4;
				anim_speed = 0;
				anim_frame = 0;
			
				landing_lag = 10;
				attack_frame = 11;
				speed_set(0, -1, true, true);
				return;
				}
			//Startup -> Active
			case 0:
				{
				if (attack_frame == 7)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 6;
					
					//Center hit
					var _hitbox = hitbox_create_melee(0, -26, 1.3, 0.7, 6, 8, 0.6, 10, 65, 3, SHAPE.circle, 0);
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					
					//Early spiking hitboxes
					var _hitbox = hitbox_create_melee(40, 0, 0.5, 0.8, 10, 7, 0.8, 15, 315, 3, SHAPE.square, 0);
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.hit_restriction = HIT_RESTRICTION.aerial_only;
					var _hitbox = hitbox_create_melee(40, 0, 0.5, 0.8, 10, 9, 0.8, 15, 290, 3, SHAPE.square, 0);
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
					_hitbox.techable = false;
					}
				break;
				}
			//Active -> Endlag
			case 1:
				{
				if (attack_frame == 3)
					{
					anim_frame = 3;
					
					//Late spiking hitboxes
					var _hitbox = hitbox_create_melee(40, 10, 0.5, 0.8, 6, 6, 0.6, 10, 315, 3, SHAPE.square, 0);
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_restriction = HIT_RESTRICTION.aerial_only;
					var _hitbox = hitbox_create_melee(40, 10, 0.5, 0.8, 6, 6, 0.6, 10, 290, 3, SHAPE.square, 0);
					_hitbox.hit_sfx = snd_hit_weak;
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
					_hitbox.techable = false;
					}

				if (attack_frame == 0)
					{
					anim_frame = 4;
			
					attack_phase++;
					attack_frame = 15;
					landing_lag = 5;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 12)
					anim_frame = 5;
				if (attack_frame == 8)
					anim_frame = 6;
				if (attack_frame == 4)
					anim_frame = 7;
					
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