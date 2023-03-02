function nspec_sword_swing_draw() {
	//Neutral Special - Draw
	if (attack_phase > 0 || (attack_phase == 0 && attack_frame <= 4))
		{
		var _clear = background_get_clear_amount();
		var _cn = merge_color(c_black, palette_color_get(palette_data, 1), _clear);
		var _ct = merge_color(c_black, c_white, _clear);
		var _length = array_length(custom_attack_struct.swings);
		draw_primitive_begin(pr_trianglestrip);
		draw_vertex_color(x, y, _ct, 0);
		for(var i = 0; i < _length; i++)
			{
			var _dir = custom_attack_struct.swings[@ i];
			var _a = (i / (_length - 1));
			draw_vertex_color(x + lengthdir_x(30, _dir), y + lengthdir_y(30, _dir), (i == _length - 1 ? _ct : _cn), _a);
			draw_vertex_color(x + lengthdir_x(80, _dir), y + lengthdir_y(80, _dir), _ct, _a);
			}
		draw_primitive_end();
		}
}
/* Copyright 2023 Springroll Games / Yosi */