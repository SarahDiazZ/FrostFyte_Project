///@description Replay HUD

//Inherit the parent event
event_inherited();
	
if (meta_state == GAME_META_STATE.paused_replay && replay_draw_hud)
	{
	var _x = 32;
	var _y = 32;
	var _pad = 24;
	draw_set_font(fnt_consolas);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	//Normal replay menu
	if (!replay_camera_mode && !replay_took_control)
		{
		//Fade
		draw_set_alpha(0.5);
		draw_set_color(c_black);
		draw_rectangle(16, 16, 284, _pad * 10, false);
		draw_set_alpha(1);
	
		for(var i = 0; i < array_length(replay_menu_choices); i++)
			{
			if (i == replay_menu_current)
				{
				draw_set_color(c_white);
				draw_rectangle(_x - 10, _y - 2, _x - 6, _y + 2, false);
				}
			else
				{
				draw_set_color(c_ltgray);
				}
			var _choice = replay_menu_choices[@ i];
			switch(_choice)
				{
				case "Resume":
				case "Save Clip":
				case "Camera Mode":
				case "Hide HUD":
				case "Quit":
					draw_text(_x, _y, _choice);
					break;
				case "Playback Speed":
					draw_text(_x, _y, "Playback Speed [" + string(replay_playback_speed) + "x]");
					break;
				case "Frame Advance":
					draw_text_and_sprites
						(
						_x, _y,
							[
							"Frame Advance (",
							[spr_icon_input_button_universal, gamepad_button_number(menu_start_button)],
							" or ",
							key_to_string(menu_start_key, true),
							")",
							],
						0,
						);
					break;
				case "Take Control":
					draw_text(_x, _y, "Take Control <Player " + string(replay_control_player + 1) + ">");
					break;
				default: crash("[obj_game_replay: Draw GUI] Unknown replay menu choice \"", _choice, "\""); 
				}
			_y += _pad;
			}
		draw_set_color(c_white);
		}
	//Camera Mode
	else if (replay_camera_mode)
		{
		//Fade
		draw_set_alpha(0.5);
		draw_set_color(c_black);
		draw_rectangle(16, 16, 284, _pad * 9, false);
		draw_set_alpha(1);
		
		draw_set_color(c_white);
		draw_text_and_sprites
			(
			_x, _y,
				[
				"Move (",
				"Left Stick",
				" or ",
				"Arrow Keys",
				")",
				],
			0,
			);
		_y += _pad;
		draw_text_and_sprites
			(
			_x, _y,
				[
				"Zoom In (",
				[spr_icon_input_button_universal, gamepad_button_number(menu_page_next_button)],
				" or ",
				key_to_string(menu_page_next_key, true),
				")",
				],
			0,
			);
		_y += _pad;
		draw_text_and_sprites
			(
			_x, _y,
				[
				"Zoom Out (",
				[spr_icon_input_button_universal, gamepad_button_number(menu_page_last_button)],
				" or ",
				key_to_string(menu_page_last_key, true),
				")",
				],
			0,
			);
		_y += _pad;
		draw_text_and_sprites
			(
			_x, _y,
				[
				"Frame Advance (",
				[spr_icon_input_button_universal, gamepad_button_number(menu_start_button)],
				" or ",
				key_to_string(menu_start_key, true),
				")",
				],
			0,
			);
		_y += _pad;
		draw_text_and_sprites
			(
			_x, _y,
				[
				"Hide HUD (",
				[spr_icon_input_button_universal, gamepad_button_number(menu_option_button)],
				" or ",
				key_to_string(menu_option_key, true),
				")",
				],
			0,
			);
		_y += _pad;
		draw_text_and_sprites
			(
			_x, _y,
				[
				"Resume (",
				[spr_icon_input_button_universal, gamepad_button_number(menu_back_button)],
				" or ",
				key_to_string(menu_back_key, true),
				")",
				],
			0,
			);
		_y += _pad;
		draw_text_and_sprites
			(
			_x, _y,
				[
				"Cancel Camera Mode (",
				[spr_icon_input_button_universal, gamepad_button_number(menu_remove_button)],
				" or ",
				key_to_string(menu_remove_key, true),
				")",
				],
			0,
			);
		_y += _pad;
		}
	//Control
	else if (replay_took_control)
		{
		//Fade
		draw_set_alpha(0.5);
		draw_set_color(c_black);
		draw_rectangle(16, 16, 256, _pad * 3, false);
		draw_set_alpha(1);
		
		draw_set_color(c_white);
		draw_text_and_sprites
			(
			_x, _y,
				[
				"Frame Advance (",
				[spr_icon_input_button_universal, gamepad_button_number(menu_start_button)],
				" or ",
				key_to_string(menu_start_key, true),
				")",
				],
			0,
			);
		_y += _pad;
		draw_text_and_sprites
			(
			_x, _y,
				[
				"End Control (",
				[spr_icon_input_button_universal, gamepad_button_number(menu_select_button)],
				" or ",
				key_to_string(menu_select_key, true),
				")",
				],
			0,
			);
		_y += _pad;
		}

	if (!replay_camera_mode && !replay_took_control)
		{
		//Progress bar
		var _x = 32;
		var _y = screen_height - 40;
		var _w = screen_width - (_x * 2);
		var _h = 8;
		var _pad = 8;
		draw_set_color(c_dkgray);
		draw_rectangle(_x - 2, _y - 2, _x + _w + 2, _y + _h + 2, false);
		draw_set_color(c_white);
		draw_rectangle(_x, _y, _x + (_w * (current_frame / engine().replay_total_frames)), _y + _h, false);
	
		//KOs
		var _kos = array_length(engine().replay_player_ko_frames);
		for(var i = 0; i < _kos; i++)
			{
			var _data = engine().replay_player_ko_frames[@ i];
			var _p = (_data.frame / engine().replay_total_frames);
			var _palette_column_arrays = character_data_get(_data.character, CHARACTER_DATA.palette_column_arrays);
			palette_shader_simple_set(_palette_column_arrays[@ 0], _palette_column_arrays[@ _data.color]);
			draw_sprite_ext(character_data_get(_data.character, CHARACTER_DATA.stock_sprite), 0, _x + (_w * _p), _y - (_pad * _data.number), 2, 2, 0, c_white, 1);
			shader_reset();
			}
		}
	}
/* Copyright 2023 Springroll Games / Yosi */