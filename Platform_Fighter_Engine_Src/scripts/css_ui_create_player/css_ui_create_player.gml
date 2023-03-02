///@func css_ui_create_player(number,player_id,group,index,size_number)
///@param number
///@param player_id
///@param group
///@param index
///@param size_number
///@desc Creates the UI for a single player on the character select screen.
function css_ui_create_player() {
	var _num = argument[0];
	var _id = argument[1];
	var _group = argument[2];
	var _index = argument[3];
	var _size = argument[4];
	var _layer = "UI_Players_Layer";
	var _cpu = css_player_get(_id, CSS_PLAYER.is_cpu);
	var _color = player_color_get(_num, _cpu);
	var _h = color_get_hue(_color), _s = color_get_saturation(_color), _v = color_get_value(_color);
	var _color_hover = make_color_hsv(_h, _s, _v + 20);
	var _color_clicked = make_color_hsv(_h, _s - 20, _v + 30);

	if (_size == 0)
		{
		var _x = 40 + (_num * 224);
		var _y = 344;

		//Group
		with(instance_create_layer(_x, _y, _layer, obj_ui_group))
			{
			ui_set_group(id, _group);
			}
		//Player-only
		if (!_cpu)
			{
			//Player Name
			with(instance_create_layer(_x + 8, _y + 152, _layer, obj_ui_label))
				{
				ui_script_step = css_ui_player_name_label_step;
				text = "PLAYER " + string(_num + 1);
				halign = -1;
				player_id = _id;
				ui_set_group(id, _group);
				image_blend = c_dkgray;
				ui_script_step();
				}
			with(instance_create_layer(_x, _y + 152, _layer, obj_ui_button))
				{
				depth += 1;
				ui_script_step = css_ui_player_name_button_step;
				image_xscale = 5;
				image_yscale = 1;
				ui_set_group(id, _group);
				player_id = _id;
				index = _index;
				anyone_can_interact = false;
				ui_button_colors_set(id, _color, _color_hover, _color_clicked);
				ui_script_step();
				}
			//Controls Button
			with(instance_create_layer(_x + 184, _y + 168, _layer, obj_ui_image))
				{
				sprite_index = spr_icon_controls;
				ui_set_group(id, _group);
				}
			with(instance_create_layer(_x + 160, _y + 152, _layer, obj_ui_button))
				{
				depth += 1;
				ui_script_step = css_ui_player_controls_button_step;
				image_xscale = 1.5;
				image_yscale = 1;
				ui_set_group(id, _group);
				player_id = _id;
				index = _index;
				anyone_can_interact = false;
				ui_script_step();
				}
			}
		//CPU-only
		else
			{
			//CPU Type Button
			with(instance_create_layer(_x + 184, _y + 168, _layer, obj_ui_image))
				{
				sprite_index = spr_icon_cpu_settings;
				ui_set_group(id, _group);
				}
			with(instance_create_layer(_x + 160, _y + 152, _layer, obj_ui_button))
				{
				depth += 1;
				ui_script_step = css_ui_player_cpu_type_button_step;
				image_xscale = 1.5;
				image_yscale = 1;
				ui_set_group(id, _group);
				player_id = _id;
				index = _index;
				anyone_can_interact = true;
				ui_script_step();
				}
			}
		//Player Window
		with(instance_create_layer(_x + 104, _y + 76, _layer, obj_css_player_window))
			{
			sprite_index = spr_css_random;
			ui_set_group(id, _group);
			player_id = _id;
			size = _size;
			number = _num;
			//Get the custom controls struct
			custom_controls_struct = profile_get(css_player_get(_id, CSS_PLAYER.profile), PROFILE.custom_controls);
			half_width = 104;
			half_height = 76;
			//Make sure to activate the cursor
			if (!_cpu)
				{
				var _custom = css_player_get(player_id, CSS_PLAYER.custom);
				_custom.cursor_active = true;
				}
			}
		//Team switcher
		if (setting().match_team_mode)
			{
			with(instance_create_layer(_x, _y, _layer, obj_ui_button))
				{
				depth += 1;
				ui_script_step = css_ui_player_team_button_step;
				image_xscale = 5.75;
				image_yscale = 0.75;
				ui_set_group(id, _group);
				player_id = _id;
				index = _index;
				text = "Team " + string(css_player_get(player_id, CSS_PLAYER.team));
				anyone_can_interact = true;
				ui_script_step();
				}
			}
		//Close button
		with(instance_create_layer(_x + 196, _y + 12, _layer, obj_ui_image))
			{
			depth += 1;
			sprite_index = spr_icon_close;
			ui_set_group(id, _group);
			}
		with(instance_create_layer(_x + 184, _y, _layer, obj_ui_button))
			{
			depth += 2;
			ui_script_step = css_ui_player_delete_button_step;
			image_xscale = 0.75;
			image_yscale = 0.75;
			ui_set_group(id, _group);
			player_id = _id;
			index = _index;
			anyone_can_interact = _cpu;
			ui_script_step();
			}
		//Back Color
		with(instance_create_layer(_x, _y, _layer, obj_ui_section))
			{
			depth += 3;
			image_xscale = 6.5;
			image_yscale = 5.75;
			image_blend = c_gray;
			ui_set_group(id, _group);
			}
		}
	else if (_size == 1)
		{
		var _x = 4 + (_num * 120);
		var _y = 344;

		//Group
		with(instance_create_layer(_x, _y, _layer, obj_ui_group))
			{
			ui_set_group(id, _group);
			}
		//Player-only
		if (!_cpu)
			{
			//Player Name
			with(instance_create_layer(_x + 8, _y + 152, _layer, obj_ui_label))
				{
				ui_script_step = css_ui_player_name_label_step;
				text = "PLAYER " + string(_num + 1);
				halign = -1;
				player_id = _id;
				ui_set_group(id, _group);
				image_blend = c_dkgray;
				ui_script_step();
				}
			with(instance_create_layer(_x, _y + 152, _layer, obj_ui_button))
				{
				depth += 1;
				ui_script_step = css_ui_player_name_button_step;
				image_xscale = 2.5;
				image_yscale = 1;
				ui_set_group(id, _group);
				player_id = _id;
				index = _index;
				anyone_can_interact = false;
				ui_button_colors_set(id, _color, _color_hover, _color_clicked);
				ui_script_step();
				}
			//Controls Button
			with(instance_create_layer(_x + 96, _y + 168, _layer, obj_ui_image))
				{
				sprite_index = spr_icon_controls;
				ui_set_group(id, _group);
				}
			with(instance_create_layer(_x + 80, _y + 152, _layer, obj_ui_button))
				{
				depth += 1;
				ui_script_step = css_ui_player_controls_button_step;
				image_xscale = 1;
				image_yscale = 1;
				ui_set_group(id, _group);
				player_id = _id;
				index = _index;
				anyone_can_interact = false;
				ui_script_step();
				}
			}
		//CPU-only
		else
			{
			//CPU Type Button
			with(instance_create_layer(_x + 96, _y + 168, _layer, obj_ui_image))
				{
				sprite_index = spr_icon_cpu_settings;
				ui_set_group(id, _group);
				}
			with(instance_create_layer(_x + 80, _y + 152, _layer, obj_ui_button))
				{
				depth += 1;
				ui_script_step = css_ui_player_cpu_type_button_step;
				image_xscale = 1;
				image_yscale = 1;
				ui_set_group(id, _group);
				player_id = _id;
				index = _index;
				anyone_can_interact = true;
				ui_script_step();
				}
			}
		//Player Window
		with(instance_create_layer(_x + 56, _y + 76, _layer, obj_css_player_window))
			{
			sprite_index = spr_css_random;
			ui_set_group(id, _group);
			player_id = _id;
			size = _size;
			number = _num;
			//Get the custom controls struct
			custom_controls_struct = profile_get(css_player_get(_id, CSS_PLAYER.profile), PROFILE.custom_controls);
			half_width = 56;
			half_height = 76;
			//Make sure to activate the cursor
			if (!_cpu)
				{
				var _custom = css_player_get(player_id, CSS_PLAYER.custom);
				_custom.cursor_active = true;
				}
			}
		//Team switcher
		if (setting().match_team_mode)
			{
			with(instance_create_layer(_x, _y, _layer, obj_ui_button))
				{
				depth += 1;
				ui_script_step = css_ui_player_team_button_step;
				image_xscale = 2.75;
				image_yscale = 0.75;
				ui_set_group(id, _group);
				player_id = _id;
				index = _index;
				text = "Team " + string(css_player_get(player_id, CSS_PLAYER.team));
				anyone_can_interact = true;
				ui_script_step();
				}
			}
		//Close button
		with(instance_create_layer(_x + 100, _y + 12, _layer, obj_ui_image))
			{
			depth += 1;
			sprite_index = spr_icon_close;
			ui_set_group(id, _group);
			}
		with(instance_create_layer(_x + 88, _y, _layer, obj_ui_button))
			{
			depth += 2;
			ui_script_step = css_ui_player_delete_button_step;
			image_xscale = 0.75;
			image_yscale = 0.75;
			ui_set_group(id, _group);
			player_id = _id;
			index = _index;
			anyone_can_interact = _cpu;
			ui_script_step();
			}
		//Back Color
		with(instance_create_layer(_x, _y, _layer, obj_ui_section))
			{
			depth += 3;
			image_xscale = 3.5;
			image_yscale = 5.75;
			image_blend = c_gray;
			ui_set_group(id, _group);
			}
		}
	else
		{
		crash("[css_ui_create_player] Invalid size (", _size, "), must be either 0 or 1!");
		}
}
/* Copyright 2023 Springroll Games / Yosi */