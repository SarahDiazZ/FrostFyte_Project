///@description
if (state == CSS_STATE.normal)
	{
	//Cursors
	var _array = css_players_get_array();
	for(var i = 0; i < array_length(_array); i++)
		{
		var _id = _array[@ i];
		var _cpu = css_player_get(_id, CSS_PLAYER.is_cpu);
		if (_cpu) then continue;
		var _custom = css_player_get(_id, CSS_PLAYER.custom);
		var _device_id = _custom.device_id;
		var _cursor = _custom.cursor;
		var _cursor_active = _custom.cursor_active;
		if (_cursor_active)
			{
			var _stick_value = mis_device_stick_values(_device_id);
			var _x = 0;
			var _y = 0;
			if (_stick_value.hold > 0)
				{
				var _dir = point_direction(0, 0, _stick_value.x, _stick_value.y);
				var _len = ui_cursor_speed_calculate(_stick_value.x, _stick_value.y, menu_cursor_speed);
				_x = lengthdir_x(_len, _dir);
				_y = lengthdir_y(_len, _dir);
				}
			//Restrict cursor coordinates + Handle looping
			var _cx = ui_cursor_x(_cursor) + _x;
			var _cy = ui_cursor_y(_cursor) + _y;
			var _pad = 2;
			if (_cx < _pad || _cx > room_width - 1 - _pad || _cy < _pad || _cy > room_height - 1 - _pad)
				{
				_custom.cursor_loop_frame += 1;
				if (_custom.cursor_loop_frame > css_cursor_loop_time)
					{
					_cx = modulo(_cx, room_width - 1);
					_cy = modulo(_cy, room_height - 1);
					}
				else
					{
					_cx = clamp(_cx, _pad, room_width - 1 - _pad);
					_cy = clamp(_cy, _pad, room_height - 1 - _pad);
					}
				}
			else
				{
				_custom.cursor_loop_frame = 0;
				}
			ui_cursor_update
				(
				_cursor,
				_cx,
				_cy,
				false,
				mis_device_input(_device_id, MIS_INPUT.confirm),
				mis_device_input(_device_id, MIS_INPUT.confirm, true),
				);
			}
		else
			{
			ui_cursor_update(_cursor, 0, 0, true, false, 0);
			}
		
		//Tokens
		var _token_held = _custom.token_held;
	
		//Pick up tokens
		if (_token_held == noone)
			{
			if (mis_device_input(_device_id, MIS_INPUT.confirm))
				{
				//Loop through every token and check the distance
				for(var m = 0; m < array_length(_array); m++)
					{
					//You can only pick up your own token or CPU tokens
					if (_id == _array[@ m] || css_player_get(_array[@ m], CSS_PLAYER.is_cpu))
						{
						var _token = css_player_get(_array[@ m], CSS_PLAYER.custom).token;
						if (point_distance(ui_cursor_x(_cursor), ui_cursor_y(_cursor), _token.x, _token.y) < 40)
							{
							_custom.token_held = _array[@ m];
							break;
							}
						}
					}
				}
			}
		//If you are already holding a token
		else
			{
			//Putting down the token
			if (mis_device_input(_device_id, MIS_INPUT.confirm) ||
				mis_device_input(_device_id, MIS_INPUT.remove) ||
				mis_device_input(_device_id, MIS_INPUT.start))
				{
				//Selecting a character
				var _zone = instance_position(ui_cursor_x(_cursor), ui_cursor_y(_cursor), obj_css_zone);
				if (_zone != noone)
					{
					menu_sound_play(snd_menu_select);
					_zone.selected_animation_time = 1;
					css_player_set(_custom.token_held, CSS_PLAYER.character, _zone.character); 
				
					//Always change CPU color
					if (css_player_get(_custom.token_held, CSS_PLAYER.is_cpu))
						{
						css_player_set
							(
							_custom.token_held,
							CSS_PLAYER.color,
							css_character_color_get_next
								(
								_custom.token_held,
								css_player_get(_custom.token_held, CSS_PLAYER.character),
								css_player_get(_custom.token_held, CSS_PLAYER.color),
								1,
								)
							);
						}
					//Set players color to the first available color
					else
						{
						css_player_set
							(
							_custom.token_held,
							CSS_PLAYER.color,
							css_character_color_get_next
								(
								_custom.token_held,
								css_player_get(_custom.token_held, CSS_PLAYER.character),
								css_player_get(_custom.token_held, CSS_PLAYER.color) - 1, //Subtract 1 so it goes to the current color
								1,
								)
							);
						}
					}
				_custom.token_held = noone;
				}
			else
				{
				//Restrict cursor coordinates, so you can't take tokens out of the middle area
				ui_cursor_set(_cursor, UI_CURSOR.y, clamp(ui_cursor_y(_cursor), 34, 302));
				//Moving the token
				var _token = css_player_get(_custom.token_held, CSS_PLAYER.custom).token;
				_token.x = ui_cursor_x(_cursor);
				_token.y = ui_cursor_y(_cursor);
				//Highlight any character boxes that you move the token over, and select that character
				var _zone = instance_position(ui_cursor_x(_cursor), ui_cursor_y(_cursor), obj_css_zone);
				var _current_character = css_player_get(_custom.token_held, CSS_PLAYER.character);
				if (_zone != noone)
					{
					_zone.selected_animation_time = 0.5;
					//If the character is changed, also reset the color to prevent an out-of-bounds error if one character has less palette than another
					if (_zone.character != _current_character)
						{
						css_player_set(_custom.token_held, CSS_PLAYER.character, _zone.character);
						var _favorite_color = profile_get(css_player_get(_id, CSS_PLAYER.profile), PROFILE.favorite_colors)[@ _zone.character];
						css_player_set(_custom.token_held, CSS_PLAYER.color, _favorite_color);
						}
					}
				}
			}
		}
	}
//Match settings
else if (state == CSS_STATE.match_settings)
	{
	//Inputs
	var _id = match_settings_selector;
	var _custom = css_player_get(_id, CSS_PLAYER.custom);
	var _device_id = _custom.device_id;
	var _stick_press = mis_device_stick_press_repeated(_device_id);
	var _stick_values = mis_device_stick_values(_device_id);
	var _rl = sign(_stick_values.x);
	var _ud = sign(_stick_values.y);
	var _back = mis_device_input(_device_id, MIS_INPUT.back);
	var _confirm = mis_device_input(_device_id, MIS_INPUT.confirm);

	//Scrolling
	if (_stick_press.y)
		{
		menu_sound_play(snd_menu_move);
		match_settings_current = modulo(match_settings_current + _ud, array_length(match_settings_choices));
		}
		
	//Changing the settings
	if (_stick_press.x)
		{
		menu_sound_play(snd_menu_select);
		var _choice = match_settings_choices[@ match_settings_current];
		switch(_choice)
			{
			case "Stock":
				setting().match_stock = modulo(setting().match_stock + _rl, stock_value_limit + 1);
				break;
			case "Time":
				setting().match_time = modulo(setting().match_time + _rl, time_value_limit + 1);
				break;
			case "Stamina":
				var _vals = stamina_valid_values;
				stamina_index = modulo(stamina_index + _rl, array_length(_vals));
				setting().match_stamina = _vals[@ stamina_index];
				break;
			case "Teams":
				setting().match_team_mode ^= true;
				break;
			case "Team Attack":
				setting().match_team_attack ^= true;
				break;
			case "Items":
				var _vals = items_frequency_valid_values;
				items_frequency_index = modulo(items_frequency_index + _rl, array_length(_vals));
				setting().match_items_frequency = _vals[@ items_frequency_index];
				setting().match_items_enable = (setting().match_items_frequency > 0);
				break;
			case "Final Smash Meter":
				setting().match_fs_meter ^= true;
				break;
			case "Screen Wrap":
				setting().match_screen_wrap ^= true;
				break;
			case "EX Meter":
				setting().match_ex_meter ^= true;
				break;
			default: crash("[obj_css_ui: Step] Unrecognized match settings choice (", _choice, ")"); break;
			}
		}
		
	//Cancel
	if (_back || _confirm)
		{
		state = CSS_STATE.normal;
		match_settings_current = 0;
		match_settings_selector = noone;
		css_ui_refresh();
		}
	
	//Match settings animation
	match_settings_y = lerp(match_settings_y, 160, 0.2);
	ui_set_position(noone, 320, match_settings_y, 0);
	
	//Fade
	obj_ui_fade.fade_goal = 0.75;
	}
//Main Menu
else if (state == CSS_STATE.main_menu)
	{
	//Cancel when the main menu is no longer active
	if (!obj_main_menu_sidebar_ui.menu_active)
		{
		state = CSS_STATE.normal;
		}
	//Fade
	obj_ui_fade.fade_goal = 0.75;
	}

//Animations
if (state != CSS_STATE.match_settings)
	{
	//Match settings animation
	match_settings_y = lerp(match_settings_y, -256, 0.2);
	ui_set_position(noone, 320, match_settings_y, 0);
	}
if (state == CSS_STATE.normal)
	{
	//Fade
	obj_ui_fade.fade_goal = 0;
	}
	
//Hold to go back
css_back_button_timer = max(0, --css_back_button_timer);
/* Copyright 2023 Springroll Games / Yosi */