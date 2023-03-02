///@param {real} x							The x position
///@param {real} y							The y position
///@param {int} num							The damage number to draw
///@param {asset} sprite					The sprite to draw the damage number with
///@param {real} [pad]						The width between each number
///@param {real} [scale]					The scale of the sprite
///@param {color} [color]					The color blend of the sprite
///@param {int} [stocks]					The number of stocks to draw
///@param {asset} [stock_sprite]			The sprite to draw the stocksd with
/*
Draws damage text using a given sprite, along with the number of stocks a player has.
This is mainly used for the overhead display.
*/
function draw_damage_text_overhead() {
	var _x = argument[0];
	var _y = argument[1];
	var _num = argument[2];
	var _spr = argument[3];
	var _pad = argument_count > 4 ? argument[4] : sprite_get_width(_spr);
	var _scale = argument_count > 5 ? argument[5] : 1;
	var _col = argument_count > 6 ? argument[6] : c_white;
	var _stocks = argument_count > 7 ? argument[7] : 0;
	var _stock_sprite = argument_count > 8 ? argument[8] : undefined;
	
	//Integer damage
	if (damage_decimal_places == 0)
		{
		assert(frac(_num) == 0 && _num >= 0, "[draw_damage_text_overhead] Damage must be a positive integer when damage_decimal_places is 0 (", _num, ")");
	
		//Loop through the string and draw corresponding subimages
		var _str = string(_num);
		//If there are > 5 stocks, draw 1 stock sprite and the number of stocks after it
		var _stocks_drawn = _stocks <= 5 ? _stocks : 1 + string_length(string(_stocks)); 
		var _len = string_length(_str) + _stocks_drawn;
		_x -= round(((_len / 2) * _pad) - (_pad / 2));
		for(var i = 0; i < string_length(_str); i++)
			{
			var _char = string_char_at(_str, i + 1);
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
				1,
				);
			_x += _pad;
			}
		}
	//Real number damage
	else
		{
		//Loop through the string and draw corresponding subimages
		var _str = string_format(_num, 0, damage_decimal_places);
		//If there are > 5 stocks, draw 1 stock sprite and the number of stocks after it
		var _stocks_drawn = _stocks <= 5 ? _stocks : 1 + string_length(string(_stocks)); 
		var _len = string_length(_str) + _stocks_drawn - 0.5;
		var _pad_smaller = 0;
		_x -= round(((_len / 2) * _pad) - (_pad / 2));
		for(var i = 0; i < string_length(_str); i++)
			{
			var _char = string_char_at(_str, i + 1);
			
			if (_char == ".")
				{
				draw_sprite_ext
					(
					_spr,
					10,
					_x - (_pad / 4),
					_y,
					_scale,
					_scale,
					0,
					_col,
					1,
					);
				_x += (_pad / 2);
				}
			else
				{
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
					1,
					);
				_x += _pad;
				}
			}
		}

	//Stock
	if (!is_undefined(_stock_sprite))
		{
		_col = c_ltgray;
		//Normal stock display
		if (_stocks <= 5)
			{
			for(var i = 0; i < _stocks; i++)
				{
				draw_sprite_ext
					(
					_stock_sprite,
					0,
					_x,
					_y,
					_scale,
					_scale,
					0,
					_col,
					1,
					);
				_x += _pad;
				}
			}
		//Condensed stock display
		else
			{
			var _stock_string = string(_stocks);
			draw_sprite_ext
				(
				_stock_sprite,
				0,
				_x,
				_y,
				_scale,
				_scale,
				0,
				_col,
				1,
				);
			_x += _pad;
			for(var i = 0; i < string_length(_stock_string); i++)
				{
				var _char = string_char_at(_stock_string, i + 1);
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
					1,
					);
				_x += _pad;
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */