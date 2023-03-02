function nspec_charge_shot() {
	//Neutral Special
	/*
	- Press once to charge, press again to shoot
	- Tilt the stick in the opposite direction right after starting to reverse the attack
	- If at full charge, press once to shoot
	- On the ground, you can cancel the charge with a roll, spot dodge, shield, or jump
	- In the air, you can cancel the charge with an airdodge or jump
	*/
	var run = true;
	var _phase = argument_count > 0 ? argument[0] : attack_phase;
	//Timer
	attack_frame = max(--attack_frame, 0);
	//Actions / Cancels
	if (on_ground())
		{
		friction_gravity(ground_friction, grav, max_fall_speed);
		}
	else
		{
		friction_gravity(air_friction, grav, max_fall_speed);
		}
	//Phases
	if (run)
		{
		var _total_charge = 125;
		switch(_phase)
			{
			case PHASE.start:
				{
				//Animation
				anim_sprite = spr_nspec_charge_shot;
				anim_frame = 0;
				anim_speed = 0;
		
				//Reverse B
				reverse_b();
				
				if (!variable_struct_exists(custom_attack_struct, "nspec_charge_shot_charge"))
					{
					custom_attack_struct.nspec_charge_shot_charge = 0;
					}
					
				callback_add(callback_draw_end, nspec_charge_shot_draw);

				attack_frame = 10;
				
				//EX
				ex_move_reset();
				return;
				}
			//Startup
			case 0:
				{
				//EX
				ex_move_allow(2);
				
				//Animation
				if (attack_frame == 8)
					anim_frame = 1;
				if (attack_frame == 5)
					anim_frame = 2;
				if (attack_frame == 2)
					anim_frame = 3;
				
				//B Reverse
				if (attack_frame == 6)
					{
					b_reverse();
					}
				if (attack_frame == 0)
					{
					//Charged version / EX
					if (custom_attack_struct.nspec_charge_shot_charge < _total_charge && !ex_move_is_activated())
						{
						attack_phase++;
						attack_frame = 0;
						}
					else
						{
						attack_phase = 2;
						attack_frame = 3;
						}
					}
				break;
				}
			//Charging
			case 1:
				{
				custom_attack_struct.nspec_charge_shot_charge += 1;
			
				//Cancel at full charge
				if (custom_attack_struct.nspec_charge_shot_charge >= _total_charge)
					{
					//Store charge
					attack_stop();
					game_sound_play(snd_hit_sizzle);
					break;
					}
			
				//Cancels
				if (cancel_charge_check()) return;
			
				//Shoot
				if (input_pressed(INPUT.special))
					{
					attack_phase = 2;
					attack_frame = 3;
					}
					
				//VFX
				if (custom_attack_struct.nspec_charge_shot_charge % 16 == 0 && on_ground())
					{
					var _vfx = vfx_create(spr_dust_run, 1, 0, 14, x + (-16 * facing), (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale = 2 * facing;
					}
				break;
				}
			//Shoot
			case 2:
				{
				//Animation
				if (attack_frame == 2)
					anim_frame = 3;
					
				if (attack_frame == 0)
					{
					anim_frame = 4;
					if (!on_ground())
						{
						speed_set(-3 * facing, -1, true, true);
						}
					
					//EX Version
					if (ex_move_is_activated())
						{
						var _proj = hitbox_create_projectile_custom
							(
							obj_nspec_charge_shot, 
							45, 
							0, 
							0.7, 
							0.7, 
							15, 
							4, 
							0.8,
							40, 
							240, 
							SHAPE.circle,
							1, 
							0,
							FLIPPER.from_hitbox_center,
							);
						_proj.base_hitlag = 20;
						_proj.hit_sfx = snd_hit_explosion2;
						_proj.overlay_scale = 1;
						_proj.hit_vfx_style = HIT_VFX.electric;
						}
					//Normal
					else
						{
						var _percent = (custom_attack_struct.nspec_charge_shot_charge / _total_charge);
						var _size = lerp(0.45, 1.55, _percent);
						var _scale = 0.5 + (_percent * 1.5);
						var _speed = 5 + (5 * _scale);
						var _proj = hitbox_create_projectile_custom
							(
							obj_nspec_charge_shot, 
							45, 
							0, 
							0.4 * _size, 
							0.4 * _size, 
							(_percent == 1) ? 30 : ceil(lerp(5, 26, _percent)), 
							4.5 * _scale, 
							(_percent == 1) ? 0.9 : 0.6,
							40, 
							75, 
							SHAPE.circle,
							_speed, 
							0,
							FLIPPER.sakurai,
							);
						_proj.base_hitlag = (_percent == 1) ? 18 : ceil(lerp(7, 14, _percent));
						_proj.hit_sfx = snd_hit_explosion2;
						_proj.overlay_scale = _size;
						_proj.hit_vfx_style = (_percent == 1) ? [HIT_VFX.explosion, HIT_VFX.electric] : HIT_VFX.electric;
						}
						
					hit_sfx_play(snd_hit_shot);
					attack_phase++;
					attack_frame = 30;
					custom_attack_struct.nspec_charge_shot_charge = 0;
					
					//VFX
					if (on_ground())
						{
						var _vfx = vfx_create(spr_dust_dash_medium, 1, 0, 34, x + (-16 * facing), (bbox_bottom - 1) - 1, 2, 0, "VFX_Layer_Below");
						_vfx.vfx_xscale = 2 * facing;
						}
					}
				break;
				}
			//Finish
			case 3:
				{
				//Animation
				if (attack_frame == 28)
					anim_frame = 5;
				if (attack_frame == 26)
					anim_frame = 6;
				if (attack_frame == 24)
					anim_frame = 7;
				if (attack_frame == 18)
					anim_frame = 8;
				if (attack_frame == 12)
					anim_frame = 9;
				if (attack_frame == 6)
					anim_frame = 10;
					
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