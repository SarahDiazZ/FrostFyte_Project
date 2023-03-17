///@description Overhead, HUD, Timer, Debug
//Camera surface
if (camera_can_zoom() && surface_exists(cam_surface))
	{
	draw_clear(c_white);
	draw_surface(cam_surface, 0, 0);
	}

//Fade amount
var _fade = background_get_clear_amount();
var _teams = setting().match_team_mode;

//If the game is not in the cutscene state
if (state != GAME_STATE.cutscene)
	{
	#region Overhead
	with(obj_player)
		{
		if (!is_knocked_out())
			{
			var _yoff = -38;
			var _x = round(screen_x(x));
			var _y = round(screen_y(bbox_top + _yoff));
			
			//Overhead callback
			callback_run(callback_overhead, [_x, _y]);
			
			//Overhead options
			if (setting().show_overhead_name)
				{
				draw_set_font(fnt_consolas);
				var _name = player_name;
				var _size = (string_width(_name) / 2) + 1;
				draw_set_halign(fa_center);
				draw_set_valign(fa_middle);
				draw_set_alpha(0.5);
				draw_set_color(_teams ? player_color_get(player_team) : c_black);
				draw_rectangle(_x - _size, _y - 8, _x + _size, _y + 8, false);
				draw_set_alpha(1);
				draw_set_color(_teams ? c_black : c_white);
				draw_text(_x, _y, _name);
				_y -= 17;
				}
			if (setting().show_overhead_damage)
				{
				var _percent = match_has_stamina_set() ? stamina : damage;
				var _stocks = match_has_stock_set() ? stock : 0;
				draw_damage_text_overhead
					(
					_x,
					_y,
					_percent,
					spr_damage_font_small,
					10,
					1,
					calculate_damage_color(damage),
					_stocks,
					spr_heart_symbol,
					);
				_y -= 17;
				}
			if (setting().show_overhead_arrow)
				{
				draw_sprite_ext(spr_facing_symbol, facing == 1 ? 0 : 1, _x, _y, 1, 1, 0, player_color_get(player_number), 1);
				_y -= 17;
				}
		
			//Frame Advantage
			if (setting().show_frame_advantage)
				{
				if (variable_struct_exists(custom_passive_struct, "frame_advantage_count") &&
					variable_struct_exists(custom_passive_struct, "frame_advantage_value"))
					{
					var _value = custom_passive_struct.frame_advantage_value;
					var _color = _value >= 0 ? c_lime : c_red;
					var _outline = custom_passive_struct.frame_advantage_count ? c_white : c_black;
					draw_set_font(fnt_notice);
					draw_set_halign(fa_center);
					draw_set_valign(fa_middle);
					draw_text_outline(_x, _y, string(_value), _color, _outline);
					_y -= 17;
					}
				}
		
			//Combo counter
			if (setting().show_combos && combo_counter > 0 && combo_target != noone)
				{
				draw_set_font(fnt_notice);
				draw_set_halign(fa_center);
				draw_set_valign(fa_middle);
				draw_text_outline(_x, _y, string(round(combo_counter)), calculate_damage_color(combo_counter * 7), c_black);
				_y -= 17;
				}
			}
		}
	#endregion
	
	#region HUD
	if (setting().show_hud)
		{
		//Font settings
		draw_set_font(fnt_consolas);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_color(c_white);
		
		//HUD types
		var _hs = player_hud_scale;
		switch(player_hud_type)
			{
			#region Normal
			case HUD_TYPE.normal:
				//Fade out all HUD bars if any players are under them
				var _collide_fade = 0;
				for(var i = 0; i < ds_list_size(ordered_player_list); i++)
					{
					var _left_side = (i % 2 == 0);
					var _x = (_left_side)
						? (64 - (i div 2) * 4) * _hs
						: screen_width - ((64 - (i div 2) * 4) * _hs);
					var _y = (8 + (i div 2) * 16) * _hs;
					var _fade_w = 72 * _hs;
					var _fade_h = 32 * _hs;
					with(obj_player)
						{
						if (point_in_rectangle
							(
							screen_x(x), 
							screen_y(y), 
							_x - _fade_w, 
							_y - _fade_h, 
							_x + _fade_w, 
							_y + _fade_h,
							))
							{
							_collide_fade = 0.75;
							break;
							}
						}
					if (_collide_fade > 0) then break;
					}
					
				//HUD bars
				for(var i = 0; i < ds_list_size(ordered_player_list); i++)
					{
					var _player = ordered_player_list[| i];
					var _accent = _teams ? player_color_get(_player.player_team) : player_color_get(i);
					
					//Positions
					var _left_side = (i % 2 == 0);
					var _mult = (_left_side ? 1 : -1);
					var _x = (_left_side)
						? (64 - (i div 2) * 4) * _hs
						: screen_width - ((64 - (i div 2) * 4) * _hs);
					var _y = (8 + (i div 2) * 16) * _hs;
					
					//Fade out bars if the player is lost
					var _stored_fade = _collide_fade;
					if (_player.state == PLAYER_STATE.lost)
						{
						_collide_fade = 0.75;
						}
						
					//HUD bar back
					draw_sprite_ext
						(
						spr_player_hud,
						_left_side ? 0 : 1,
						_x, 
						_y, 
						_hs,
						_hs,
						0,
						_accent,
						_fade - _collide_fade,
						);
						
					//Name
					var _x = (_left_side)
						? 4 * _hs
						: screen_width - (4 * _hs);
					draw_set_halign(_left_side ? fa_left : fa_right);
					draw_set_valign(fa_center);
					draw_set_alpha(_fade - _collide_fade);
					
					var _name = "";
					if (player_hud_profile_names)
						{
						_name = profile_get(player_data_get(_player.player_number, PLAYER_DATA.profile), PROFILE.name);
						}
					else
						{
						_name = character_data_get(_player.character, CHARACTER_DATA.name);
						}
					draw_text(_x, _y, _name);
					draw_set_alpha(1);
					_x += _mult * (string_width(_name) + (12 * _hs));
					
					//Score (In Time-only matches)
					if (match_has_time_set() && !match_has_stock_set())
						{
						draw_text_outline(_x, _y, _player.points);
						}
					//Stocks
					else
						{
						var _blend = c_white;
						if (!setting().disable_shaders)
							{
							palette_shader_simple_rgb_set(_player.palette_base, _player.palette_swap);
							}
						else
							{
							_blend = palette_color_get(_player.palette_data, 0);
							}
					
						if (_player.stock <= 5)
							{
							for(var m = 0; m < _player.stock; m++)
								{
								draw_sprite_ext
									(
									_player.stock_sprite,
									0,
									_x + (m * 9 * _hs * _mult),
									_y,
									_hs,
									_hs,
									0,
									_blend,
									_fade - _collide_fade,
									);
								}
							}
						//Abbreviated stock
						else
							{
							draw_sprite_ext
								(
								_player.stock_sprite,
								0,
								_x,
								_y,
								_hs,
								_hs,
								0,
								_blend,
								_fade - _collide_fade,
								);
							//Text
							shader_reset();
							draw_set_alpha(_fade - _collide_fade);
							draw_text(_x + (6 * _hs * _mult), _y, _player.stock);
							draw_set_alpha(1);
							}
						
						shader_reset();
						}
					
					//Move the x position to the end of the bar
					var _x = (_left_side)
						? (110 - (i div 2) * 4) * _hs
						: screen_width - ((110 - (i div 2) * 4) * _hs);
					
					//Damage / Stamina
					//Don't draw if the player is lost
					if (_player.state != PLAYER_STATE.lost)
						{
						var _percent = match_has_stamina_set() ? _player.stamina : _player.damage;
						draw_damage_text
							(
							_x + prng_number(0, _player.damage_text_random, -_player.damage_text_random) * 0.5,
							_y + prng_number(1, _player.damage_text_random, -_player.damage_text_random) * 0.5,
							_percent,
							spr_damage_font_small,
							5 * _hs,
							_hs * 0.5,
							calculate_damage_color(_player.damage),
							_fade - _collide_fade,
							player_hud_damage_percent ? spr_percent_symbol : undefined,
							!_left_side,
							);
						}
						
					//Move the position
					_x += (_left_side) ? 48 : -48;
		
					//Run the character HUD callback
					callback_run(_player.callback_hud, [_x, _y, _player, (_fade - _collide_fade), _left_side]);
					
					_collide_fade = _stored_fade;
					}
				break;
			#endregion
			#region Legacy
			case HUD_TYPE.legacy:
				var _cache = [];
				
				//HUD back
				for(var i = 0; i < ds_list_size(ordered_player_list); i++)
					{
					var _struct = {};
			
					//Get accent color
					var _player = ordered_player_list[| i];
					var _accent = _teams ? player_color_get(_player.player_team) : player_color_get(i);
			
					//X and Y positions
					var _x = player_hud_width * (i + 1);
					var _y = player_hud_y;
			
					//Fade out bars if the player is lost
					var _collide_fade = 0;
					if (_player.state == PLAYER_STATE.lost)
						{
						_collide_fade = 0.75;
						}
					else
						{
						//Fade out HUD bars if any players are under them
						var _fade_w = 48 * _hs;
						var _fade_h = 34 * _hs;
						with(obj_player)
							{
							if (point_in_rectangle
								(
								screen_x(x), 
								screen_y(y), 
								_x - _fade_w, 
								_y - _fade_h, 
								_x + _fade_w, 
								_y + _fade_h,
								))
								{
								_collide_fade = 0.75;
								break;
								}
							}
						}
					
					//HUD bar back
					draw_sprite_ext
						(
						spr_player_hud_legacy,
						0,
						_x, 
						_y, 
						_hs,
						_hs,
						0,
						_accent,
						_fade - _collide_fade,
						);
						
					//Cache
					_struct.player = _player;
					_struct.accent = _accent;
					_struct.x = _x;
					_struct.y = _y;
					_struct.collide_fade = _collide_fade;
					array_push(_cache, _struct);
					}
		
				//HUD front
				for(var i = 0; i < ds_list_size(ordered_player_list); i++)
					{
					//Get cached values
					var _struct = _cache[@ i];
					var _player = _struct.player;
					var _accent = _struct.accent;
					var _x = _struct.x;
					var _y = _struct.y;
					var _collide_fade = _struct.collide_fade;
		
					var _blend = c_white;
					if (!setting().disable_shaders)
						{
						palette_shader_simple_rgb_set(_player.palette_base, _player.palette_swap);
						}
					else
						{
						_blend = palette_color_get(_player.palette_data, 0);
						}
	
					//Portrait sprite
					draw_sprite_ext
						(
						_player.portrait,
						0,
						_x, 
						_y, 
						_hs,
						_hs,
						0,
						_blend,
						_fade - _collide_fade,
						);
		
					//Stocks
					if (_player.stock <= 5)
						{
						for(var m = 0; m < _player.stock; m++)
							{
							draw_sprite_ext
								(
								_player.stock_sprite,
								0,
								_x + (m * 9 * _hs) + (24 * _hs),
								_y - (24 * _hs),
								_hs,
								_hs,
								0,
								_blend,
								_fade - _collide_fade,
								);
							}
						}
					//Abbreviated stock
					else
						{
						draw_sprite_ext
							(
							_player.stock_sprite,
							0,
							_x + (33 * _hs),
							_y - (24 * _hs),
							_hs,
							_hs,
							0,
							_blend,
							_fade - _collide_fade,
							);
						//Text
						shader_reset();
						draw_set_alpha(_fade - _collide_fade);
						draw_text_outline(player_hud_width * (i + 1) + (40 * _hs), player_hud_y - (24 * _hs), to_string("- ", _player.stock));
						draw_set_alpha(1);
						}
	
					shader_reset();
	
					//HUD bar front
					draw_sprite_ext
						(
						spr_player_hud_legacy,
						1,
						_x,
						_y,
						_hs,
						_hs,
						0,
						_accent,
						_fade - _collide_fade,
						);
		
					//Damage / Stamina
					//Don't draw if the player is lost
					if (_player.state != PLAYER_STATE.lost)
						{
						var _percent = match_has_stamina_set() ? _player.stamina : _player.damage;
						draw_damage_text
							(
							(23 * _hs) + _x + prng_number(0, _player.damage_text_random, -_player.damage_text_random),
							_y + prng_number(1, _player.damage_text_random, -_player.damage_text_random),
							_percent,
							spr_damage_font_medium,
							17 * _hs,
							_hs,
							calculate_damage_color(_player.damage),
							_fade - _collide_fade,
							player_hud_damage_percent ? spr_percent_symbol : undefined,
							);
						}
		
					//Name
					draw_set_alpha(_fade - _collide_fade);
					if (player_hud_profile_names)
						{
						draw_text_outline(_x + (12 * _hs), _y + (17 * _hs), profile_get(player_data_get(_player.player_number, PLAYER_DATA.profile), PROFILE.name));
						}
					else
						{
						draw_text_outline(_x + (12 * _hs), _y + (17 * _hs), character_data_get(_player.character, CHARACTER_DATA.name));
						}
		
					//Score (In Time-only matches)
					if (match_has_time_set() && !match_has_stock_set())
						{
						draw_text_outline(_x + (24 * _hs), _y - (24 * _hs), _player.points);
						}
					draw_set_alpha(1);
		
					//Run the character HUD callback
					callback_run(_player.callback_hud, [_x, _y, _player, (_fade - _collide_fade)]);
					}
				break;
			#endregion
			}
		}
	#endregion
	
	#region Offscreen Radar
	if (setting().show_offscreen_radar)
		{
		//Animation
		offscreen_radar_alpha = max(0, offscreen_radar_alpha - 0.1);
	
		//Check if any player is out of the view on the sides or the bottom
		var _b = obj_stage_manager.blastzones;
		with(obj_player)
			{
			if (!point_in_rectangle(x, y, other.cam_x, other.cam_y, other.cam_x + other.cam_w, other.cam_y + other.cam_h) && !is_knocked_out())
				{
				//Choose the orientation
				if (other.offscreen_radar_alpha <= 0)
					{
					if (x < _b.left + ((_b.right - _b.left) div 2)) then other.offscreen_radar_flip_x = false;
					else other.offscreen_radar_flip_x = true;
					if (y < _b.top + ((_b.bottom - _b.top) div 2)) then other.offscreen_radar_flip_y = false;
					else other.offscreen_radar_flip_y = true;
					}
				other.offscreen_radar_alpha = min(1, other.offscreen_radar_alpha + 0.3);
				break;
				}
			}
		
		var _calc_alpha = (offscreen_radar_alpha * _fade);
		if (_calc_alpha > 0)
			{
			//Draw the rectangle
			var _c = c_black;
			var _pad = 32;
			var _scale = 10;
			var _w = abs(_b.right - _b.left) div _scale;
			var _h = abs(_b.bottom - _b.top) div _scale;
			var _x = (!offscreen_radar_flip_x ? _pad : screen_width - _pad - _w);
			var _y = (!offscreen_radar_flip_y ? _pad : screen_height - _pad - _h);
			draw_set_alpha(_calc_alpha * 0.3);
			draw_rectangle_color(_x, _y, _x + _w, _y + _h, _c, _c, _c, _c, false);
			if (camera_can_zoom())
				{
				draw_rectangle_color
					(
					_x + ((cam_x - _b.left) div _scale), 
					_y + ((cam_y - _b.top) div _scale), 
					_x + ((cam_x + cam_w - _b.left) div _scale), 
					_y + ((cam_y + cam_h - _b.top) div _scale), 
					_c, _c, _c, _c, 
					false,
					);
				}
			draw_set_alpha(1);
		
			for(var i = 0; i < ds_list_size(ordered_player_list); i++)
				{
				//Draw the dot
				var _player = ordered_player_list[| i];
				var _is_knocked_out = false;
				with(_player)
					{
					if (is_knocked_out())
						{
						_is_knocked_out = true;
						break;
						}
					}
				if (_is_knocked_out) then continue;
				var _accent = _teams ? player_color_get(_player.player_team) : player_color_get(i);
				draw_sprite_ext
					(
					spr_offscreen_radar_dot,
					0, 
					_x + ((_player.x - _b.left) div _scale),
					_y + ((_player.y - _b.top) div _scale),
					1,
					1,
					0,
					_accent,
					_calc_alpha,
					);
				}
			}
		}
	#endregion
	
	#region Timer
	if (match_has_time_set() && countdown <= countdown_start_time && setting().show_timer)
		{
		var _time = ceil((setting().match_time * 60) - (game_time / 60));
		draw_match_time(center_x, 32, _time, spr_damage_font_medium, 20, 1, (_time < 60) ? c_red : c_white, _fade);
		}
	#endregion
	
	#region 1v1 Scoreboard
	if (hud_1v1_scoreboard_enable && hud_1v1_scoreboard_frame > 0 && state != GAME_STATE.ending)
		{
		var _intro_frame = min(hud_1v1_scoreboard_total_frames - hud_1v1_scoreboard_frame, 10);
		var _alpha = (_intro_frame / 10) * _fade;
		var _y = screen_height div 2;
		draw_set_font(fnt_scoreboard);
		draw_set_halign(fa_center);
		draw_set_valign(fa_center);
		
		//The score is either the player's stock, or their number of points in timed matches
		for(var i = 0; i < 2; i++)
			{
			var _player = ordered_player_list[| i];
			with(_player)
				{
				//Background rectangle
				var _dir = (i == 0)
					? 1
					: -1;
				var _anchor = (i == 0)
					? 0
					: screen_width;
				var _x = _anchor + (_intro_frame * 30 * _dir);
				
				draw_set_color(c_black);
				draw_set_alpha(_alpha * 0.75);
				draw_rectangle(min(_anchor, _x + (48 * _dir)), _y - 16, max(_anchor, _x + (48 * _dir)), _y + 16, false);
				draw_set_alpha(_alpha);
				
				//Score
				var _score = 0;
				if (match_has_stock_set()) then _score = stock;
				else if (match_has_time_set()) then _score = points;
				
				draw_text_outline(_x, _y, _score, c_white, c_black, 2);
				
				//Stocks
				var _blend = c_white;
				if (!setting().disable_shaders)
					{
					palette_shader_simple_rgb_set(palette_base, palette_swap);
					}
				else
					{
					_blend = palette_color_get(palette_data, 0);
					}
				
				_x -= (80 * _dir);
				for(var m = 0; m < stock; m++)
					{
					_x -= (32 * _dir);
					draw_sprite_ext
						(
						stock_sprite,
						0,
						_x,
						_y,
						2,
						2,
						0,
						_blend,
						_alpha,
						);
					}
					
				shader_reset();
				}
			}
			
		draw_text_outline(screen_width div 2, _y, "-", c_white, c_black, 2);
		draw_set_alpha(1);
		}
	#endregion
	}

#region Startup sequence
if ((state == GAME_STATE.startup || state == GAME_STATE.normal) && countdown > 0)
	{
	//Countdown
	var _frame = countdown div countdown_start_time;
	var _scale = lerp(2.2, 2, (countdown % countdown_start_time) / countdown_start_time);
	var _alpha = lerp(0, 2, (countdown % countdown_start_time) / countdown_start_time);
	draw_sprite_ext(spr_countdown, _frame, center_x, center_y, _scale, _scale, 0, c_white, _alpha);
	}
#endregion

#region Ending sequence
if (state == GAME_STATE.ending)
	{
	//First 4 frames don't display anything (to make online play smoother)
	var _diff = (game_end_time - game_end_frame);
	if (_diff > 4)
		{
		//Fade in over the next 10 frames
		var _col = c_black;
		if (_diff < 14)
			{
			draw_set_alpha(lerp(0, 0.5, _diff / 14));
			draw_rectangle_color(0, 0, screen_width, screen_height, _col, _col, _col, _col, false);
			draw_set_alpha(1);
			var _scale = 2;
			var _alpha = lerp(0, 1, _diff / 14);
			draw_sprite_ext(spr_finish, 0, center_x, center_y, _scale, _scale, 0, c_white, _alpha);
			}
		else
			{
			draw_set_alpha(0.5);
			draw_rectangle_color(0, 0, screen_width, screen_height, _col, _col, _col, _col, false);
			draw_set_alpha(1);
			var _scale = 2;
			var _alpha = lerp(0, 2, game_end_frame / game_end_time);
			draw_sprite_ext(spr_finish, 0, center_x, center_y, _scale, _scale, 0, c_white, _alpha);
			}
		}
	}
#endregion

#region Hold to Pause
if (setting().pause_hold_input)
	{
	if (pause_hold_frame > buffer_time_standard)
		{
		var _amount = pause_hold_frame / pause_hold_time;
		var _x = screen_width div 2;
		var _y = screen_height div 2;
		draw_set_font(fnt_window);
		draw_set_alpha(_amount);
		draw_set_color(c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text_outline(_x, _y, "Hold to Pause", c_white, c_black, 1);
		draw_set_alpha(1);
		}
	}
#endregion

#region Pause Menu
if (meta_state == GAME_META_STATE.paused)
	{
	//Frame Advance
	if (frame_advance_active)
		{
		draw_set_color(c_black);
		draw_set_alpha(0.5);
		draw_rectangle(8, 8, 328, 86, false);
		draw_set_alpha(1);
		draw_set_font(fnt_consolas);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_color(c_white);
		draw_text(16, 16, "Total Frames: " + string(current_frame));
		draw_text(16, 32, "Frame Number: " + string(frames_advanced));
		draw_text(16, 48, "Press Start/" + key_to_string(menu_start_key, true) + " to go to the next frame");
		draw_text(16, 64, "Press Select/" + key_to_string(menu_select_key, true) + " to exit frame advance");
		}
	else
		{
		//Menu
		var _size = 160;
		var _pad = 48;
		var _c = $333333;
		draw_rectangle_color(screen_width - _size, 0, screen_width, screen_height, _c, _c, _c, _c, false);
		draw_set_font(fnt_consolas);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_color(c_white);
		var _x = screen_width - _size;
		for(var i = 0; i < array_length(pause_menu_choices); i++)
			{
			var _y = (i * _pad);
			//Current choice
			if (pause_menu_current == i)
				{
				_c = pause_menu_color;
				draw_rectangle_color(_x, _y, _x + _size, _y + _pad, _c, _c, _c, _c, false);
				_c = $333333;
				}
			else
				{
				_c = $858585;
				}
			var _index = 0;
			switch(pause_menu_choices[@ i])
				{
				case "RESUME": _index = 0; break;
				case "FRAME ADVANCE": _index = 1; break;
				case "RESTART": _index = 2; break;
				case "EXIT": _index = 3; break;
				case "SAVE CLIP": _index = 4; break;
				}
			draw_sprite_ext(pause_menu_choices_sprite, _index, _x + 24, _y + (_pad / 2), 1, 1, 0, _c, 1);
			draw_set_color(_c);
			draw_text(_x + 95, _y + (_pad / 2), pause_menu_choices[@ i]);
			}
		}
	}
#endregion

#region Clip saving
if (meta_state == GAME_META_STATE.saving_clip)
	{
	draw_set_alpha(0.75);
	draw_set_color(c_black);
	draw_rectangle(0, 0, screen_width, screen_height, false);
	draw_set_alpha(1);
	var _x = screen_width div 2;
	var _y = screen_height div 2;
	var _w = 100;
	var _h = 4;
	draw_set_color(c_dkgray);
	draw_rectangle(_x - _w, _y - _h, _x + _w, _y + _h, false);
	draw_set_color(pause_menu_color);
	var _p = (clip_saving_progress / clip_length);
	draw_rectangle(_x - _w, _y - _h, _x - _w + (_p * (_w * 2)), _y + _h, false);
	draw_set_font(fnt_window);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(_x, _y - 32, "Saving clip...");
	}
#endregion

#region Game option icons
if (state == GAME_STATE.startup)
	{
	var _x = 16;
	var _y = 16;
	var _pad = 24;
	if (!setting().replay_record)
		{
		draw_sprite(spr_game_options_icons, 0, _x, _y);
		_x += _pad;
		}
	if (clip_can_record())
		{
		draw_sprite(spr_game_options_icons, 1, _x, _y);
		_x += _pad;
		}
	if (setting().debug_mode_enable)
		{
		draw_sprite(spr_game_options_icons, 2, _x, _y);
		_x += _pad;
		}
	}
#endregion

#region Debugging
if (setting().debug_mode_enable)
	{
	draw_set_font(fnt_consolas);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	//Dynamic resources
	if (debug_menus.resources)
		{
		draw_set_color(c_black);
		draw_rectangle(0, 16, 128, 32 * 10, false);
		draw_set_color(c_white);
		draw_text(16, 32 * 1, "GRIDS: " + string(resource_counts.grid));
		draw_text(16, 32 * 2, "LISTS: " + string(resource_counts.list));
		draw_text(16, 32 * 3, "MAPS: " + string(resource_counts.map));
		draw_text(16, 32 * 4, "PRIORITES: " + string(resource_counts.priority));
		draw_text(16, 32 * 5, "QUEUES: " + string(resource_counts.queue));
		draw_text(16, 32 * 6, "STACKS: " + string(resource_counts.stack));
		draw_text(16, 32 * 7, "BUFFERS: " + string(resource_counts.buffer));
		draw_text(16, 32 * 8, "SURFACES: " + string(resource_counts.surface));
		draw_text(16, 32 * 9, "INSTANCES: " + string(resource_counts.instance));
		}
		
	//Overlay
	if (debug_menus.overlay)
		{
		draw_set_color(c_ltgray);
		draw_rectangle(0, 0, room_width, 24, false);
		}
		
	//Player input buffers
	if (debug_menus.inputs)
		{
		with(obj_player)
			{
			var _start_x = player_number * (array_length(input_buffer) * 5);
			var _c = c_white;
			var _shade = 255 / INPUT.LENGTH;
			for(var i = 0; i < (INPUT.LENGTH * 2); i++)
				{
				_c = make_color_hsv((i mod INPUT.LENGTH) * _shade, 255, 255);
				draw_rectangle_color(_start_x + i * 5, 0, _start_x + 4 + i * 5, input_buffer[@ i] * 2, _c, _c, _c, _c, false);
				draw_rectangle_color(_start_x + i * 5, input_buffer[@ i] * 2, _start_x + 4 + i * 5, 3 + input_buffer[@ i] * 2, c_black, c_black, c_black, c_black, false);
				}
			}
		}
	
	//Sync IDs
	if (debug_menus.sync_ids)
		{
		draw_rectangle_color(screen_width - 150, 32, screen_width, 250, 0, 0, 0, 0, false);
		draw_set_halign(fa_right);
		draw_set_valign(fa_top);
		draw_set_color(c_white);
		for(var i = 0; i < array_length(obj_sync_id_system.sync_objects); i++)
			{
			var _obj = object_get_name(obj_sync_id_system.sync_objects[i]);
			var _array = obj_sync_id_system.sync_grid[# SYNC_GRID.structs, i];
			draw_text(screen_width - 8, 48 + (32 * i), _obj + ": " + string(array_length(_array)));
			}
		}
	}
#endregion

#region FPS
if (setting().debug_fps)
	{
	draw_set_font(fnt_consolas);
	draw_set_color(c_black);
	draw_set_halign(fa_right);
	draw_set_valign(fa_top);
	draw_text(screen_width - 8, 8, to_string("FPS Avg: ", fps_avg, " Min: ", fps_min, " Max: ", fps_max));
	}
#endregion
/* Copyright 2023 Springroll Games / Yosi */