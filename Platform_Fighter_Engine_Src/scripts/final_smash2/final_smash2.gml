function final_smash2() {
	//Final Smash
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
				anim_sprite = spr_final_smash2;
				anim_speed = 0;
				anim_frame = 0;
		
				attack_frame = 3;
				
				reverse_b();
				
				final_smash_startup_script();
				return;
				}
			//Initial Punch
			case 0:
				{
				//Speeds
				if (on_ground())
					{
					friction_gravity(ground_friction);
					}
				else
					{
					aerial_drift();
					friction_gravity(air_friction, grav, max_fall_speed);
					}
					
				//Animation
				if (attack_frame == 2)
					anim_frame = 1;
				if (attack_frame == 1)
					anim_frame = 2;
				
				if (attack_frame == 0)
					{
					anim_frame = 3;
					attack_phase++;
					attack_frame = 25;
					
					change_facing();
					
					//Initial hitbox
					var _hitbox = hitbox_create_magnetbox(38, 8, 1.3, 1.3, 1, 8, 8, 0, 15, 6, SHAPE.circle, 0);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = snd_hit_strong;
					}
				break;
				}
			//Whiff Endlag
			case 1:
				{
				//Speeds
				if (on_ground())
					{
					friction_gravity(ground_friction);
					}
				else
					{
					aerial_drift();
					friction_gravity(air_friction, grav, max_fall_speed);
					}
					
				//Animation
				if (attack_frame == 21)
					anim_frame = 4;
				if (attack_frame == 15)
					anim_frame = 5;
				if (attack_frame == 7)
					anim_frame = 6;
					
				//Transition to next phase
				if (attack_connected())
					{
					attack_phase++;
					attack_frame = 30;
					
					//Early multihit hitbox
					hitbox_destroy_attached_all();
					var _hitbox = hitbox_create_magnetbox(56, 0, 1.3, 0.8, 1, 1, 0, 0, 15, 20, SHAPE.square, 1);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = [snd_hit_strong, snd_hit_strong2];
					
					//Move to foreground
					player_renderer_set(obj_player_renderer_foreground);
					player_move_to_front();
					break;
					}
				
				if (attack_frame == 0)
					{
					//No more invincibility
					invulnerability_set(INV.normal, -1);
					
					attack_stop();
					}
				break;
				}
			//Multihit
			case 2:
				{
				//Speeds
				friction_gravity(slide_friction);
				speed_set(0, 0, true, false);
					
				//Loops
				if (attack_frame % 3 == 0)
					{
					hitbox_group_reset(1);
					}
				if (attack_frame % 2 == 0)
					{
					anim_frame++;
					if (anim_frame > 10) then anim_frame = 7;
					}
				if (attack_frame == 10)
					{
					//Late multihit hitbox
					var _hitbox = hitbox_create_magnetbox(56, 0, 1.3, 0.8, 1, 2, 0, 0, 40, 10, SHAPE.square, 1);
					_hitbox.hit_vfx_style = HIT_VFX.normal_strong;
					_hitbox.hit_sfx = [snd_hit_strong2, snd_hit_strong3];
					}
					
				if (attack_frame == 0)
					{
					anim_frame = 11;
					
					attack_phase++;
					attack_frame = 50;
					}
				break;
				}
			//Final punch
			case 3:
				{
				//Speeds
				friction_gravity(slide_friction);
				
				//Animation
				if (attack_frame == 45)
					anim_frame = 12;
				if (attack_frame == 40)
					anim_frame = 13;
				if (attack_frame == 20)
					{
					anim_frame = 14;
					
					//Speed boost
					speed_set(6 * facing, 0, false, false);
					}
				if (attack_frame == 16)
					anim_frame = 16;
				if (attack_frame == 12)
					anim_frame = 17;
				if (attack_frame == 8)
					anim_frame = 18;
				if (attack_frame == 4)
					anim_frame = 19;
					
				//Hitbox
				if (attack_frame == 18)
					{
					anim_frame = 15;
					
					var _hitbox = hitbox_create_melee(58, -16, 0.9, 1.3, 18, 11, 1.5, 20, 65, 2, SHAPE.circle, 2);
					_hitbox.knockback_formula = KNOCKBACK_FORMULA.stronger;
					_hitbox.hit_vfx_style = [HIT_VFX.normal_strong, HIT_VFX.lines, HIT_VFX.emphasis];
					_hitbox.hit_sfx = snd_hit_explosion4;
					_hitbox.knockback_state = PLAYER_STATE.balloon;
					_hitbox.hitstun_scaling = 0.25;
					
					//VFX
					var _vfx = vfx_create(spr_buster_wolf_explosion, 1, 0, 40, x + (58 * facing), y - 16, 2, 65 * facing);
					_vfx.vfx_xscale = 2 * facing;
					}
					
				if (attack_frame == 0)
					{
					//No more invincibility
					invulnerability_set(INV.normal, -1);
					
					attack_stop();
					}
				break;
				}
			}
		}
		
	//Movement
	move();
}
/* Copyright 2023 Springroll Games / Yosi */