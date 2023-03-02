function ex_meter_overhead() {
	var _args = argument[0];
	var _x = _args[@ 0];
	var _y = _args[@ 1] + 22;
	
	//Variables
	var _p = custom_passive_struct;
	if (!variable_struct_exists(_p, "ex_meter")) then _p.ex_meter = 0;
	if (!variable_struct_exists(_p, "ex_max")) then _p.ex_max = ex_meter_max;
	if (!variable_struct_exists(_p, "ex_split")) then _p.ex_split = ex_meter_split;
	if (!variable_struct_exists(_p, "ex_move")) then _p.ex_move = false;
	
	//Don't draw when the background is cleared
	if (background_get_clear_amount() > 0)
		{
		if (_p.ex_split <= 1)
			{
			draw_set_color(c_black);
			draw_rectangle(_x - 50, _y - 12, _x + 50, _y, false);
			if (_p.ex_meter > 0)
				{
				draw_set_color(make_color_hsv((_p.ex_meter / _p.ex_max) * 255, 150, 255));
				draw_rectangle(_x - 48, _y - 10, _x - 48 + (96 * (_p.ex_meter / _p.ex_max)), _y - 2, false);
				}
			}
		else
			{
			var _size = 100 / _p.ex_split;
			var _half = (_size / 2);
			var _div = 2;
			var _margin = 2;
			var _split_size = floor(_p.ex_max / _p.ex_split);
			_x -= ((((_size + _div) * _p.ex_split) - _div) / 2) - _half;
			for(var i = 0; i < _p.ex_split; i++)
				{
				draw_set_color(c_black);
				draw_rectangle(_x - _half, _y - 12, _x + _half, _y, false);
				var _amount = 0;
				if (_p.ex_meter >= (i + 1) * _split_size) then _amount = _split_size;
				else _amount = (_p.ex_meter - (i * _split_size)) % _split_size;
				if (_amount > 0)
					{
					draw_set_color(make_color_hsv((100 + (50 * i)) % 255, 150, 255));
					draw_rectangle
						(
						_x - _half + _margin, 
						_y - 12 + _margin, 
						_x - _half + _margin + ((_size - (_margin * 2)) * (_amount / _split_size)),
						_y - _margin, 
						false,
						);
					}
				_x += _div + _size;
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */