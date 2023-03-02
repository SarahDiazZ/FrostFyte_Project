///@description
var _x = x;
var _y = 0;
var _pad = 48;
var _selected = array_create(array_length(menu_choices), false);

//Background
draw_sprite_ext(spr_rectangle, 0, _x, _y, 5, 17, 0, $333333, 1);

//Currently selected choices
for(var i = 0; i < array_length(menu_choice_current); i++)
	{
	var _current = menu_choice_current[@ i];
	if (_current != -1)
		{
		_selected[@ _current] = true;
		var _c = player_color_get(i);
		draw_sprite_ext(spr_rectangle, 0, _x, _y + (_pad * _current), 5, 1.5, 0, _c, 1);
		}
	}

//Menu
draw_set_font(fnt_consolas);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
for(var i = 0; i < array_length(menu_choices); i++)
	{
	var _choice = menu_choices[@ i];
	
	//Color
	if (_selected[@ i])
		{
		_c = $333333;
		}
	else
		{
		_c = $858585;
		}
		
	//Ooptions that are disabled
	if (web_export || true)
		{
		if (!_choice.web)
			{
			_c = $222222;
			}
		}
	
	//Image
	draw_sprite_ext(_choice.sprite, 0, _x + 24, _y + (_pad / 2), 1, 1, 0, _c, 1);
	
	//Text
	draw_set_color(_c);
	draw_text(_x + 95, _y + (_pad / 2), _choice.text);
	
	//Move down
	_y += _pad;
	}
/* Copyright 2023 Springroll Games / Yosi */