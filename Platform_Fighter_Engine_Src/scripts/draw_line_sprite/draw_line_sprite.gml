///@param {real} x1			The first x
///@param {real} y1			The first y
///@param {real} x2			The second x
///@param {real} y2			The second y
///@param {real} width		The width of the line
///@param {color} color		The color of the line
/*
Draws a line using a single pixel sprite.
*/
function draw_line_sprite() {
	var _x1 = argument[0];
	var _y1 = argument[1];
	var _x2 = argument[2];
	var _y2 = argument[3];
	var _width = argument[4];
	var _color = argument[5];
	var _dir = point_direction(_x1, _y1, _x2, _y2);
	var _len = point_distance(_x1, _y1, _x2, _y2);
	draw_sprite_ext
		(
		spr_pixel, 
		0,
		_x1 + lengthdir_x(_width / 2, _dir + 90),
		_y1 + lengthdir_y(_width / 2, _dir + 90),
		_len,
		_width,
		_dir,
		_color,
		1,
		);
}

/* Copyright 2023 Springroll Games / Yosi */