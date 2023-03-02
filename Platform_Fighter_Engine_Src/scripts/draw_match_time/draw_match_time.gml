///@param {real} x				The x position
///@param {real} y				The y position
///@param {int} num				The amount of time left, in seconds
///@param {asset} sprite		The sprite to draw the time with
///@param {real} [pad]			The width between each number
///@param {real} [scale]		The scale of the sprite
///@param {color} [color]		The color blend of the sprite
///@param {real} [alpha]		The alpha to draw with
/*
Draws the amount of time left using a given sprite.
This is mainly used for the time display in-game.
*/
function draw_match_time() {
	var _x = argument[0];
	var _y = argument[1];
	var _num = argument[2];
	var _spr = argument[3];
	var _pad = argument_count > 4 ? argument[4] : sprite_get_width(_spr);
	var _scale = argument_count > 5 ? argument[5] : 1;
	var _col = argument_count > 6 ? argument[6] : c_white;
	var _alpha = argument_count > 7 ? argument[7] : 1;
	
	assert(frac(_num) == 0 && _num >= 0, "[draw_match_time] Time must be a positive integer! (", _num, ")");
	
	var _center_x = _x;
	
	draw_sprite_ext(spr_colon_symbol, 0, _center_x, _y, _scale, _scale, 0, _col, _alpha);
	
	var _minutes = string(floor(_num / 60));
	var _seconds = string_replace(string_format(_num - (floor(_num / 60) * 60), 2, 0), " ", "0");
	
	var _len = string_length(_minutes);
	_x = _center_x - (_len * _pad);
	for(var i = 0; i < _len; i++)
		{
		var _char = string_char_at(_minutes, i + 1);
		var _digit = real(_char);
		draw_sprite_ext
			(
			_spr,
			_digit,
			_x,
			_y,
			_scale,
			_scale,
			0,
			_col,
			_alpha,
			);
		_x += _pad;
		}
		
	var _len = string_length(_seconds);
	_x = _center_x + _pad;
	for(var i = 0; i < _len; i++)
		{
		var _char = string_char_at(_seconds, i + 1);
		var _digit = real(_char);
		draw_sprite_ext
			(
			_spr,
			_digit,
			_x,
			_y,
			_scale,
			_scale,
			0,
			_col,
			_alpha,
			);
		_x += _pad;
		}
}
/* Copyright 2023 Springroll Games / Yosi */