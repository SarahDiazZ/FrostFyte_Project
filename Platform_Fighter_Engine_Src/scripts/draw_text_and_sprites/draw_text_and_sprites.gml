///@param {int}	x					The left position to start drawing at
///@param {int} y					The vertical position to start drawing at
///@param {array} values			Any number of strings and arrays in the format [sprite, subimage]
///@param {int} [padding]			The amount of space between each string or sprite
///@param {bool} [right_align]		Whether to anchor the text from the right instead of the left
/*
Draws any number of strings and sprites in a line.
Sprites should be given as arrays, in the format [sprite, subimage].
The sprites should be centered.
By default the text and sprites will be aligned from the left, but you can pass an optional argument to make them aligned from the right.
*/
function draw_text_and_sprites() {
	var _x = argument[0];
	var _y = argument[1];
	var _array = argument[2];
	var _pad = argument_count > 3 ? argument[3] : 0;
	var _right = argument_count > 4 ? argument[4] : false;
	var _align = _right ? -1 : 1;
	
	draw_set_halign(_right ? fa_right : fa_left);
	draw_set_valign(fa_middle);
	
	for(var i = 0; i < array_length(_array); i++)
		{
		var _val = _array[@ i];
		if (is_string(_val))
			{
			draw_text(_x, _y, _val);
			_x += (string_width(_val) * _align);
			}
		else if (is_array(_val))
			{
			if (sprite_exists(_val[@ 0]))
				{
				var _w = sprite_get_width(_val[@ 0]);
				draw_sprite(_val[@ 0], _val[@ 1], _x + ((_w div 2) * _align), _y);
				_x += (_w * _align);
				}
			}
		_x += (_pad * _align);
		}
}
/* Copyright 2023 Springroll Games / Yosi */