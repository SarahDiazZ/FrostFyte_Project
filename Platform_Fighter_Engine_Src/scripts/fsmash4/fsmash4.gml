function fsmash4() {
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
				anim_sprite = spr_fsmash4;
				anim_frame = 0;
				anim_speed = 0;
		
				charge = 0;
		
				attack_frame = 8;
				return;
				}
			//Charging
			case 0:
				{
				if (attack_frame == 5)
					anim_frame = 1;
				if (attack_frame == 3)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					if ((!input_held(INPUT.smash) && !input_held(INPUT.attack) && !input_held(INPUT.special)) || charge >= smash_attack_charge_max)
						{
						anim_frame = 4;
						attack_phase++;
						attack_frame = 19;
						}
					else
						{
						charge++;
						if (charge % 6 == 0)
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
				if (attack_frame == 15)
					anim_frame = 5;
				if (attack_frame == 11)
					anim_frame = 6;
				if (attack_frame == 7)
					anim_frame = 7;
				if (attack_frame == 3)
					anim_frame = 8;
					
				if (attack_frame == 0)
					{
					anim_frame = 9;
					attack_phase++;
					attack_frame = 8;
					
					//Early hit
					var _damage = calculate_smash_damage(19);
					var _hitbox = hitbox_create_melee(88, -74, 1.5, 0.5, _damage, 5.5, 1, 20, 40, 2, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 27);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.normal_strong];
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.hitstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					_hitbox.post_hit_script = chip_damage_post_hit;
					var _hitbox = hitbox_create_melee(106, -62, 0.8, 1.1, _damage, 5.5, 1, 20, 40, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hitstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					_hitbox.post_hit_script = chip_damage_post_hit;
					var _hitbox = hitbox_create_melee(65, -29, 1.3, 1.4, _damage, 5.5, 1, 20, 40, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hitstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					_hitbox.post_hit_script = chip_damage_post_hit;
					}
				break;
				}
			//Active
			case 2:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 11;
				if (attack_frame == 2)
					anim_frame = 12;
					
				if (attack_frame == 6)
					{
					anim_frame = 10;
					
					//Late hit
					var _damage = calculate_smash_damage(15);
					var _hitbox = hitbox_create_melee(78, -70, 1.5, 1.2, _damage, 5.5, 0.9, 20, 40, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.normal_medium];
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.hitstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					_hitbox.post_hit_script = chip_damage_post_hit;
					}
		
				if (attack_frame == 0)
					{
					anim_frame = 13;
					attack_phase++;
					attack_frame = attack_connected() ? 20 : 30;
					}
				break;
				}
			//Finish
			case 3:
				{
				//Animation
				if (attack_frame <= 26)
					anim_frame = 14;
				if (attack_frame <= 21)
					anim_frame = 15;
				if (attack_frame <= 15)
					anim_frame = 16;
				if (attack_frame <= 8)
					anim_frame = 17;
		
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
}
/* Copyright 2023 Springroll Games / Yosi */