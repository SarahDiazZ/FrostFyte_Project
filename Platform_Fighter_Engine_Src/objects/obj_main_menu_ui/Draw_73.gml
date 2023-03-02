///@description
var _array = mis_devices_get_array();
for(var i = 0; i < array_length(_array); i++)
	{
	var _cursor = i;
	var _x = ui_cursor_x(_cursor);
	var _y = ui_cursor_y(_cursor);
	var _col = player_color_get(i);
	draw_sprite_ext(spr_menu_cursor, 0, round(_x), round(_y), 1, 1, 0, _col, 1);
	}
/* Copyright 2023 Springroll Games / Yosi */