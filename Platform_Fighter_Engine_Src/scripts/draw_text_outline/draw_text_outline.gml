///@param {real} x				The x position
///@param {real} y				The y position
///@param {string} string		The text to draw
///@param {color} [main]		The main color
///@param {color} [outline]		The outline color
///@param {int} [width]			The width of the outline
/*
Draws text at the given coordinates with an outline of the given color.
*/
function draw_text_outline() {
	var _x = round(argument[0]);
	var _y = round(argument[1]);
	var _s = argument[2];
	var _main = argument_count > 3 ? argument[3] : c_white;
	var _outline = argument_count > 4 ? argument[4] : c_black;
	var _w = argument_count > 5 ? argument[5] : 1;
	
	draw_set_color(_outline);

	draw_text(_x + _w, _y, _s);
	draw_text(_x - _w, _y, _s);
	draw_text(_x, _y + _w, _s);
	draw_text(_x, _y - _w, _s);

	draw_set_color(_main);

	draw_text(_x, _y, _s);
}
/* Copyright 2023 Springroll Games / Yosi */