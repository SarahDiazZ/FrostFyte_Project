function fsmash_spinning() {
	//Upward Tilt
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_fsmash_spinning;
				anim_frame = 0;
				anim_speed = 0;
		
				charge = 0;
		
				attack_frame = 20;
				
				speed_set(-7 * facing, -7, false, false);
				return;
				}
			//Startup + Charging
			case 0:
				{
				//Speeds
				if (on_ground())
					{
					friction_gravity(slide_friction, grav, max_fall_speed);
					}
				else
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					}
				
				//Animation
				if (attack_frame == 18)
					anim_frame = 1;
				if (attack_frame == 16)
					anim_frame = 2;
				if (attack_frame == 14)
					anim_frame = 3;
				if (attack_frame == 12)
					anim_frame = 4;
				if (attack_frame == 10)
					anim_frame = 5;
				if (attack_frame == 8)
					anim_frame = 6;
				if (attack_frame == 6)
					anim_frame = 7;
				if (attack_frame == 4)
					anim_frame = 8;
				if (attack_frame == 2)
					anim_frame = 9;
				
				//Charging
				if (attack_frame == 0)
					{
					if (charge >= smash_attack_charge_max || (!input_held(INPUT.smash) && !input_held(INPUT.attack) && !input_held(INPUT.special)))
						{
						anim_frame = 12;
						attack_phase++;
						attack_frame = 16;
						
						speed_set(11 * facing, 0, false, false);
						}
					else
						{
						charge++;
						if (charge % 7 == 0)
							{
							anim_frame++;
							if (anim_frame > 11)
								{
								anim_frame = 10;
								//Shine VFX
								vfx_create(spr_shine_attack, 1, 0, 8, x + prng_number(0, 20, -20), y + prng_number(1, 20, -20), 1, prng_number(0, 360));
								}
							}
						}
					}
				break;
				}
			//Startup + Active
			case 1:
				{
				//Animation
				if (attack_frame == 14)
					anim_frame = 13;
				if (attack_frame == 13)
					anim_frame = 14;
				if (attack_frame == 11)
					anim_frame = 15;
				if (attack_frame == 10)
					anim_frame = 16;
				if (attack_frame == 8)
					anim_frame = 17;
				if (attack_frame == 7)
					anim_frame = 18;
				if (attack_frame == 5)
					anim_frame = 19;
				if (attack_frame == 4)
					anim_frame = 20;
				if (attack_frame == 3)
					anim_frame = 21;
				if (attack_frame == 2)
					anim_frame = 22;
					
				//Magnetbox
				if (attack_frame == 14)
					{
					var _hitbox = hitbox_create_magnetbox(10, 0, 0.6, 0.9, 1, 1, 16, -4, 10, 12, SHAPE.circle, 0, true);
					_hitbox.hit_vfx_style = HIT_VFX.slash_weak;
					_hitbox.hit_sfx = snd_hit_weak2;
					}
					
				//Multihit
				if (attack_frame > 2 && attack_frame % 2 == 0)
					{
					hitbox_group_reset(0);
					}
					
				//VFX
				if (attack_frame % 4 == 0 && on_ground())
					{
					var _vfx = vfx_create(spr_dust_run, 1, 0, 14, x, (bbox_bottom - 1), 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					}
				
				//Final hit
				if (attack_frame == 2)
					{
					var _damage = calculate_smash_damage(5);
					var _hitbox = hitbox_create_melee(0, 0, 1, 0.8, _damage, 6, 1.1, 20, 40, 2, SHAPE.circle, 1);
					_hitbox.hit_vfx_style = [HIT_VFX.slash_strong, HIT_VFX.normal_strong];
					_hitbox.hit_sfx = snd_hit_strong3;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.techable = false;
					}
					
				if (attack_frame == 0)
					{
					anim_frame = 23;
				 
					attack_phase++;
					attack_frame = attack_connected() ? 12 : 30;
					}
				break;
				}
			//Endlag
			case 2:
				{
				//Speeds
				if (on_ground())
					{
					friction_gravity(ground_friction, grav, max_fall_speed);
					}
				else
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					aerial_drift();
					}
					
				//Animation
				if (attack_frame == 28)
					anim_frame = 24;
				if (attack_frame <= 20)
					anim_frame = 25;
				if (attack_frame <= 10)
					anim_frame = 26;

				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			}
		}
	//Movement
	if (on_ground())
		{
		move_grounded();
		}
	else
		{
		move();
		}
}
/* Copyright 2023 Springroll Games / Yosi */