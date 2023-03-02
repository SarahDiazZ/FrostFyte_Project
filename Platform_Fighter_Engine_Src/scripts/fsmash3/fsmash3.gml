function fsmash3() {
	//Forward Smash for character3
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
				anim_sprite = spr_fsmash3;
				anim_frame = 0;
				anim_speed = 0;
		
				charge = 0;
		
				attack_frame = 14;
				
				hurtbox_anim_match(spr_fsmash3_hurtbox);
				return;
				}
			//Charging
			case 0:
				{
				if (attack_frame == 6)
					anim_frame = 1;
					
				//Charging
				if (attack_frame == 0)
					{
					//Animation (every 8 frames switch the sprite)
					if (charge % 8 == 0)
						{
						if (anim_frame == 3)
							{
							anim_frame = 2;
							}
						else
							{
							anim_frame = 3;
						
							//Shine VFX
							vfx_create(spr_shine_attack, 1, 0, 8, x + prng_number(0, 20, -20), y + prng_number(1, 20, -20), 1, prng_number(0, 360));
							}
						}
						
					charge++;
					if (charge >= smash_attack_charge_max || (!input_held(INPUT.smash) && !input_held(INPUT.attack) && !input_held(INPUT.special)))
						{
						anim_frame = 4;
						attack_phase++;
						attack_frame = 14;
						}
					}
				break;
				}
			//Startup
			case 1:
				{
				if (attack_frame == 10)
					{
					speed_set(lerp(11, 18, (charge / smash_attack_charge_max)) * facing, 0, false, false);
					anim_frame = 5;
					
					//Damaging hitbox
					var _hitbox = hitbox_create_melee(20, -6, 0.9, 0.9, 4, 1, 0, 3, 0, 9, SHAPE.square, 1);
					_hitbox.techable = 0;
					_hitbox.di_angle = 0;
					_hitbox.asdi_multiplier = 0;
					_hitbox.hit_vfx_style = HIT_VFX.normal_medium;
					_hitbox.hit_sfx = snd_hit_weak2;
					
					//Magnetbox
					var _hitbox = hitbox_create_magnetbox(20, -6, 0.9, 0.9, 0, 0, 55, 0, 12, 10, SHAPE.square, 0, true);
					_hitbox.hit_sfx = -1;
					_hitbox.hit_vfx_style = HIT_VFX.none;
					_hitbox.magnet_snap_speed = 20;
					_hitbox.shieldstun_scaling = 0;
					
					//VFX
					var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x, (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					}
					
				//Animation
				if (attack_frame == 9)
					anim_frame = 6;
				if (attack_frame == 8)
					anim_frame = 7;
				if (attack_frame == 2)
					anim_frame = 8;
					
				//Refresh magnetboxes to drag along opponents
				if (attack_frame < 10 && attack_frame > 0 && !attack_connected(true, true))
					{
					hitbox_group_reset(0);
					}
					
				if (attack_frame == 0)
					{
					anim_frame = 9;
				
					attack_phase++;
					attack_frame = 30;
					
					camera_shake(0, 3);
					
					//Second hit
					var _damage = calculate_smash_damage(19);
					var _hitbox = hitbox_create_melee(18, 2, 1, 0.6, _damage, 4.5, 1, 16, 41, 3, SHAPE.square, 2);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.lines];
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					_hitbox.shieldstun_scaling = 0.1;
					}
				break;
				}
			//Active
			case 2:
				{
				//Animation
				if (attack_frame == 27)
					anim_frame = 10;
				if (attack_frame == 21)
					anim_frame = 11;
				if (attack_frame == 14)
					anim_frame = 12;
				if (attack_frame == 7)
					anim_frame = 13;
		
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
		hurtbox_anim_match(spr_fsmash3_hurtbox);
		}
}
/* Copyright 2023 Springroll Games / Yosi */