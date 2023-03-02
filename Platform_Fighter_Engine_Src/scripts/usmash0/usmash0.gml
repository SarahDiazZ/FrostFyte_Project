function usmash0() {
	//Up Smash for character0
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
				anim_sprite = spr_usmash0;
				anim_frame = 0;
				anim_speed = 0;
		
				charge = 0;
		
				attack_frame = 2;
				return;
				}
			//Charging -> Startup
			case 0:
				{
				//Animation (every 8 frames switch the sprite)
				if (charge % 8 == 0)
					{
					if (anim_frame == 0)
						anim_frame = 1;
					else
						{
						anim_frame = 0;
						
						//Shine VFX
						vfx_create(spr_shine_attack, 1, 0, 8, x + prng_number(0, 20, -20), y + prng_number(1, 20, -20), 1, prng_number(0, 360));
						}
					}
			
				if (attack_frame == 0)
					{
					charge++;
					if (charge >= smash_attack_charge_max || (!input_held(INPUT.smash) && !input_held(INPUT.attack) && !input_held(INPUT.special)))
						{
						attack_phase++;
						attack_frame = 4;
						}
					}
				break;
				}
			//Startup -> Attack
			case 1:
				{
				//Animation
				anim_frame = 1;
		
				//Attack First Part
				if (attack_frame == 0)
					{
					anim_frame = 2;
			
					attack_phase++;
					attack_frame = 2;
					var _damage = calculate_smash_damage(15);
					var _hitbox = hitbox_create_melee(35, -5, 0.5, 0.6, _damage, 11, 1.2, 8, 75, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.shieldstun_scaling = 0.5;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
				break;
				}
			//Attack -> Attack
			case 2:
				{
				//Attack Second Part
				if (attack_frame == 1)
					{
					anim_frame = 3;
				
					var _damage = calculate_smash_damage(15);
					var _hitbox = hitbox_create_melee(24, -37, 0.5, 0.9, _damage, 11, 1.1, 7, 75, 1, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong2;
					_hitbox.shieldstun_scaling = 0.5;
					}
				//Attack Third Part
				if (attack_frame == 0)
					{
					anim_frame = 4;
				
					var _damage = calculate_smash_damage(14);
					var _hitbox = hitbox_create_melee(-5, -40, 1, 0.7, _damage, 9, 1, 5, 90, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.shieldstun_scaling = 0.5;
			
					attack_phase++;
					attack_frame = 2;
					}
				break;
				}
			//Attack -> Endlag
			case 3:
				{
				//Attack Fourth Part
				if (attack_frame == 0)
					{
					anim_frame = 5;
				
					var _damage = calculate_smash_damage(13);
					var _hitbox = hitbox_create_melee(-19, -15, 0.8, 1, _damage, 6, 1, 4, 120, 5, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.shieldstun_scaling = 0.5;
				
					attack_phase++;
					attack_frame = 25;
					}
				break;
				}
			//Finish
			case 4:
				{
				//Animation
				if (attack_frame == 20)
					anim_frame = 6;
				if (attack_frame == 14)
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