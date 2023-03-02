function dspec3() {
	//Down Special for character3
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
				if (!variable_struct_exists(custom_attack_struct, "dspec3_charge"))
					{
					custom_attack_struct.dspec3_charge = 0;
					}
				if (!variable_struct_exists(custom_attack_struct, "dspec3_damage"))
					{
					custom_attack_struct.dspec3_damage = 0;
					}
				if (!variable_struct_exists(custom_attack_struct, "dspec3_cancel"))
					{
					custom_attack_struct.dspec3_cancel = false;
					}
					
				//Guard version
				if (custom_attack_struct.dspec3_charge < 3)
					{
					custom_attack_struct.dspec3_cancel = false;
					anim_sprite = spr_dspec3_guard;
					anim_frame = 0;
					anim_speed = 0;
					attack_frame = 4;
					attack_phase = 0;
					callback_add(callback_overhead, dspec3_overhead);
					}
				//Explosion version
				else
					{
					custom_attack_struct.dspec3_charge = 0;
					anim_sprite = spr_dspec3_explode;
					anim_frame = 0;
					anim_speed = 0;
					attack_frame = 8;
					attack_phase = 4;
					}
					
				//EX
				ex_move_reset();
				
				//Draw order
				player_move_to_back();
				return;
				}
			//Guard Startup
			case 0:
				{
				//EX
				ex_move_allow(1);
				
				//Speeds
				if (on_ground())
					{
					friction_gravity(slide_friction);
					}
				else
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					}
					
				//Animation
				if (attack_frame == 3)
					anim_frame = 1;
				if (attack_frame == 1)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					speed_set(0, 0, false, false);
					
					anim_frame = 3;
				
					attack_phase++;
					attack_frame = 80;
				
					custom_attack_struct.dspec3_damage = damage;
				
					//Superarmor
					invulnerability_set(INV.superarmor, 1);
					
					//EX version
					if (ex_move_is_activated())
						{
						anim_sprite = spr_dspec3_explode;
						anim_frame = 0;
						anim_speed = 0;
						attack_frame = 10;
						attack_phase = 7;
						
						//Give charge
						custom_attack_struct.dspec3_charge += 1;
						
						game_sound_play(snd_hit_wind);
						}
					}
				break;
				}
			//Guard Active
			case 1:
				{
				//Superarmor
				invulnerability_set(INV.superarmor, 1);
				
				//Animation
				anim_speed = 0.3;
				if (anim_frame > 16)
					anim_frame -= 7;
				
				//Speeds
				if (attack_frame <= 60)
					{
					if (on_ground())
						{
						friction_gravity(ground_friction);
						}
					else
						{
						friction_gravity(air_friction, 0.3, 5);
						}
					}
			
				//The attack can be canceled earlier if you take damage
				if (damage > custom_attack_struct.dspec3_damage)
					{
					custom_attack_struct.dspec3_charge += 1;
					custom_attack_struct.dspec3_cancel = true;
					
					//When you gain a charge, set the attack on cooldown so you can't immediately use the explosion
					attack_cooldown_set(60);
					
					//VFX
					var _vfx = vfx_create(spr_hit_counter, 1, 0, 36, x, y, 2, 0, "VFX_Layer");
					_vfx.vfx_blend = palette_color_get(palette_data, 1);
					}
				custom_attack_struct.dspec3_damage = damage;
				
				if (custom_attack_struct.dspec3_cancel && !input_held(INPUT.special))
					{
					attack_phase = 3;
					attack_frame = 3;
					run = false;
					}
				
				if (run && ((attack_frame <= 60 && !input_held(INPUT.special)) || attack_frame == 0))
					{
					anim_speed = 0;
					anim_frame = 17;
					attack_phase = 2;
					attack_frame = 15;
					}
				break;
				}
			//Guard Endlag (Normal)
			case 2:
				{
				//Speeds
				if (on_ground())
					{
					friction_gravity(ground_friction);
					}
				else
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					}
					
				//Animation
				if (attack_frame == 10)
					anim_frame = 18;
				if (attack_frame == 5)
					anim_frame = 19;
			
				if (attack_frame == 0)
					{
					attack_cooldown_set(30);
					attack_stop();
					}
				break;
				}
			//Guard Endlag (Canceled)
			case 3:
				{
				//Speeds
				if (on_ground())
					{
					friction_gravity(ground_friction);
					}
				else
					{
					friction_gravity(air_friction, grav, max_fall_speed);
					}
					
				//Animation
				anim_speed = 0.3;
				if (anim_frame > 16)
					anim_frame -= 7;
			
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			//Explosion Startup
			case 4:
				{
				//Speeds
				if (on_ground())
					{
					friction_gravity(slide_friction);
					}
				else
					{
					aerial_drift();
					friction_gravity(air_friction, grav, max_fall_speed);
					}
					
				//Animation
				if (attack_frame == 4)
					anim_frame = 1;
					
				if (attack_frame == 0)
					{
					speed_set(0, 0, false, false);
					
					anim_frame = 2;
					attack_phase++;
					attack_frame = 6;
					
					game_sound_play(snd_hit_wind);
					
					//Sweetspot
					var _hitbox = hitbox_create_melee(0, 0, 2.4, 1.5, 12, 10, 1.1, 18, 80, 3, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal);
					_hitbox.hit_vfx_style = [HIT_VFX.emphasis, HIT_VFX.explosion, HIT_VFX.normal_strong];
					_hitbox.hit_sfx = snd_hit_explosion4;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					_hitbox.techable = false;
					//Sourspot
					var _hitbox = hitbox_create_windbox(0, 0, 4, 2, 0, 8, 0, 6, SHAPE.circle, 0, FLIPPER.from_player_center_horizontal, false, true, false);
					}
				break;
				}
			//Explosion Active
			case 5:
				{
				if (attack_frame == 3)
					anim_frame = 3;
					
				if (attack_frame == 0)
					{
					anim_frame = 4;
					attack_phase++;
					attack_frame = attack_connected() ? 10 : 25;
					}
				break;
				}
			//Explosion Endlag
			case 6:
				{
				//Speeds
				if (on_ground())
					{
					friction_gravity(ground_friction);
					}
				else
					{
					aerial_drift();
					friction_gravity(air_friction, 0.2, 4);
					}
					
				//Animation
				if (attack_frame == 21)
					anim_frame = 5;
				if (attack_frame == 17)
					anim_frame = 6;
				if (attack_frame == 13)
					anim_frame = 7;
				if (attack_frame == 9)
					anim_frame = 8;
				if (attack_frame == 5)
					anim_frame = 9;
					
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			//EX
			case 7:
				{
				//Animation
				if (attack_frame == 9)
					anim_frame = 1;
				if (attack_frame == 5)
					anim_frame = 3;
				if (attack_frame == 3)
					anim_frame = 4;
					
				if (attack_frame == 8)
					{
					anim_frame = 2;
					
					var _hitbox = hitbox_create_melee(0, 0, 2, 1.2, 6, 10, 0.3, 4, 75, 3, SHAPE.circle, 0, FLIPPER.toward_player_center_horizontal);
					_hitbox.hit_sfx = snd_hit_weak2;
					_hitbox.hit_vfx_style = [HIT_VFX.normal_medium, HIT_VFX.splash];
					_hitbox.techable = false;
					}
				
				//Go to the normal endlag
				if (attack_frame == 0)
					{
					anim_frame = 5;
					attack_phase = 6;
					attack_frame = attack_connected() ? 10 : 20;
					}
				break;
				}
			}
		}
	//Movement
	move_hit_platforms();
}
/* Copyright 2023 Springroll Games / Yosi */