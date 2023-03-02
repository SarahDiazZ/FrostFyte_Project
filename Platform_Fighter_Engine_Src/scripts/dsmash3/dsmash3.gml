function dsmash3() {
	//Down Smash for character3
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
				anim_sprite = spr_dsmash3;
				anim_frame = 0;
				anim_speed = 0;
		
				charge = 0;
		
				attack_frame = 8;
				
				hurtbox_anim_match(spr_dsmash3_hurtbox);
				return;
				}
			//Charging
			case 0:
				{
				//Charging
				if (attack_frame == 0)
					{
					//Animation (every 8 frames switch the sprite)
					if (charge % 8 == 0)
						{
						if (anim_frame == 1)
							{
							anim_frame = 2;
							}
						else
							{
							anim_frame = 1;
						
							//Shine VFX
							vfx_create(spr_shine_attack, 1, 0, 8, x + prng_number(0, 20, -20), y + prng_number(1, 20, -20), 1, prng_number(0, 360));
							}
						}
						
					charge++;
					if (charge >= smash_attack_charge_max || (!input_held(INPUT.smash) && !input_held(INPUT.attack) && !input_held(INPUT.special)))
						{
						anim_frame = 3;
						attack_phase++;
						attack_frame = 9;
						}
					}
				break;
				}
			//Startup
			case 1:
				{
				if (attack_frame == 0)
					{
					anim_frame = 4;
				
					attack_phase++;
					attack_frame = 38;
					
					camera_shake(0, 7);
					
					//Ledge hitbox
					var _damage = calculate_smash_damage(18);
					var _hitbox = hitbox_create_melee(0, 28, 1.6, 0.5, _damage, 8, 1.2, 11, 40, 1, SHAPE.square, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.hit_restriction = HIT_RESTRICTION.ledge_only;
					
					//Early hit
					var _hitbox = hitbox_create_melee(0, 18, 1.6, 0.5, _damage, 8, 1.2, 11, 40, 1, SHAPE.square, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.custom_shield_damage = 45;
					}
				break;
				}
			//Active
			case 2:
				{
				//Late hit
				if (attack_frame == 37)
					{
					anim_frame = 5;
					var _damage = calculate_smash_damage(14);
					var _hitbox = hitbox_create_melee(-4, 24, 2.5, 0.2, _damage, 8, 1.1, 10, 40, 2, SHAPE.square, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.custom_shield_damage = 45;
					}
					
				//Animation
				if (attack_frame == 35)
					anim_frame = 6;
				if (attack_frame == 30)
					anim_frame = 7;
				if (attack_frame == 24)
					anim_frame = 8;
				if (attack_frame == 16)
					anim_frame = 9;
				if (attack_frame == 8)
					anim_frame = 10;
					
				if (attack_frame == 0)
					{
					attack_stop();
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
		hurtbox_anim_match(spr_dsmash3_hurtbox);
		}
}
/* Copyright 2023 Springroll Games / Yosi */