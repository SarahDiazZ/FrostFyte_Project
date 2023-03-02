///The HUD script for adding a final smash meter
function final_smash_meter_hud() {
	var _args = argument[0];
	var _x = _args[@ 0];
	var _y = _args[@ 1];
	var _player = _args[@ 2];
	var _alpha = _args[@ 3];
	
	
	//Make sure the variable is initialized
	if (!variable_struct_exists(_player.custom_passive_struct, "fs_meter"))
		{
		_player.custom_passive_struct.fs_meter = 0;
		}
	var _fs_meter = _player.custom_passive_struct.fs_meter;
	var _fs_meter_max = 600;
	draw_set_alpha(_alpha);
	draw_set_color(c_black);
	
	//HUD types
	switch(player_hud_type)
		{
		case HUD_TYPE.normal:
			var _width = 90;
			var _half_h = 6;
			var _left_side = _args[@ 4];
			if (_left_side)
				{
				draw_rectangle(_x - 2, _y - _half_h - 2, _x + _width + 2, _y + _half_h + 2, false);
				if (_fs_meter > 0)
					{
					if (final_smash_uses > 0)
						{
						draw_set_color(make_color_hsv(120, 127 + (dsin(obj_game.current_frame * 10) * 127), 255));
						draw_rectangle(_x - 1, _y - _half_h - 1, _x + (_width * (_fs_meter / _fs_meter_max)) + 1, _y + _half_h + 1, false);
						}
					else
						{
						draw_set_color(make_color_hsv(40 + (dsin(obj_game.current_frame) * 30), 150, 255));
						draw_rectangle(_x, _y - _half_h, _x + (_width * (_fs_meter / _fs_meter_max)), _y + _half_h, false);
						}
					}
				}
			else
				{
				draw_rectangle(_x - 2 - _width, _y - _half_h - 2, _x + 2, _y + _half_h + 2, false);
				if (_fs_meter > 0)
					{
					if (final_smash_uses > 0)
						{
						draw_set_color(make_color_hsv(120, 127 + (dsin(obj_game.current_frame * 10) * 127), 255));
						draw_rectangle(_x - 1 - (_width * (_fs_meter / _fs_meter_max)), _y - _half_h - 1, _x + 1, _y + _half_h + 1, false);
						}
					else
						{
						draw_set_color(make_color_hsv(40 + (dsin(obj_game.current_frame) * 30), 150, 255));
						draw_rectangle(_x - (_width * (_fs_meter / _fs_meter_max)), _y - _half_h, _x, _y + _half_h, false);
						}
					}
				}
			break;
		case HUD_TYPE.legacy:
			var _off_x = -15;
			var _off_y = -56;
			var _width = 90;
			var _half_w = _width div 2;
			var _half_h = 6;
			draw_rectangle(_x - _half_w + _off_x - 2, _y - _half_h + _off_y - 2, _x + _half_w + _off_x + 2, _y + _half_h + _off_y + 2, false);
			if (_fs_meter > 0)
				{
				if (final_smash_uses > 0)
					{
					draw_set_color(make_color_hsv(120, 127 + (dsin(obj_game.current_frame * 10) * 127), 255));
					draw_rectangle(_x - _half_w + _off_x - 1, _y - _half_h + _off_y - 1, _x - _half_w + (_width * (_fs_meter / _fs_meter_max)) + _off_x + 1, _y + _half_h + _off_y + 1, false);
					}
				else
					{
					draw_set_color(make_color_hsv(40 + (dsin(obj_game.current_frame) * 30), 150, 255));
					draw_rectangle(_x - _half_w + _off_x, _y - _half_h + _off_y, _x - _half_w + (_width * (_fs_meter / _fs_meter_max)) + _off_x, _y + _half_h + _off_y, false);
					}
				}
			break;
		}
	
	draw_set_alpha(1);
	return;
}
/* Copyright 2023 Springroll Games / Yosi */