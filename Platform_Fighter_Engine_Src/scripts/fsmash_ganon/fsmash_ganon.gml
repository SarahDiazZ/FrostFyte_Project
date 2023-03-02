function fsmash_ganon() {
	//Forward Smash
	/*
	- Fully charge for a shockwave hitbox
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(slide_friction, grav, max_fall_speed);

	//Canceling
	if (run && cancel_air_check()) then run = false;

	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_fsmash_ganon;
				anim_frame = 0;
				anim_speed = 0;
		
				charge = 0;
		
				attack_frame = 17;
				return;
				}
			//Charging
			case 0:
				{
				if (attack_frame == 15)
					anim_frame = 1;
				if (attack_frame == 10)
					anim_frame = 2;
				if (attack_frame == 5)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					if ((!input_held(INPUT.smash) && !input_held(INPUT.attack) && !input_held(INPUT.special)) || charge >= smash_attack_charge_max)
						{
						attack_phase++;
						attack_frame = 8;
						}
					else
						{
						charge++;
						if (charge % 8 == 0)
							{
							if (anim_frame == 2)
								anim_frame = 1;
							else
								{
								anim_frame = 2;
								
								//Shine VFX
								vfx_create(spr_shine_attack, 1, 0, 8, x + prng_number(0, 20, -20), y + prng_number(1, 20, -20), 1, prng_number(0, 360));
								}
							}
						}
					}
				break;
				}
			//Hitbox
			case 1:
				{
				if (attack_frame == 0)
					{
					anim_frame = 3;
					attack_phase++;
					attack_frame = 8;
					var _damage = calculate_smash_damage(16);
					var _hitbox = hitbox_create_melee(-8, -32, 1, 0.8, _damage, 4, 2, 15, 60, 3, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.shieldstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Second Hitbox
			case 2:
				{
				if (attack_frame == 6)
					{
					anim_frame = 4;
					var _damage = calculate_smash_damage(20);
					var _hitbox = hitbox_create_melee(32, -20, 2, 0.8, _damage, 8, 1.2, 15, 45, 3, SHAPE.circle, 0, FLIPPER.sakurai);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.extra_hitlag = 5;
					_hitbox.shieldstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.custom_hitstun = 35;
					}
				
				if (attack_frame == 4)
					{
					anim_frame = 5;
					if (charge >= smash_attack_charge_max)
						{
						var _hitbox = hitbox_create_melee(42, 0, 2, 0.8, 50, 8, 1.2, 20, 35, 4, SHAPE.circle, 2);
						_hitbox.hit_vfx_style = [HIT_VFX.explosion, HIT_VFX.normal_strong];
						_hitbox.hit_sfx = snd_hit_explosion2;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						var _hitbox = hitbox_create_melee(48, 24, 4, 0.2, 5, 8, 0.7, 6, 90, 4, SHAPE.square, 2);
						_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
						_hitbox.hit_sfx = snd_hit_explosion;
						}
					else
						{
						var _damage = calculate_smash_damage(20);
						var _hitbox = hitbox_create_melee(42, 0, 2, 0.8, _damage, 8, 1, 20, 45, 4, SHAPE.circle, 0, FLIPPER.sakurai);
						_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
						_hitbox.hit_sfx = snd_hit_strong2;
						_hitbox.shieldstun_scaling = 0.5;
						_hitbox.knockback_state = PLAYER_STATE.balloon;
						_hitbox.custom_hitstun = 35;
						}
					}
				
				if (attack_frame == 2)
					{
					anim_frame = 6;
					}
		
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = attack_connected() ? 18 : 24;
					}
				break;
				}
			//Finish
			case 3:
				{
				//Animation
				if (attack_frame == 18)
					anim_frame = 6;
				if (attack_frame == 13)
					anim_frame = 7;
				if (attack_frame == 7)
					anim_frame = 8;
		
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					}
				break;
				}
			}
		}
	
	//Movement
	move_grounded();
}
/* Copyright 2023 Springroll Games / Yosi */