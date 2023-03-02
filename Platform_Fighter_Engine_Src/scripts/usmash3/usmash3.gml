function usmash3() {
	//Up Smash for character3
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
				anim_sprite = spr_usmash3;
				anim_frame = 0;
				anim_speed = 0;
		
				charge = 0;
		
				attack_frame = 8;
				
				hurtbox_anim_match();
				return;
				}
			//Charging
			case 0:
				{
				//Animation
				if (attack_frame == 5)
					anim_frame = 1;
				if (attack_frame == 2)
					anim_frame = 2;
					
				//Charging
				if (attack_frame == 0)
					{
					//Animation (every 8 frames switch the sprite)
					if (charge % 8 == 0)
						{
						if (anim_frame == 4)
							{
							anim_frame = 3;
							}
						else
							{
							anim_frame = 4;
						
							//Shine VFX
							vfx_create(spr_shine_attack, 1, 0, 8, x + prng_number(0, 20, -20), y + prng_number(1, 20, -20), 1, prng_number(0, 360));
							}
						}
						
					charge++;
					if (charge >= smash_attack_charge_max || (!input_held(INPUT.smash) && !input_held(INPUT.attack) && !input_held(INPUT.special)))
						{
						attack_frame = 6;
						
						//Angling
						if (stick_tilted(Lstick, DIR.right))
							{
							attack_phase = 2;
							anim_sprite = spr_usmash3_angled;
							facing = 1;
							}
						else if (stick_tilted(Lstick, DIR.left))
							{
							attack_phase = 2;
							anim_sprite = spr_usmash3_angled;
							facing = -1;
							}
						else
							{
							attack_phase = 1;
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
				
					attack_phase = 3;
					attack_frame = 38;
					
					//Normal hits
					var _damage = calculate_smash_damage(14);
					var _hitbox = hitbox_create_melee(15, -72, 3, 0.15, _damage, 9, 1.1, 7, 90, 3, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 97);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					var _hitbox = hitbox_create_melee(-12, -72, 3, 0.15, _damage, 9, 1.1, 7, 90, 3, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 84);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					var _hitbox = hitbox_create_melee(2, 2, 0.6, 0.9, _damage, 9, 1.1, 7, 90, 3, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					
					//Sweetspot
					var _damage = calculate_smash_damage(18);
					var _hitbox = hitbox_create_melee(1, -190, 0.2, 0.7, _damage, 9, 1.2, 10, 90, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.emphasis];
					_hitbox.hit_sfx = snd_hit_explosion3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					
					//Shine VFX
					vfx_create(spr_shine_attack, 1, 0, 8, x + 1, y - 190, 1, prng_number(0, 360));
					}
				break;
				}
			//Startup (Angled)
			case 2:
				{
				//Animation
				if (attack_frame == 4)
					anim_frame = 5;
				if (attack_frame == 2)
					anim_frame = 6;
		
				if (attack_frame == 0)
					{
					anim_frame = 7;
				
					attack_phase = 3;
					attack_frame = 38;
					
					//Normal hits
					var _damage = calculate_smash_damage(14);
					var _hitbox = hitbox_create_melee(27, -68, 0.15, 3, _damage, 9, 1.1, 7, 80, 3, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					var _hitbox = hitbox_create_melee(2, -66, 0.15, 3, _damage, 9, 1.1, 7, 80, 3, SHAPE.rotation, 0);
					hitbox_sprite_angle_set(_hitbox, 167);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					var _hitbox = hitbox_create_melee(9, 0, 0.6, 0.9, _damage, 9, 1.1, 7, 80, 3, SHAPE.square, 0);
					_hitbox.hit_vfx_style = HIT_VFX.slash_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					
					//Sweetspot
					var _damage = calculate_smash_damage(18);
					var _hitbox = hitbox_create_melee(28, -190, 0.2, 0.7, _damage, 9, 1.2, 10, 80, 3, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.emphasis];
					_hitbox.hit_sfx = snd_hit_explosion3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					
					//Shine VFX
					vfx_create(spr_shine_attack, 1, 0, 8, x + (28 * facing), y - 190, 1, prng_number(0, 360));
					}
				break;
				}
			//Active / Endlag
			case 3:
				{
				//Animation
				if (attack_frame == 35)
					anim_frame = 8;
				if (attack_frame == 30)
					anim_frame = 9;
				if (attack_frame == 24)
					anim_frame = 10;
				if (attack_frame == 16)
					anim_frame = 11;
				if (attack_frame == 8)
					anim_frame = 12;
		
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
		hurtbox_anim_match();
		}
}
/* Copyright 2023 Springroll Games / Yosi */