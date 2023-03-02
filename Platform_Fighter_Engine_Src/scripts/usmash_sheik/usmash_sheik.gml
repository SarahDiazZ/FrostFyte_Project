function usmash_sheik() {
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
				//Animation
				anim_sprite = spr_usmash_sheik;
				anim_frame = 0;
				anim_speed = 0;
		
				charge = 0;
		
				attack_frame = 6;
				return;
				}
			//Charging
			case 0:
				{
				//Animation (every 8 frames switch the sprite)
				if (charge % 8 == 0)
					{
					if (anim_frame == 2)
						{
						anim_frame = 1;
						}
					else
						{
						anim_frame = 2;
						}
					}
			
				charge++;
				if ((charge >= smash_attack_charge_max || (!input_held(INPUT.smash) && !input_held(INPUT.attack) && !input_held(INPUT.special))) && attack_frame == 0)
					{
					anim_frame = 3;
					attack_phase++;
					attack_frame = 8;
					//Sourspot
					var _damage = calculate_smash_damage(8);
					var _hitbox = hitbox_create_melee(0, 4, 0.4, 0.6, _damage, 9, 0.9, 11, 90, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					//Sweetspot
					var _damage = calculate_smash_damage(13);
					var _hitbox = hitbox_create_melee(0, -38, 0.3, 0.4, _damage, 11, 1, 11, 90, 2, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.shine];
					_hitbox.hit_sfx = snd_hit_explosion3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					//Shine VFX
					vfx_create(spr_shine_attack, 1, 0, 8, x, y - 38, 1, 45);
					}
				break;
				}
			//Startup -> First Hit
			case 1:
				{
				if (attack_frame == 6)
					{
					anim_frame = 4;
					//Late hit
					var _damage = calculate_smash_damage(8);
					var _hitbox = hitbox_create_melee(20, 6, 0.7, 0.6, _damage, 9, 0.9, 4, 75, 2, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					var _hitbox = hitbox_create_melee(-20, 6, 0.7, 0.6, _damage, 9, 0.9, 4, 75, 2, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong2;
					}
				
				if (attack_frame == 4)
					anim_frame = 5;
		
				if (attack_frame == 0)
					{
					attack_phase++;
					attack_frame = attack_connected() ? 10 : 30;
					}
				break;
				}
			//Finish
			case 2:
				{
				//Animation
				if (attack_frame == 27)
					anim_frame = 6;
				if (attack_frame == 18)
					anim_frame = 7;
				if (attack_frame == 9)
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