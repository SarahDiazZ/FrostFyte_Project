///@description Render credits

//Links
draw_set_color(c_black);
draw_set_alpha(0.5);
var _pad = 2;
for(var i = 0; i < array_length(credits_links); i++)
	{
	var _link = credits_links[@ i];
	if (point_in_rectangle(mouse_x, mouse_y, x + _link.left, y + _link.top, x + _link.right, y + _link.bottom) || credits_current_link == i)
		{
		draw_rectangle(x + _link.left - _pad, y + _link.top - _pad, x + _link.right + _pad, y + _link.bottom + _pad, false);
		}
	}
	
//Credits
draw_set_font(fnt_credits);
draw_set_color(c_white);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (!surface_exists(credits_surf))
	{
	credits_surf = surface_create(room_width, credits_height);
	credits_rendered = false;
	}

if (!credits_rendered)
	{
	credits_rendered = true;
	credits_links = [];
	surface_set_target(credits_surf);
	var _length = array_length(credits_tokens);
	var _x = 0;
	var _y = 4;
	var _invisible = false;
	var _link = false;
	var _started = false;
	var _link_start_x = 0;
	var _link_start_y = 0;
	var _link_url = "";
	for(var i = 0; i < _length; i++)
		{
		var _token = credits_tokens[@ i];
		if (_token.type == 0)
			{
			if (!_invisible)
				{
				_started = true;
				draw_text(_x, _y, _token.text);
				_x += string_width(_token.text);
				if (_link)
					{
					_link_url += _token.text;
					}
				}
			}
		else if (_token.type == 1)
			{
			switch(_token.text)
				{
				case "\n":
					if (!_invisible && _started)
						{
						_x = 0;
						_y += 24;
						}
					break;
				case "\t":
					if (!_invisible && _started)
						{
						_x += 48;
						}
					break;
				case "[":
					draw_set_font(fnt_credits_bold);
					_y -= 4;
					break;
				case "]":
					draw_set_font(fnt_credits);
					_y += 4;
					break;
				case "(":
					_invisible = true;
					break;
				case ")":
					_invisible = false;
					break;
				case "<":
					_link = true;
					_link_start_x = _x;
					_link_start_y = _y;
					_link_url = "";
					draw_set_color(c_aqua);
					break;
				case ">":
					_link = false;
					array_push
						(
						credits_links, 
							{
							left : _link_start_x,
							top : _link_start_y,
							right : _x,
							bottom : _y + string_height(_link_url),
							url : _link_url,
							}
						);
					draw_set_color(c_white);
					break;
				}
			}
		}
	surface_reset_target();
	}
	
if (credits_rendered)
	{
	draw_surface(credits_surf, x, y);
	}
	

/* Copyright 2023 Springroll Games / Yosi */