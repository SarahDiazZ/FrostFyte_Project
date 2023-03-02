function fsmash_chrom() {
	//Forward Smash
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
				anim_sprite = spr_fsmash_chrom;
				anim_frame = 0;
				anim_speed = 0;
		
				charge = 0;
		
				attack_frame = 6;
				
				hurtbox_anim_match(spr_fsmash_chrom_hurtbox);
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
						anim_frame = 4;
						attack_phase++;
						attack_frame = 7;
						speed_set(3 * facing, 0, false, false);
						}
					else
						{
						charge++;
						if (charge % 8 == 0)
							{
							if (anim_frame == 2)
								anim_frame = 3;
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
			//Startup
			case 1:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 5;
				if (attack_frame == 2)
					anim_frame = 6;
					
				if (attack_frame == 0)
					{
					anim_frame = 7;
					attack_phase++;
					attack_frame = 8;
					
					//*Chrom
					var _damage = calculate_smash_damage(17);
					var _hitbox = hitbox_create_melee(43, -29, 1.4, 1, _damage, 5.5, 1, 23, 40, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.shieldstun_scaling = 0.1;
					_hitbox.hitstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					var _hitbox = hitbox_create_melee(73, -21, 1.2, 0.9, _damage, 5.5, 1, 23, 40, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.shieldstun_scaling = 0.1;
					_hitbox.hitstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					//*/
					
					/*Roy
					var _damage = calculate_smash_damage(20);
					var _hitbox = hitbox_create_melee(43, -15, 0.7, 0.9, _damage, 7, 1, 20, 40, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.normal_strong];
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.hitstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					var _damage = calculate_smash_damage(10);
					var _hitbox = hitbox_create_melee(66, -22, 1.3, 0.9, _damage, 6, 0.9, 5, 45, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_weak, HIT_VFX.normal_weak];
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.shieldstun_scaling = 0.1;
					_hitbox.hitstun_scaling = 0.5;
					//*/
					}
				break;
				}
			//Active
			case 2:
				{
				if (attack_frame == 7)
					{
					anim_frame = 8;
					
					//*Chrom
					var _damage = calculate_smash_damage(17);
					var _hitbox = hitbox_create_melee(101, 0, 0.5, 0.7, _damage, 5.5, 1, 23, 40, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.shieldstun_scaling = 0.1;
					_hitbox.hitstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					var _hitbox = hitbox_create_melee(70, -17, 1.3, 1, _damage, 5.5, 1, 23, 40, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.shieldstun_scaling = 0.1;
					_hitbox.hitstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					//*/
					
					/*Roy
					var _damage = calculate_smash_damage(20);
					var _hitbox = hitbox_create_melee(44, 2, 0.7, 0.5, _damage, 7, 1, 20, 40, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.normal_strong];
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.hitstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					var _damage = calculate_smash_damage(10);
					var _hitbox = hitbox_create_melee(66, -22, 1.3, 0.9, _damage, 6, 0.9, 5, 45, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_weak, HIT_VFX.normal_weak];
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.shieldstun_scaling = 0.1;
					_hitbox.hitstun_scaling = 0.5;
					//*/
					}
				
				//Animation
				if (attack_frame == 6)
					anim_frame = 9;
				if (attack_frame == 3)
					anim_frame = 10;
		
				if (attack_frame == 0)
					{
					anim_frame = 11;
					attack_phase++;
					attack_frame = attack_connected() ? 20 : 30;
					}
				break;
				}
			//Finish
			case 3:
				{
				//Animation
				if (attack_frame <= 20)
					anim_frame = 12;
				if (attack_frame <= 10)
					anim_frame = 13;
		
				if (attack_frame == 0)
					{
					attack_stop(PLAYER_STATE.idle);
					run = false;
					}
				break;
				}
			}
		}
		
	//Hurtbox
	if (run)
		{
		hurtbox_anim_match(spr_fsmash_chrom_hurtbox);
		}
	
	//Movement
	move_grounded();
}
/* Copyright 2023 Springroll Games / Yosi */