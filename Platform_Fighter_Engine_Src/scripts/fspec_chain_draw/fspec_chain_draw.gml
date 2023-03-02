function fspec_chain_draw() {
	//Forward Special
	if (attack_phase == 1)
		{
		var _col = palette_color_get(palette_data, 1);
		var _px = x;
		var _py = y;
		for(var i = 0; i < array_length(custom_attack_struct.segments); i++)
			{
			var _seg = custom_attack_struct.segments[i];
			var _x = _seg[0];
			var _y = _seg[1];
			draw_line_width_color(_px, _py, _x, _y, 2, _col, _col);
			_px = _x;
			_py = _y;
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */