function nspec4() {
	//Neutral Special
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Speeds / Sprite Change
	var _on_ground = on_ground();
	if (_on_ground)
		{
		anim_sprite = spr_nspec4;
		friction_gravity(slide_friction, grav, max_fall_speed);
		}
	else
		{
		anim_sprite = spr_nspec4_air;
		aerial_drift();
		friction_gravity(air_friction, grav, max_fall_speed);
		fastfall_attack_try();
		}
	//Phases
	if (run)
		{
		switch(_phase)
			{
			case PHASE.start:
				{
				//Kunai limit
				if (!variable_struct_exists(custom_passive_struct, "has_kunai"))
					{
					custom_passive_struct.has_kunai = true;
					}
					
				//Grounded vs Aerial
				if (_on_ground)
					{
					attack_frame = 7;
					}
				else
					{
					attack_frame = 4;
					speed_set(0, -1, true, true);
					}
					
				//Animation
				anim_frame = 0;
				anim_speed = 0;
		
				reverse_b();
				
				//EX
				ex_move_reset();
				return;
				}
			//Startup -> Throw
			case 0:
				{
				//EX
				ex_move_allow(1);
				
				if (attack_frame <= 3)
					anim_frame = 1;
					
				if (attack_frame == 0)
					{
					custom_passive_struct.has_kunai = false;
					
					anim_frame = 2;
					b_reverse();
					
					var _ex = ex_move_is_activated();
					var _num = _ex ? 5 : 1;
					var _dir, _hsp, _vsp, _dmg;
					for(var i = 0; i < _num; i++)
						{
						var _proj = noone;
						if (_on_ground)
							{
							if (!_ex)
								{
								_dir = 0;
								_hsp = 13;
								_vsp = 0;
								_dmg = 1;
								}
							else
								{
								_dir = 0 + (12 * i);
								_hsp = lengthdir_x(16, _dir);
								_vsp = lengthdir_y(16, _dir);
								_dmg = 2;
								}
							_proj = hitbox_create_projectile_custom(obj_nspec4_kunai, 24, 10, 0.2, 0.2, _dmg, 0, 0, 45, 80, SHAPE.circle, _hsp, _vsp, FLIPPER.sakurai);
							hitbox_overlay_sprite_set(_proj, spr_nspec4_kunai, 0, 1, 2, _dir * facing, c_white, 1, facing);
							attack_cooldown_set(28);
							}
						else
							{
							if (!_ex)
								{
								_dir = 315;
								_hsp = 9;
								_vsp = 9;
								_dmg = 1;
								}
							else
								{
								_dir = 325 - (8 * i);
								_hsp = lengthdir_x(16, _dir);
								_vsp = lengthdir_y(16, _dir);
								_dmg = 2;
								}
							_proj = hitbox_create_projectile_custom(obj_nspec4_kunai, 24, 24, 0.2, 0.2, _dmg, 0, 0, 45, 80, SHAPE.circle, _hsp, _vsp, FLIPPER.sakurai);
							hitbox_overlay_sprite_set(_proj, spr_nspec4_kunai, 0, 1, 2, _dir * facing, c_white, 1, facing);
							}
						_proj.destroy_on_blocks = true;
						_proj.destroy_on_hit = true;
						_proj.base_hitlag = 4;
						_proj.hitlag_scaling = 0;
						_proj.hit_sfx = snd_nspec4_hit;
						_proj.hit_vfx_style = [HIT_VFX.custom, nspec4_hit_vfx_style];
						_proj.pre_hit_script = nspec4_pre_hit;
						_proj.can_lock = true;
						}
					
					attack_phase++;
					attack_frame = (_on_ground ? 18 : 15);
					}
				break;
				}
			//Throw -> Finish
			case 1:
				{
				//Animation
				if (attack_frame == 11)
					anim_frame = 3;
				if (attack_frame == 6)
					anim_frame = 4;
			
				if (attack_frame == 0)
					{
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