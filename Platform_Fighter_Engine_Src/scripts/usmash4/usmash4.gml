function usmash4() {
	//Down Smash
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
				anim_sprite = spr_usmash4;
				anim_frame = 0;
				anim_speed = 0;
		
				charge = 0;
		
				attack_frame = 9;
				return;
				}
			//Charging
			case 0:
				{
				//Animation (every 7 frames switch the sprite)
				if (charge % 7 == 0)
					{
					if (anim_frame == 1)
						anim_frame = 0;
					else
						{
						anim_frame = 1;
						
						//Shine VFX
						vfx_create(spr_shine_attack, 1, 0, 8, x + prng_number(0, 20, -20), y + prng_number(1, 20, -20), 1, prng_number(0, 360));
						}
					}
			
				charge++;
				if ((charge >= smash_attack_charge_max || (!input_held(INPUT.smash) && !input_held(INPUT.attack) && !input_held(INPUT.special))) && attack_frame == 0)
					{
					anim_frame = 2;
					attack_phase++;
					attack_frame = 30;
				
					//Linking hit
					var _hitbox = hitbox_create_magnetbox(18, -4, 0.6, 0.9, 0, 6, 2, -36, 10, 6, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					}
				break;
				}
			//Attacking
			case 1:
				{
				if (attack_frame == 28)
					{
					anim_frame = 3;
					
					//Multihits
					var _hitbox = hitbox_create_melee(2, -42, 1.4, 0.6, 1, 6, 0, 1, 0, 23, SHAPE.square, 1, FLIPPER.toward_hitbox_center);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.techable = false;
					_hitbox.asdi_multiplier = 0;
					_hitbox.di_angle = 0;
					_hitbox.background_clear_allow = false;
					_hitbox.hitlag_scaling = 0;
					}
				
				if (attack_frame > 5)
					{
					//Reset hitbox
					if (attack_frame % 4 == 0)
						{
						hitbox_group_reset(1);
						}
						
					//Animation
					if (attack_frame % 3 == 0)
						{
						anim_frame++;
						if (anim_frame > 12)
							{
							anim_frame = 6;
							}
						}
					}
				
				//Final hit
				if (attack_frame == 5)
					{
					anim_frame = 11;
					
					var _damage = calculate_smash_damage(5);
					var _hitbox = hitbox_create_melee(2, -42, 1.4, 0.6, _damage, 8, 1.2, 3, 80, 5, SHAPE.square, 2);
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					}
		
				if (attack_frame == 0)
					{
					anim_frame = 12;
					
					attack_phase++;
					attack_frame = attack_connected() ? 16 : 28;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 22)
					anim_frame = 13;
				if (attack_frame == 14)
					anim_frame = 14;
				if (attack_frame == 7)
					anim_frame = 15;
		
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