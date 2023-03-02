function final_smash1() {
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
				anim_sprite = spr_final_smash1;
				anim_speed = 0.3;
				anim_frame = 0;
				
				speed_set(0, 0, false, false);
				
				//Store values
				custom_attack_struct.final_smash_x = x;
				custom_attack_struct.final_smash_y = y;
				custom_ids_struct.final_smash_targets = [];
				
				//Move to foreground
				player_renderer_set(obj_player_renderer_foreground);
				player_move_to_front();
					
				callback_add(callback_draw_end, final_smash1_draw);
					
				final_smash_startup_script();
					
				attack_frame = 120;
				return;
				}
			//Aiming
			case 0:
				{
				//Move around the reticle
				if (attack_frame >= 20)
					{
					if (stick_tilted(Lstick))
						{
						var _speed = 9;
						custom_attack_struct.final_smash_x += _speed * stick_get_value(Lstick, DIR.horizontal);
						custom_attack_struct.final_smash_y += _speed * stick_get_value(Lstick, DIR.vertical);
						
						//Add players to the array
						var _x = custom_attack_struct.final_smash_x;
						var _y = custom_attack_struct.final_smash_y;
						var _size = 32;
						with(obj_player)
							{
							if (id == other.id) then continue;
							
							if (is_knocked_out()) then continue;
							
							if (hurtbox.inv_type == INV.invincible) then continue;
							
							if (!array_contains(other.custom_ids_struct.final_smash_targets, id))
								{
								if (collision_rectangle(_x - _size, _y - _size, _x + _size, _y + _size, id, false, false))
									{
									array_push(other.custom_ids_struct.final_smash_targets, id);
									}
								}
							}
						}
						
					//Fog
					obj_stage_manager.background_fog_color = c_black;
					obj_stage_manager.background_fog_alpha = max(0.8, obj_stage_manager.background_fog_alpha);
					}
					
				//Shoot missiles
				if (attack_frame == 20)
					{
					for(var i = 0; i < array_length(custom_ids_struct.final_smash_targets); i++)
						{
						var _target = custom_ids_struct.final_smash_targets[@ i];
						for(var m = 0; m < 3; m++)
							{
							var _missile = entity_create(x, y, obj_final_smash1_missile);
							_missile.custom_ids_struct.target = _target;
							_missile.custom_entity_struct.lifetime = 60 + (90 * m) + (15 * i);
							_missile.custom_entity_struct.dir = prng_number(i + m, 120, 70);
							_missile.image_angle = _missile.custom_entity_struct.dir;
							_missile.image_xscale = 2;
							_missile.image_yscale = 2;
							}
						}
						
					//Poof VFX
					var _vfx = vfx_create(spr_dust_poof, 1, 0, 28, x, y - 24, 2, 0, "VFX_Layer_Below");
					_vfx.vfx_xscale *= prng_choose(0, -1, 1);
					_vfx.vfx_yscale *= prng_choose(1, -1, 1);
					
					//No more invincibility
					invulnerability_set(INV.normal, -1);
					hurtbox_reset();
					
					//Change the animation back to Idle
					anim_reset();
					}
					
				if (attack_frame == 0)
					{
					attack_stop();
					}
				break;
				}
			}
		}
	//No movement
}
/* Copyright 2023 Springroll Games / Yosi */