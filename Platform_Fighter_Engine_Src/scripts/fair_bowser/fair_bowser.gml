function fair_bowser() {
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
	if (run && cancel_ground_check())
		{
		camera_shake(0, 5);
		run = false;
		}
	
	//Properties
	var _tipper_damage = 13;
	var _normal_damage = 6;
	
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_fair_bowser;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 10;
				landing_lag = 14;
				speed_set(0, -1, true, true);
				
				hurtbox_anim_match(spr_fair_bowser_hurtbox);
				return;
				}
			//Startup
			case 0:
				{
				//Animation
				if (attack_frame == 6)
					anim_frame = 1;
				if (attack_frame == 2)
					anim_frame = 2;
					
				if (attack_frame == 0)
					{
					anim_frame = 3;
			
					attack_phase++;
					attack_frame = 8;
					
					//Tipper
					var _hitbox = hitbox_create_melee(28, -52, 0.45, 0.45, _tipper_damage, 5, 1.1, 12, 40, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Active
			case 1:
				{
				if (attack_frame == 7)
					{
					anim_frame = 4;
					
					//Inside
					var _hitbox = hitbox_create_melee(46, -18, 0.7, 1.0, _normal_damage, 8, 0.8, 5, 45, 1, SHAPE.circle, 0, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak;
					_hitbox.can_lock = true;
					
					//Tippers
					var _hitbox = hitbox_create_melee(70, -10, 0.5, 0.7, _tipper_damage, 5, 1.1, 12, 40, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					var _hitbox = hitbox_create_melee(54, -32, 0.6, 0.7, _tipper_damage, 5, 1.1, 12, 40, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
					
				if (attack_frame == 6)
					{
					anim_frame = 5;
					
					//Inside
					var _hitbox = hitbox_create_melee(54, 0, 0.6, 1.2, _normal_damage, 8, 0.8, 5, 45, 1, SHAPE.circle, 0, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak;
					_hitbox.can_lock = true;
					
					//Tipper
					var _hitbox = hitbox_create_melee(65, 0, 0.7, 1.4, _tipper_damage, 5, 1.1, 12, 40, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
					
				if (attack_frame == 5)
					{
					anim_frame = 6;
					
					//Inside
					var _hitbox = hitbox_create_melee(27, 39, 1.1, 0.8, _normal_damage, 8, 0.8, 5, 45, 2, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak;
					_hitbox.can_lock = true;
					}
				
				//Animation
				if (attack_frame == 3)
					anim_frame = 7;
					
				//Reduce landing lag on hit
				if (attack_connected())
					{
					landing_lag = 8;
					}
					
				if (attack_frame == 0)
					{
					anim_frame = 8;
					attack_phase++;
					attack_frame = attack_connected() ? 15 : 25;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Animation
				if (attack_frame <= 20)
					anim_frame = 9;
				if (attack_frame <= 10)
					anim_frame = 10;
				
				//Autocancel
				if (attack_frame < 15)
					landing_lag = 4;
					
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
		hurtbox_anim_match(spr_fair_bowser_hurtbox);
		}
}
/* Copyright 2023 Springroll Games / Yosi */