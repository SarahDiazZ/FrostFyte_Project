///@description Draw Backgrounds
if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	//Local vars
	var _fade = false;
	var _shader = false;
	var _w = obj_game.cam_w;
	var _h = obj_game.cam_h;
	var _cam_center_x = obj_game.cam_x + (_w / 2);
	var _cam_center_y = obj_game.cam_y + (_h / 2);
	var _cam_dist_x = (half_room_width - obj_game.cam_x - (_w / 2));
	var _cam_dist_y = (half_room_height- obj_game.cam_y - (_h / 2));

	//Loop through the layers of the background and draw each
	for(var i = 0; i < array_length(background); i++)
		{
		var _layer = background[@ i];
	
		if (_layer[@ BACK.sprite] != -1)
			{
			//Fade layers above the clear layer
			if (_fade && background_clear_amount != 0 && !_shader && !setting().disable_shaders)
				{
				_shader = true;
				shader_set(shd_fade);
				shader_set_uniform_f(uni_black, 1 - background_clear_amount);
				}
		
			//If it has a special script, use that instead
			var _abs = _layer[@ BACK.absolute];
			var _draw_x = _abs ? 0 : _cam_center_x;
			var _draw_y = _abs ? 0 : _cam_center_y;
			if (_layer[@ BACK.script] != -1 && script_exists(_layer[@ BACK.script]))
				{
				script_execute(_layer[@ BACK.script], _layer, _draw_x, _draw_y, _cam_dist_x, _cam_dist_y);
				}
			else
				{
				//Draw according to properties
				draw_sprite_ext
					(
					_layer[@ BACK.sprite],
					_layer[@ BACK.frame],
					round(_draw_x + _layer[@ BACK.x] + (_cam_dist_x * _layer[@ BACK.parallax_x])),
					round(_draw_y + _layer[@ BACK.y] + (_cam_dist_y * _layer[@ BACK.parallax_y])),
					_layer[@ BACK.scale],
					_layer[@ BACK.scale],
					0,
					c_white,
					1
					);
				}
			}
		else
			{
			_fade = true;
			//Green Screen Debug
			if (setting().green_screen_color != 0)
				{
				var _c = c_lime;
				switch(setting().green_screen_color)
					{
					case 2: _c = c_blue; break;
					case 3: _c = c_red; break;
					case 4: _c = c_black; break;
					case 5: _c = c_white; break;
					}
				draw_rectangle_color(obj_game.cam_x, obj_game.cam_y, obj_game.cam_x + _w, obj_game.cam_y + _h, _c, _c, _c, _c, false);
				}
			
			//Draw the cutoff background layer
			draw_set_alpha(background_clear_amount);
			draw_rectangle_color
				(
				obj_game.cam_x, obj_game.cam_y,
				obj_game.cam_x + _w, obj_game.cam_y + _h,
				background_clear_color,
				background_clear_color,
				background_clear_color,
				background_clear_color,
				false
				);
			draw_set_alpha(1);
			
			//Draw cut lines
			if (background_clear_direction != -1)
				{
				var _cx = obj_game.cam_x + (_w / 2);
				var _cy = obj_game.cam_y + (_h / 2);
				var _dir = background_clear_direction;
				var _len = 400;
				var _hue = color_get_hue(background_clear_color);
				var _sat = color_get_saturation(background_clear_color);
				var _val = color_get_value(background_clear_color);
				var _accent_color = _val > 128 ? make_color_hsv(_hue, _sat, _val - 40) : make_color_hsv(_hue, _sat, _val + 40);
				draw_sprite_ext(spr_hit_final_lines, 0, _cx + lengthdir_x(_len, _dir + 90), _cy + lengthdir_y(_len, _dir + 90), -20, -7, _dir + 5, _accent_color, background_clear_amount);
				draw_sprite_ext(spr_hit_final_lines, 0, _cx - lengthdir_x(_len, _dir + 90), _cy - lengthdir_y(_len, _dir + 90), 20, 7, _dir - 5, _accent_color, background_clear_amount);
				}
			}
		}

	//Reset shader
	shader_reset();
	
	//Background fog
	if (background_fog_alpha > 0)
		{
		gpu_set_colorwriteenable(true, true, true, false);
		draw_set_alpha(clamp(background_fog_alpha - background_clear_amount, 0, 1));
		draw_set_color(background_fog_color);
		draw_rectangle(obj_game.cam_x, obj_game.cam_y, obj_game.cam_x + _w, obj_game.cam_y + _h, false);
		gpu_set_colorwriteenable(true, true, true, true);
		draw_set_alpha(1);
		}
		
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */