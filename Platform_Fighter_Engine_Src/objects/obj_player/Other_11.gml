///@description DRAW <Run by obj_player_renderer>

if (invisible) then exit;

if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	//Pre Draw
	callback_run(callback_draw_begin);
	
	//Tethering
	if (state == PLAYER_STATE.ledge_tether)
		{
		if (state_phase != 0)
			{
			var _accent = palette_color_get(palette_data, 1);
			draw_line_sprite(x, y, ledge_id.x, ledge_id.y, 6, c_black);
			draw_line_sprite(x, y, ledge_id.x, ledge_id.y, 2, _accent);
			}
			
		draw_sprite(spr_tether_target, 0, ledge_id.x, ledge_id.y);
		}
		
	//Player
	if (sprite_exists(anim_sprite))
		{
		if (draw_script != -1 && script_exists(draw_script))
			{
			draw_script();
			}
		else
			{
			player_draw_self();
			}
		}
	
	//Shielding
	if (state == PLAYER_STATE.shielding)
		{
		var _size = shield_size_min + ((shield_hp / shield_max_hp) * shield_size_multiplier);
		if (shieldstun > 0)
			{
			var _angle = (shieldstun div 4) * 90;
			draw_sprite_ext(spr_shield_stunned, 0, x + shield_shift_x, y + shield_shift_y, _size, _size, _angle, make_color_hsv((player_number * 80) % 255, 255, 255), image_alpha);
			}
		else
			{
			draw_sprite_ext(spr_shieldAlex, 0, x + shield_shift_x, y + shield_shift_y, _size, _size, 0, make_color_hsv((player_number * 80) % 255, 255, 255), image_alpha);
			}
		}
		
	//Respawning
	if (state == PLAYER_STATE.respawning)
		{
		if (!setting().disable_shaders)
			{
			shader_set(shd_fade);
			shader_set_uniform_f(shader_get_uniform(shd_fade, "fade_amount"), 1 + (sin(obj_game.current_frame / 10) * 0.05)); 
			}
		draw_sprite_ext
			(
			spr_respawn_platform, 
			0, 
			x, 
			(bbox_bottom - 1), 
			(sprite_scale * ((sprite_get_width(anim_sprite) + 16) / sprite_get_width(spr_respawn_platform))), 
			sprite_scale, 
			0, 
			image_blend, 
			image_alpha,
			);
		shader_reset();
		}
		
	//Post Draw
	callback_run(callback_draw_end);
		
	//Offscreen view
	if (!is_knocked_out() && !ignore_blastzones && obj_game.state != GAME_STATE.cutscene)
		{
		if (!point_in_rectangle(x, y, obj_game.cam_x, obj_game.cam_y, obj_game.cam_x + obj_game.cam_w, obj_game.cam_y + obj_game.cam_h))
			{
			if (surface_exists(obj_game.offscreen_view_surface))
				{
				surface_set_target(obj_game.offscreen_view_surface);
			
				var _coords = position_clamp_rectangle(x, y, 32, obj_game.cam_x, obj_game.cam_y, obj_game.cam_w, obj_game.cam_h);
				var _dir = point_direction(room_width div 2, room_height div 2, x, y);
				var _scale = clamp(2 - ((point_distance(_coords.x, _coords.y, x, y) / camera_boundary)), 0.1, 2);
				var _dis = 20 * _scale;
		
				draw_sprite_ext(spr_offscreen_view, 0, _coords.x, _coords.y, _scale, _scale, 0, c_white, 1);
		
				//Player sprite - with clipping mask
				gpu_set_colorwriteenable(true, true, true, false);
				if (sprite_exists(anim_sprite))
					{
					if (draw_script != -1 && script_exists(draw_script))
						{
						draw_script(_coords.x, _coords.y, (_scale / 2));
						}
					else
						{
						player_draw_self(_coords.x, _coords.y, (_scale / 2));
						}
					}
				gpu_set_colorwriteenable(true, true, true, true);
			
				draw_sprite_ext(spr_offscreen_pointer, 0, _coords.x + lengthdir_x(_dis, _dir), _coords.y + lengthdir_y(_dis, _dir), _scale, _scale, _dir, c_white, 1);
			
				surface_reset_target();
				}
			}
		}
	
	/* DEBUG */
	if (setting().show_collision_boxes)
		{
		draw_sprite_ext(mask_index, image_index, x, y, image_xscale, image_yscale, image_angle, collision_box_draw_color, 0.5);
		}
	if (setting().debug_mode_enable)
		{
		if (obj_game.debug_menus.overhead)
			{
			draw_set_font(fnt_consolas);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_set_color(c_white);
		
			//X and Y
			draw_text_outline(x - 64, y - 80, "X: " + string(x));
			draw_text_outline(x - 64, y - 64, "Y: " + string(y));

			//Control stick
			var _radius = 38;
			draw_circle(x, y, _radius, true);
			draw_circle(x + stick_get_value(Lstick, DIR.horizontal) * _radius, y + stick_get_value(Lstick, DIR.vertical) * _radius, 6, false);
			for(var i = 1; i < buffer_time_max; i++)
				{
				draw_set_alpha((buffer_time_max - i) / buffer_time_max);
				draw_line_width
					(
					x + stick_get_value(Lstick, DIR.horizontal, i - 1) * _radius, 
					y + stick_get_value(Lstick, DIR.vertical, i - 1) * _radius,
					x + stick_get_value(Lstick, DIR.horizontal, i) * _radius, 
					y + stick_get_value(Lstick, DIR.vertical, i) * _radius, 
					4,
					);
				}
			draw_set_alpha(1);
			
			//Previous states
			for(var i = 0; i < player_state_log_size; i++)
				{
				draw_text_outline(x + 32, y - 80 + (12 * i), player_state_name_get(state_log[@ i]));
				}
			}
		//*/
		}
		
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */