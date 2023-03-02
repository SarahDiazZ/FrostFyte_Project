function fair_cloud() {
	//Forward Aerial
	/*
	- Hold the button to charge the attack longer
	- The fully charged version always spikes opponents and is untechable
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Actions
	friction_gravity(air_friction, grav, max_fall_speed);
	fastfall_attack_try();
	allow_hitfall();
	aerial_drift();
	//Cancels
	if (run && cancel_ground_check()) then run = false;
	//Main Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				anim_sprite = spr_fair_cloud;
				anim_frame = 0;
				anim_speed = 0;
				charge = 0;
				landing_lag = 17;
				speed_set(0, -1, true, true);
				attack_frame = 45;
				return;
				}
			//Active
			case 0:
				{
				//Animation
				if (attack_frame == 34)
					anim_frame = 1;
				if (attack_frame == 27)
					anim_frame = 2;
				if (attack_frame == 17)
					anim_frame = 3;
  
				//Next phase
				if (attack_frame <= 30)
					{
					if ((!input_held(INPUT.attack) && !input_held(INPUT.smash)) || attack_frame == 0)
						{
						anim_frame = 4;
						attack_phase++;
						attack_frame = 3;
						}
					else
						{
						charge++;
						if (charge == 15)
							{
							vfx_create(spr_shine_fastfall, 1, 0, 14, x - (32 * facing), y + 48, 2, 0);
							}
						}
					}
				break;
				}
			//Endlag
			case 1:
				{
				//Animation
				if (attack_frame == 2)
					anim_frame = 5;
				
				//Hitbox
				if (attack_frame == 0)
					{
					anim_frame = 6;
					if (charge < 30)
						{
						var _damage = floor(lerp(11, 13, charge / 30));
						
						//Sweetspot Hitbox
						var _hitbox = hitbox_create_melee(60, 26, 0.4, 0.4, _damage, 4, 0.9, 15, 285, 1, SHAPE.circle, 0);
						_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
						_hitbox.hit_sfx = snd_hit_strong;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						_hitbox.hit_restriction = HIT_RESTRICTION.aerial_only;
						var _hitbox = hitbox_create_melee(60, 26, 0.4, 0.4, _damage, 4, 0.9, 15, 285, 1, SHAPE.circle, 0);
						_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
						_hitbox.hit_sfx = snd_hit_strong2;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						_hitbox.hit_restriction = HIT_RESTRICTION.grounded_only;
						_hitbox.techable = false;
						
						//Normal Hitbox
						var _hitbox = hitbox_create_melee(60, 4, 0.9, 1.9, _damage, 7, 0.9, 15, 45, 2, SHAPE.circle, 0);
						_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
						_hitbox.hit_sfx = snd_hit_strong2;
						_hitbox.shieldstun_scaling = 0.5;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						}
					else
						{
						//Use the larger animation
						anim_frame += 8;
						
						//Spike Only Hitbox
						var _hitbox = hitbox_create_melee(66, 0, 1.1, 2.1, 14, 6, 1.1, 20, 285, 2, SHAPE.circle, 0);
						_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
						_hitbox.hit_sfx = snd_hit_strong;
						_hitbox.techable = false;
						_hitbox.di_angle = 5;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						}
					attack_phase++;
					attack_frame = 8;
					}
				break;
				}
			//Active
			case 2:
				{
				if (attack_frame == 7)
					{
					anim_frame++;
					if (charge < 30)
						{
						var _damage = floor(lerp(11, 13, charge / 30));
						//Normal Hitbox
						var _hitbox = hitbox_create_melee(38, 48, 0.8, 0.9, _damage, 7, 0.9, 13, 45, 1, SHAPE.circle, 0);
						_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.slash_medium];
						_hitbox.hit_sfx = snd_hit_strong;
						_hitbox.shieldstun_scaling = 0.5;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						}
					else
						{
						//Stronger Hitbox
						var _hitbox = hitbox_create_melee(44, 50, 1.2, 1.2, 14, 7, 0.9, 13, 45, 1, SHAPE.circle, 0);
						_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.slash_medium];
						_hitbox.hit_sfx = snd_hit_strong;
						_hitbox.shieldstun_scaling = 0.5;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						}
					}
				
				if (attack_frame == 6)
					{
					anim_frame++;
					if (charge < 30)
						{
						var _damage = floor(lerp(7, 11, charge / 30));
						//Normal Hitbox
						var _hitbox = hitbox_create_melee(39, 49, 0.8, 0.3, _damage, 6, 0.8, 10, 45, 6, SHAPE.rotation, 0, FLIPPER.sakurai);
						hitbox_sprite_angle_set(_hitbox, 313);
						_hitbox.hit_vfx_style = [HIT_VFX.normal_strong];
						_hitbox.hit_sfx = snd_hit_weak2;
						_hitbox.shieldstun_scaling = 0.5;
						}
					else
						{
						//Stronger Hitbox
						var _hitbox = hitbox_create_melee(43, 53, 1, 0.3, 19, 6, 0.8, 10, 45, 6, SHAPE.rotation, 0, FLIPPER.sakurai);
						hitbox_sprite_angle_set(_hitbox, 313);
						_hitbox.hit_vfx_style = [HIT_VFX.normal_strong];
						_hitbox.hit_sfx = snd_hit_weak2;
						_hitbox.shieldstun_scaling = 0.5;
						}
					}
			
				if (attack_frame == 4)
					anim_frame++;
			
				if (attack_frame == 0)
					{
					//Whiff lag
					attack_phase++;
					if (charge < 30)
						{
						attack_frame = attack_connected() ? 15 : 25;
						}
					else
						{
						attack_frame = attack_connected() ? 5 : 15;
						}
					}
				break;
				}
			//Finish
			case 3:
				{
				//Animation
				if (attack_frame == 20)
					anim_frame++;
				if (attack_frame == 10)
					{
					anim_frame++;
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