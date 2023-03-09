function css_ui_player_window_draw() {
	switch(state)
		{
		case CSS_PLAYER_WINDOW_STATE.select_character:
			//Surface
			if (!surface_exists(surf))
				{
				surf = surface_create(half_width * 2, half_height * 2);
				}
				
			surface_set_target(surf);
			draw_clear_alpha(c_white, 0);
			
			//Draw the character
			var _char = css_player_get(player_id, CSS_PLAYER.character);
			var _color = css_player_get(player_id, CSS_PLAYER.color);
			if (!setting().disable_shaders)
				{
				palette_shader_simple_set
					(
					character_data_get(_char, CHARACTER_DATA.palette_column_arrays)[@ 0], 
					character_data_get(_char, CHARACTER_DATA.palette_column_arrays)[@ _color],
					);
				draw_sprite_ext(character_data_get(_char, CHARACTER_DATA.CSS), 0, half_width, half_height, css_character_sprite_scale, css_character_sprite_scale, 0, c_white, 1);
				shader_reset();
				}
			else
				{
				var _blend = palette_color_get(character_data_get(_char, CHARACTER_DATA.palette_data), 0, _color);
				draw_sprite_ext(character_data_get(_char, CHARACTER_DATA.CSS), 0, half_width, half_height, css_character_sprite_scale, css_character_sprite_scale, 0, _blend, 1);
				}
			
			surface_reset_target();
			draw_surface(surf, x - half_width, y - half_height);
			break;
		case CSS_PLAYER_WINDOW_STATE.select_profile:
			//Draw background
			var _c = $666666;
			draw_rectangle_color(x - half_width, y - half_height, x + half_width - 1, y + half_height - 1, _c, _c, _c, _c, false);
			
			//Draw profiles
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
			draw_set_color(c_white);
			draw_set_font(fnt_consolas);
			var _pad = half_height div 2;
			var _half = _pad div 2;
			var _c = c_dkgray;
			for(var i = 0; i < min(profile_count(), 4); i++)
				{
				var _num = profile_scroll + i;
				if (profile_current == _num) then draw_rectangle_color(x - half_width, y - half_height + (_pad * i), x + half_width - 1, y - half_height + (_pad - 1) + (_pad * i), _c, _c, _c, _c, false);
				draw_text(x - half_width + 28, y - half_height + _half + (_pad * i), profile_get(_num, PROFILE.name));
				if (profile_get(_num, PROFILE.autogenerated))
					{
					draw_sprite(spr_icon_profile_auto, 0, x - half_width, y - half_height + _half + (_pad * i));
					}
				}
			break;
		case CSS_PLAYER_WINDOW_STATE.create_profile:
			//Draw background
			var _c = $666666;
			draw_rectangle_color(x - half_width, y - half_height, x + half_width - 1, y + half_height, _c, _c, _c, _c, false);
			
			//Draw the letters
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(c_white);
			draw_set_font(fnt_consolas);
			draw_text(x, y - 32, "Profile Name:");
			draw_set_alpha(0.25);
			draw_text(x - 32, y, profile_valid_letters[modulo(profile_new_letter - 2, array_length(profile_valid_letters))]);
			draw_text(x + 32, y, profile_valid_letters[modulo(profile_new_letter + 2, array_length(profile_valid_letters))]);
			draw_set_alpha(0.75);
			draw_text(x - 16, y, profile_valid_letters[modulo(profile_new_letter - 1, array_length(profile_valid_letters))]);
			draw_text(x + 16, y, profile_valid_letters[modulo(profile_new_letter + 1, array_length(profile_valid_letters))]);
			draw_set_alpha(1);
			draw_rectangle_color(x - 9, y - 12, x + 9, y + 12, c_dkgray, c_dkgray, c_dkgray, c_dkgray, false);
			draw_text(x, y, profile_valid_letters[profile_new_letter]);
			draw_text(x, y + 32, profile_new_name);
			break;
		case CSS_PLAYER_WINDOW_STATE.controls:
			//Draw background
			var _c = $666666;
			draw_rectangle_color(x - half_width, y - half_height, x + half_width - 1, y + half_height - 1, _c, _c, _c, _c, false);
			
			//Custom controls selection
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(c_white);
			draw_set_font(fnt_consolas);
			var _type = css_player_get(player_id, CSS_PLAYER.device_type);
			var _cc = custom_controls_struct;
			var _pad = half_height div 2;
			var _half = _pad div 2;
			var _c = c_dkgray;
			var _inputs;
			if (_type == DEVICE.controller)
				{
				_inputs = _cc.inputs_controller;
				for(var i = 0; i < 4; i++)
					{
					var _num = custom_controls_scroll + i;
					var _y = (_pad * i);
					if (custom_controls_current == _num) then draw_rectangle_color(x - half_width, y - half_height + _y, x + half_width - 1, y - half_height + (_pad - 1) + _y, _c, _c, _c, _c, false);
					//Inputs
					if (_num < CC_INPUT_CONTROLLER.LENGTH)
						{
						//The larger sized player windows also write the input name
						//Currently does not suppor controller-specific or keyboard-specific input names
						if (size == 0 && _num < INPUT.LENGTH)
							{
							draw_set_halign(fa_center);
							draw_text(x, y - half_height + _half + _y, input_name_get(_num));
							}
						draw_sprite(spr_icon_inputs, _num, x - half_width + 16, y - half_height + _half + _y);
						var _array = _inputs[@ _num];
						for(var m = 0; m < array_length(_array); m++)
							{
							draw_sprite(spr_icon_input_button_universal, _array[@ m], x + half_width - 12 - (16 * m), y - half_height + _half + _y);
							}
						}
					//Right stick input
					else if (_num == CC_INPUT_CONTROLLER.LENGTH)
						{
						draw_sprite(spr_icon_inputs, 24, x - half_width + 16, y - half_height + _half + _y);
						if (size == 0)
							{
							draw_set_halign(fa_center);
							draw_text(x, y - half_height + _half + _y, "Rstick");
							}
						draw_set_halign(fa_right);
						draw_text(x + half_width - 4, y - half_height + _half + _y, input_name_get(_cc.right_stick_input));
						draw_set_halign(fa_center);
						}
					//SCS
					else if (_num <= SCS.LENGTH + CC_INPUT_KEYBOARD.LENGTH)
						{
						draw_set_halign(fa_center);
						var _n = (_num - CC_INPUT_CONTROLLER.LENGTH - 1);
						var _scs_array = _cc.scs;
						draw_set_alpha(_scs_array[@ _n] ? 1.0 : 0.25);
						draw_text(x, y - half_height + _half + _y, scs_name_get(_n));
						draw_set_alpha(1);
						}
					//ACS
					else
						{
						draw_set_halign(fa_center);
						var _n = (_num - CC_INPUT_CONTROLLER.LENGTH - SCS.LENGTH - 1);
						var _acs_array = _cc.acs;
						draw_text(x, y - half_height + _half + _y, acs_name_get(_n) + " " + acs_value_string(_n, _acs_array[@ _n]));
						}
					}
				}
			else if (_type == DEVICE.keyboard)
				{
				_inputs = _cc.inputs_keyboard;
				for(var i = 0; i < 4; i++)
					{
					var _num = custom_controls_scroll + i;
					var _y = (_pad * i);
					if (custom_controls_current == _num) then draw_rectangle_color(x - half_width, y - half_height + _y, x + half_width - 1, y - half_height + (_pad - 1) + _y, _c, _c, _c, _c, false);
					//Inputs
					if (_num < CC_INPUT_KEYBOARD.LENGTH)
						{
						//The larger sized player windows also write the input name
						//Currently does not suppor controller-specific or keyboard-specific input names
						if (size == 0 && _num < INPUT.LENGTH)
							{
							draw_set_halign(fa_center);
							draw_text(x, y - half_height + _half + _y, input_name_get(_num));
							}
						draw_sprite(spr_icon_inputs, _num, x - half_width + 16, y - half_height + _half + _y);
						draw_set_halign(fa_right);
						var _text = "";
						var _array = _inputs[@ _num];
						for(var m = 0; m < array_length(_array); m++)
							{
							_text += " " + key_to_string(_array[@ m]);
							}
						draw_text(x + half_width - 8, y - half_height + _half + _y, _text);
						}
					//Right stick input
					else if (_num == CC_INPUT_KEYBOARD.LENGTH)
						{
						draw_sprite(spr_icon_inputs, 24, x - half_width + 16, y - half_height + _half + _y);
						if (size == 0)
							{
							draw_set_halign(fa_center);
							draw_text(x, y - half_height + _half + _y, "Rstick");
							}
						draw_set_halign(fa_right);
						draw_text(x + half_width - 4, y - half_height + _half + _y, input_name_get(_cc.right_stick_input));
						draw_set_halign(fa_center);
						}
					//SCS
					else if (_num <= SCS.LENGTH + CC_INPUT_KEYBOARD.LENGTH)
						{
						draw_set_halign(fa_center);
						var _n = (_num - CC_INPUT_KEYBOARD.LENGTH - 1);
						var _scs_array = _cc.scs;
						draw_set_alpha(_scs_array[@ _n] ? 1.0 : 0.25);
						draw_text(x, y - half_height + _half + _y, scs_name_get(_n));
						draw_set_alpha(1);
						}
					//ACS
					else
						{
						draw_set_halign(fa_center);
						var _n = (_num - CC_INPUT_KEYBOARD.LENGTH - SCS.LENGTH - 1);
						var _acs_array = _cc.acs;
						draw_text(x, y - half_height + _half + _y, acs_name_get(_n) + " " + acs_value_string(_n, _acs_array[@ _n]));
						}
					}
				draw_set_halign(fa_center);
				}
			else if (_type == DEVICE.touch)
				{
				_inputs = _cc.inputs_touch;
				for(var i = 0; i < 4; i++)
					{
					var _num = custom_controls_scroll + i;
					var _y = (_pad * i);
					if (custom_controls_current == _num) then draw_rectangle_color(x - half_width, y - half_height + _y, x + half_width - 1, y - half_height + (_pad - 1) + _y, _c, _c, _c, _c, false);
					//Inputs
					if (_num < CC_INPUT_TOUCH.LENGTH)
						{
						//The larger sized player windows also write the input name
						//Currently does not suppor controller-specific or keyboard-specific input names
						if (size == 0 && _num < INPUT.LENGTH)
							{
							draw_set_halign(fa_center);
							draw_text(x, y - half_height + _half + _y, input_name_get(_num));
							}
						draw_sprite(spr_icon_inputs, _num, x - half_width + 16, y - half_height + _half + _y);
						draw_set_halign(fa_right);
						var _text = "";
						var _array = _inputs[@ _num];
						for(var m = 0; m < array_length(_array); m++)
							{
							_text += " " + string(_array[@ m]);
							}
						draw_text(x + half_width - 8, y - half_height + _half + _y, _text);
						}
					//Right stick input
					else if (_num == CC_INPUT_TOUCH.LENGTH)
						{
						draw_sprite(spr_icon_inputs, 24, x - half_width + 16, y - half_height + _half + _y);
						if (size == 0)
							{
							draw_set_halign(fa_center);
							draw_text(x, y - half_height + _half + _y, "Rstick");
							}
						draw_set_halign(fa_right);
						draw_text(x + half_width - 4, y - half_height + _half + _y, input_name_get(_cc.right_stick_input));
						draw_set_halign(fa_center);
						}
					//SCS
					else if (_num <= SCS.LENGTH + CC_INPUT_KEYBOARD.LENGTH)
						{
						draw_set_halign(fa_center);
						var _n = (_num - CC_INPUT_KEYBOARD.LENGTH - 1);
						var _scs_array = _cc.scs;
						draw_set_alpha(_scs_array[@ _n] ? 1.0 : 0.25);
						draw_text(x, y - half_height + _half + _y, scs_name_get(_n));
						draw_set_alpha(1);
						}
					//ACS
					else
						{
						draw_set_halign(fa_center);
						var _n = (_num - CC_INPUT_KEYBOARD.LENGTH - SCS.LENGTH - 1);
						var _acs_array = _cc.acs;
						draw_text(x, y - half_height + _half + _y, acs_name_get(_n) + " " + acs_value_string(_n, _acs_array[@ _n]));
						}
					}
				draw_set_halign(fa_center);
				}
			break;
		case CSS_PLAYER_WINDOW_STATE.control_set:
			//Draw background
			var _c = $666666;
			draw_rectangle_color(x - half_width, y - half_height, x + half_width - 1, y + half_height, _c, _c, _c, _c, false);
			
			//Custom controls selection
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(c_white);
			draw_set_font(fnt_consolas);
			var _type = css_player_get(player_id, CSS_PLAYER.device_type);
			draw_text(x, y - 16, cc_input_name_get(_type, custom_controls_current) + ":");
			var _length = array_length(custom_controls_array);
			if (_type == DEVICE.controller)
				{
				var _x = x - ((16 * _length) / 2) + 8;
				for(var i = 0; i < _length; i++)
					{
					draw_sprite(spr_icon_input_button_universal, custom_controls_array[i], _x + (16 * i), y + 16);
					}
				}
			else if (_type == DEVICE.keyboard)
				{
				var _text = "";
				for(var i = 0; i < _length; i++)
					{
					if (i > 0) then _text += " ";
					_text += key_to_string(custom_controls_array[i]);
					}
				draw_text(x, y + 16, _text);
				}
			else if (_type == DEVICE.touch)
				{
				var _text = "";
				for(var i = 0; i < _length; i++)
					{
					if (i > 0) then _text += " ";
					_text += string(custom_controls_array[i]);
					}
				draw_text(x, y + 16, _text);
				}
			break;
		}
}
/* Copyright 2023 Springroll Games / Yosi */