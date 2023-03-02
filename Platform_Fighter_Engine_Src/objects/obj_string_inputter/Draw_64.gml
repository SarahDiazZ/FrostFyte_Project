///@description
var _padding = 160;
var _center = room_width div 2;

//Background
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(0, 0, screen_width, screen_height, false);
draw_set_alpha(1);

//Prompt
draw_set_color(c_white);
draw_set_font(fnt_consolas);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(_center, _padding, inputter_prompt);

//String
if (inputter_hidden)
	{
	var _str = "";
	repeat(string_length(inputter_string)) _str += "#";
	draw_text(_center, _padding + 48, "> " + _str);
	}
else
	{
	draw_text(_center, _padding + 48, "> " + inputter_string);
	}

//Letters
var _letters_per_row = inputter_row_length;
var _w = 26;
var _h = 36;
var _x = _center - ((_letters_per_row / 2) * _w);
var _y = _padding + 96;
var _c = c_black;
for(var i = 0; i < inputter_letter_count; i++)
	{
	if (inputter_current == i)
		{
		draw_set_color(c_black);
		_c = c_ltgray;
		}
	else
		{
		draw_set_color(c_white);
		_c = c_black;
		}
		
	draw_rectangle_color(_x, _y, _x + _w - 1, _y + _h - 1, _c, _c, _c, _c, false);
	draw_text(_x + (_w / 2), _y + (_h / 2), inputter_letters[@ i]);
	
	_x += _w;
	if ((i + 1) % _letters_per_row == 0)
		{
		_x -= (_w * _letters_per_row);
		_y += _h;
		}
	}
/* Copyright 2023 Springroll Games / Yosi */