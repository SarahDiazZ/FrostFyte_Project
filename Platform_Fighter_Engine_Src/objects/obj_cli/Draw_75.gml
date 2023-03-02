if (!in_focus) then exit;

draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_font(fnt_consolas);

var _pad = 4;
var _sep = 18;
var _max = screen_width div 2;
var _y = screen_height;
var _text = cli_text_get(cli);
draw_rectangle_color(0, _y - _sep, _max, _y + 1, c_black, c_black, c_black, c_black, false);
draw_set_color(c_white);
draw_text(_pad, _y, _text + "_");
var _spaces = string_count(" ", _text);
var _array = autocomplete;
for(var i = 0; i < array_length(_array); i++)
	{
	_y -= _sep;
	var _command = _array[@ i][@ 0];
	draw_rectangle_color(0, _y - _sep, _max, _y + 1, c_black, c_black, c_black, c_black, false);
	draw_set_color(_array[@ i][@ 3]);
	draw_text(_pad, _y, _command);
	var _x = _pad + string_width(_command + " ");
	for(var m = 0; m < array_length(_array[@ i][@ 1]); m++)
		{
		draw_set_color(_spaces == (m + 1) ? c_white : c_ltgray);
		draw_text(_x, _y, _array[@ i][@ 1][@ m]);
		_x += string_width(_array[@ i][@ 1][@ m] + " ");
		}
	}


/* Copyright 2023 Springroll Games / Yosi */