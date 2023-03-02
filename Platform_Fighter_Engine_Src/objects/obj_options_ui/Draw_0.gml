///@description
var _x = 264;
var _text_offset_x = 8;
var _y = 40;
var _pad = 24;
var _half = _pad / 2;
var _c = $bbaaaa;
var _num = min(options_per_page, options_count);
draw_set_font(fnt_consolas);
draw_set_valign(fa_middle);

for(var i = 0; i < _num; i++)
	{
	var _index = (i + option_scroll);
	
	//Back button
	if (_index == (options_count - 1))
		{
		if (option_current == _index)
			{
			var _red = c_red;
			draw_rectangle_color(_x, _y, screen_width - _x, _y + _pad - 1, _red, _red, _red, _red, false);
			draw_set_color(c_dkgray);
			}
		else
			{
			var _red = $5959E0;
			draw_rectangle_color(_x, _y, screen_width - _x, _y + _pad - 1, _red, _red, _red, _red, false);
			draw_set_color(c_white);
			}
		draw_set_halign(fa_center);
		draw_text((room_width div 2), _y + (_half), "Save & Close");
		}
	else
		{
		//Options
		var _option = options_array[@ _index];
		if (option_current == _index)
			{
			draw_rectangle_color(_x, _y, screen_width - _x, _y + _pad - 1, _c, _c, _c, _c, false);
			draw_set_color(c_dkgray);
		
			//Description - drawn at the bottom of the screen
			if (is_struct(_option))
				{
				draw_set_halign(fa_center);
				draw_text((room_width div 2), room_height - 6, _option.desc);
				}
			}
		else
			{
			draw_set_color(c_white);
			}
		
		if (is_string(_option))
			{
			//Section header
			draw_rectangle_color(_x, _y, screen_width - _x, _y + _pad - 1, c_dkgray, c_dkgray, c_dkgray, c_dkgray, false);
			draw_set_halign(fa_center);
			draw_text((room_width div 2), _y + (_half), options_array[@ _index]);
			}
		else if (is_struct(_option))
			{
			//Option name
			draw_set_halign(fa_left);
			draw_text(_x + _text_offset_x, _y + (_half), _option.name);
	
			//Option values
			//Special colors
			if (draw_get_color() == c_white && _option.display == "bool")
				{
				draw_set_color(_option.current ? c_lime : c_red);
				}
			
			draw_set_halign(fa_right);
		
			if (_option.display == "string")
				{
				draw_text(screen_width - _x - _text_offset_x, _y + (_half), _option.current);
				}
			else if (_option.display == "bool")
				{
				draw_text(screen_width - _x - _text_offset_x, _y + (_half), _option.current ? "On" : "Off");
				}
			else if (_option.display == "real")
				{
				draw_text(screen_width - _x - _text_offset_x, _y + (_half), _option.current);
				}
			else if (_option.display == "percent")
				{
				draw_text(screen_width - _x - _text_offset_x, _y + (_half), string(real(_option.current) * 100) + "%");
				}
			else if (_option.display == "profile")
				{
				draw_text(screen_width - _x - _text_offset_x, _y + (_half), (_option.current == -1 || !profile_exists(_option.current, true)) ? "---" : profile_get(_option.current, PROFILE.name));
				}
			else if (_option.display == "disable")
				{
				draw_set_color(c_dkgray);
				draw_text(screen_width - _x - _text_offset_x, _y + (_half), "DISABLED");
				}
			}
		_y += _pad;
		}
	}
/* Copyright 2023 Springroll Games / Yosi */