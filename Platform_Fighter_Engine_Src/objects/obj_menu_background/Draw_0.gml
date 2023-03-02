if (setting().performance_mode) then exit;

var _s = 96;
var _half = _s / 2;
var _w = ceil(room_width / _s);
var _h = ceil(room_height / _s);
var _hue = color_get_hue(color);
var _sat = color_get_saturation(color);
var _val = color_get_value(color);

for(var i = 0; i < _w; i++)
	{
	for(var m = 0; m < _h; m++)
		{
		var _a = (dsin((current_time / 41) + (i * 26) + (m * 24)) * dcos((current_time / 57) + (m * 48))) * 0.3;
		var _tx = dsin((current_time / 36) + (i * 66) + (m * 30));
		var _ty = dcos((current_time / 24) + (i * 48) + (m * 59));
		var _v = dsin((current_time / 15) + (i * 57) + (m * 4));
		var _xs = clamp
			(
			(_tx * 0.5) + 0.5,
			0.1,
			1,
			);
		var _ys = clamp
			(
			(_ty * 0.5) + 0.5,
			0.1,
			1,
			);
		var _col = make_color_hsv
			(
			_hue,
			_sat,
			_val + (_v * 50) + 100,
			);
		draw_sprite_ext(spr_white_tile, 0, (i * _s) + _half, (m * _s) + _half, _xs * 5, _ys * 5, 0, _col, _a);
		}
	}
draw_set_alpha(1.0);
/* Copyright 2023 Springroll Games / Yosi */