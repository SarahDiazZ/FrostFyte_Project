///@description
var _w = 400;
var _h = 400;
var _x = (room_width - _w) div 2;
var _y = room_height - ((room_height - _h) div 2);

draw_set_color(c_white);
draw_set_alpha(1);
draw_set_font(fnt_consolas);

draw_line(_x, _y, _x + _w, _y);
draw_line(_x, _y, _x, _y - _h);

var _max_dmg = 300;
var _dmg_div = 25;
var _max_kb = 50;
var _kb_div = 5;

draw_set_halign(fa_center);
draw_set_valign(fa_top);

for(var i = 0; i <= _max_dmg; i += _dmg_div)
	{
	draw_text(_x + ((i / _max_dmg) * _w), _y + 4, string(i));
	}
	
draw_set_halign(fa_right);
draw_set_valign(fa_middle);

for(var i = 0; i <= _max_kb; i += _kb_div)
	{
	draw_text(_x - 4, _y - ((i / _max_kb) * _h), string(i));
	}
	
var _prev_x1 = 0;
var _prev_y1 = 0;
var _prev_x2 = 0;
var _prev_y2 = 0;

for(var i = 0; i <= _w; i++)
	{
	if (i == 0)
		{
		_prev_x1 = _x + i;
		_prev_y1 = _y - (calculate_knockback((i / _w) * _max_dmg, damage1, 1, knockback_scaling1, base_knockback1, formula1) / _max_kb) * _h;
		_prev_x2 = _x + i;
		_prev_y2 = _y - (calculate_knockback((i / _w) * _max_dmg, damage2, 1, knockback_scaling2, base_knockback2, formula2) / _max_kb) * _h;
		}
	else
		{
		var _x1 = _x + i;
		var _y1 = _y - (calculate_knockback((i / _w) * _max_dmg, damage1, 1, knockback_scaling1, base_knockback1, formula1) / _max_kb) * _h;
		var _x2 = _x + i;
		var _y2 = _y - (calculate_knockback((i / _w) * _max_dmg, damage2, 1, knockback_scaling2, base_knockback2, formula2) / _max_kb) * _h;
		draw_set_color(c_green);
		draw_line
			(
			_prev_x1,
			_prev_y1,
			_x1,
			_y1,
			);
		draw_set_color(c_red);
		draw_line
			(
			_prev_x2,
			_prev_y2,
			_x2,
			_y2,
			);
		_prev_x1 = _x1;
		_prev_y1 = _y1;
		_prev_x2 = _x2;
		_prev_y2 = _y2;
		}
	}
/* Copyright 2023 Springroll Games / Yosi */