function fsmash_combat() {
	//Forward Smash
	/*
	- Hold upwards when releasing to perform a stronger but slower uppercut
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	friction_gravity(ground_friction, grav, max_fall_speed);

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
				anim_sprite = spr_fsmash_combat;
				anim_frame = 0;
				anim_speed = 0;
		
				charge = 0;
		
				attack_frame = 5;
				
				hurtbox_anim_match(spr_fsmash_combat_hurtbox);
				return;
				}
			//Charging
			case 0:
				{
				if (attack_frame == 3)
					anim_frame = 1;
				
				if (attack_frame == 0)
					{
					if ((!input_held(INPUT.smash) && !input_held(INPUT.attack) && !input_held(INPUT.special)) || charge >= smash_attack_charge_max)
						{
						if (stick_get_value(Lstick, DIR.up) > stick_flick_amount)
							{
							attack_phase = 4;
							attack_frame = 14;
							}
						else
							{
							attack_phase = 1;
							attack_frame = 10;
							}
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
			//Hitbox - Forward
			case 1:
				{
				if (attack_frame == 7)
					anim_frame = 2;
				if (attack_frame == 4)
					anim_frame = 3;
			
				if (attack_frame == 0)
					{
					anim_frame = 4;
					attack_phase++;
					attack_frame = 10;
				
					var _damage = calculate_smash_damage(14);
					var _hitbox = hitbox_create_melee(20, 0, 0.8, 0.4, _damage, 6.5, 1.3, 4, 45, 4, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
				
					var _damage = calculate_smash_damage(17);
					var _hitbox = hitbox_create_melee(48, 0, 0.8, 0.8, _damage, 6.5, 1.4, 12, 45, 4, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.explosion, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Active - Forward
			case 2:
				{
				if (attack_frame == 8)
					anim_frame = 5;
				if (attack_frame == 4)
					anim_frame = 6;
				
				if (attack_frame == 0)
					{
					anim_frame = 7;
					attack_phase++;
					attack_frame = attack_connected() ? 10 : 20;
					}
				break;
				}
			//Finish - Forward
			case 3:
				{
				//Animation
				if (attack_frame == 13)
					anim_frame = 8;
				if (attack_frame <= 7)
					anim_frame = 9;
		
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					run = false;
					}
				break;
				}
			//Hitbox - Up
			case 4:
				{
				if (attack_frame == 9)
					anim_frame = 10;
				if (attack_frame == 4)
					anim_frame = 11;
			
				if (attack_frame == 0)
					{
					anim_frame = 12;
					attack_phase++;
					attack_frame = 6;
				
					var _damage = calculate_smash_damage(15);
					var _hitbox = hitbox_create_melee(30, 0, 0.6, 0.8, _damage, 3, 2, 13, 85, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.shieldstun_scaling = 2;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Active - Up
			case 5:
				{
				if (attack_frame == 4)
					{
					anim_frame = 13;
				
					var _damage = calculate_smash_damage(13);
					var _hitbox = hitbox_create_melee(26, -32, 0.6, 0.8, _damage, 3, 1.5, 12, 85, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					}
				
				if (attack_frame == 2)
					{
					anim_frame = 14;
				
					var _damage = calculate_smash_damage(11);
					var _hitbox = hitbox_create_melee(24, -60, 0.5, 0.5, _damage, 3, 1.5, 11, 85, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_weak;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 15;
					attack_phase++;
					attack_frame = 25;
					}
				break;
				}
			//Finish - Up
			case 6:
				{
				//Animation
				if (attack_frame == 22)
					anim_frame = 16;
				if (attack_frame == 19)
					anim_frame = 17;
				if (attack_frame == 13)
					anim_frame = 18;
				if (attack_frame == 5)
					anim_frame = 19;
		
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					run = false;
					}
				break;
				}
			}
		}
	
	//Movement
	move_grounded();
	
	//Hurtbox
	if (run)
		{
		hurtbox_anim_match(spr_fsmash_combat_hurtbox);
		}
}
/* Copyright 2023 Springroll Games / Yosi */