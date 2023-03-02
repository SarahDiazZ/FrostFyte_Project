///@description
var _x = 192;
var _w = 416;
var _text_offset_x = 8;
var _y = 40;
var _pad = 48;
var _half = _pad / 2;
var _c = $E24AB5;
var _del = $4E4EE5;
var _num = min(replays_per_page, replays_count);
draw_set_font(fnt_consolas);
draw_set_valign(fa_middle);

for(var i = 0; i < _num; i++)
	{
	var _replay = (i + replay_scroll);
	if (replay_current == _replay)
		{
		draw_rectangle_color(_x, _y, _x + _w, _y + _pad - 1, _c, _c, _c, _c, false);
		if (replay_delete_time > 0)
			{
			draw_rectangle_color(_x, _y, _x + _w * min(1, replay_delete_time / 55), _y + _pad - 1, _del, _del, _del, _del, false);
			}
		draw_set_color(c_dkgray);
		}
	else
		{
		draw_set_color(c_white);
		}
		
	//Replay name
	draw_set_halign(fa_left);
	draw_text(_x + _text_offset_x, _y + _half, replay_array[@ _replay]);
	
	//Replay number
	draw_set_halign(fa_right);
	draw_text(_x + _w + (-_text_offset_x), _y + _half, string(_replay + 1));
	_y += _pad;
	}
/* Copyright 2023 Springroll Games / Yosi */