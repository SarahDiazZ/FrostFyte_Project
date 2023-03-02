////@description Step
custom_entity_struct.frame -= 1;
if (custom_entity_struct.phase == 0)
	{
	image_index += 0.2;
	if (image_index >= 6) then image_index -= 3;
	
	if (custom_entity_struct.frame <= 0)
		{
		image_index = 6;
		custom_entity_struct.phase = 1;
		
		//Attack the nearest enemy player
		var _nearest = noone;
		with(owner)
			{
			_nearest = find_nearest_player(other.x, other.y, infinity, player_team);
			}
		if (_nearest != noone)
			{
			custom_entity_struct.laser_x = _nearest.x;
			custom_entity_struct.laser_y = _nearest.y;
			custom_entity_struct.frame = 10;
			
			game_sound_play(snd_dspec4_laser);
			
			//If the player is not invulnerable
			if (_nearest.hurtbox.inv_type == INV.normal ||
				_nearest.hurtbox.inv_type == INV.heavyarmor ||
				_nearest.hurtbox.inv_type == INV.superarmor)
				{
				//If the player is in hitstun
				if (is_launched(_nearest))
					{
					//Longer hitlag from the EX version
					var _ex = false;
					with(owner)
						{
						_ex = ex_move_is_activated();
						}
					_nearest.self_hitlag_frame = _ex ? 75 : 45;
					apply_damage(_nearest, 6);
					with(_nearest)
						{
						hit_vfx_style_create(HIT_VFX.electric, 90, noone, 12);
						var _vfx = vfx_create_color(spr_dspec4_gaze_hit, 1, 0, 72, x, y, 2, 30, "VFX_Layer_Below");
						_vfx.vfx_xscale *= prng_choose(0, -1, 1);
						_vfx.vfx_yscale *= prng_choose(1, -1, 1);
						_vfx.owner = other.owner; //Make sure the color is correct!
						}
					game_sound_play(snd_hit_electro);
					}
				//Otherwise, deal 1% and no knockback
				else
					{
					apply_damage(_nearest, 1);
					with(_nearest)
						{
						hit_vfx_style_create(HIT_VFX.electric_weak, 90, noone, 0);
						//Knockdown locking
						if (state == PLAYER_STATE.knockdown)
							{
							knockdown_lock();
							}
						}
					game_sound_play(snd_hit_weak);
					}
				}
			
			vfx_create(spr_shine_attack_long, 1, 0, 16, _nearest.x, _nearest.y, 1, 0);
			}
		}
	}
else if (custom_entity_struct.phase == 1)
	{
	if (custom_entity_struct.frame <= 0)
		{
		image_index += 0.5;
		if (image_index >= 9)
			{
			instance_destroy();
			exit;
			}
		}
	else
		{
		image_index += 0.2;
		if (image_index >= 6) then image_index -= 3;
		}
	}
	
//Destroy if the owner gets hit
if (is_launched(owner))
	{
	camera_shake(2);
	
	//VFX
	var _vfx = vfx_create_color(spr_dspec4_gaze_death, 1, 0, 24, x, y, 2, 0, "VFX_Layer_Below");
	_vfx.owner = owner; //Make sure the VFX has the correct palette!
	
	instance_destroy();
	exit;
	}
/* Copyright 2023 Springroll Games / Yosi */