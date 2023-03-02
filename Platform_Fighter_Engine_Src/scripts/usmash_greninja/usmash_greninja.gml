function usmash_greninja() {
	//Up Smash
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
				anim_sprite = spr_usmash_greninja;
				anim_frame = 0;
				anim_speed = 0;
		
				charge = 0;
		
				attack_frame = 8;
				return;
				}
			//Charging
			case 0:
				{
				//Animation
				if (attack_frame == 5)
					anim_frame = 1;
				if (attack_frame == 3)
					anim_frame = 2;
				if (attack_frame == 0 && charge % 8 == 0)
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
			
				charge++;
				if ((charge >= smash_attack_charge_max || (!input_held(INPUT.smash) && !input_held(INPUT.attack) && !input_held(INPUT.special))) && attack_frame == 0)
					{
					anim_frame = 3;
					attack_phase++;
					attack_frame = 3;
					}
				break;
				}
			//First Hit
			case 1:
				{
				if (attack_frame == 0)
					{
					anim_frame = 4;
					var _hitbox = hitbox_create_melee(0, -36, 0.4, 0.7, 5, 0, 0, 6, 90, 4, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.extra_hitlag = 10;
					attack_phase++;
					attack_frame = 10;
					}
				break;
				}
			//Second Hit
			case 2:
				{
				//Animation
				if (attack_frame == 8)
					anim_frame = 5;
				
				if (attack_frame == 6)
					{
					anim_frame = 6;
					var _damage = calculate_smash_damage(11);
					var _hitbox = hitbox_create_melee(0, -22, 1, 1.3, _damage, 8, 1.3, 9, 90, 2, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					}
					
				if (attack_frame == 4)
					{
					anim_frame = 7;
					var _damage = calculate_smash_damage(9);
					var _hitbox = hitbox_create_melee(40, -28, 0.5, 0.5, _damage, 7, 0.9, 6, 60, 2, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak;
					var _hitbox = hitbox_create_melee(-36, -28, 0.5, 0.5, _damage, 7, 0.9, 6, 120, 2, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak;
					}
					
				if (attack_frame == 2)
					{
					anim_frame = 8;
					var _damage = calculate_smash_damage(8);
					var _hitbox = hitbox_create_melee(46, 0, 0.5, 0.6, _damage, 6, 0.85, 6, 60, 2, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak;
					var _hitbox = hitbox_create_melee(-44, 0, 0.5, 0.6, _damage, 6, 0.85, 6, 120, 2, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = HIT_VFX.slash_medium;
					_hitbox.hit_sfx = snd_hit_weak;
					}
				
				if (attack_frame == 0)
					{
					anim_frame = 9;
					attack_phase++;
					attack_frame = attack_connected() ? 10 : 30;
					}
				break;
				}
			//Finish
			case 3:
				{
				//Animation
				if (attack_frame == 23)
					anim_frame = 10;
				if (attack_frame == 15)
					anim_frame = 11;
				if (attack_frame == 7)
					anim_frame = 12;
					
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