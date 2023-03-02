///@param {real} x							The x position
///@param {real} y							The y position
///@param {int} num							The damage number to draw
///@param {asset} sprite					The sprite to draw the damage number with
///@param {real} [pad]						The width between each number
///@param {real} [scale]					The scale of the sprite
///@param {color} [color]					The color blend of the sprite
///@param {real} [alpha]					The alpha of the sprite
///@param {asset} [percent_sprite]			The sprite to use for the percentage at the end
///@param {bool} [right_align]				If the text should be right aligned instead of left aligned
/*
Draws damage text using a given sprite.
This is mainly used for the HUD.
*/
function draw_damage_text() {
	var _x = round(argument[0]);
	var _y = round(argument[1]);
	var _num = argument[2];
	var _spr = argument[3];
	var _pad = argument_count > 4 ? argument[4] : sprite_get_width(_spr);
	var _scale = argument_count > 5 ? argument[5] : 1;
	var _col = argument_count > 6 ? argument[6] : c_white;
	var _alpha = argument_count > 7 ? argument[7] : 1;
	var _percent_sprite = argument_count > 8 ? argument[8] : undefined;
	var _right_align = argument_count > 9 ? argument[9] : false;
	
	//Integer damage
	if (damage_decimal_places == 0)
		{
		assert(frac(_num) == 0 && _num >= 0, "[draw_damage_text] Damage must be a positive integer when damage_decimal_places is 0 (", _num, ")");
	
		//Loop through the string and draw corresponding subimages
		if (_right_align) then _pad *= -1;
		var _str = string(_num);
		var _len = string_length(_str);
		var i = (_right_align ? _len - 1 : 0);
		repeat(_len)
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
				_alpha
				);
			_x += _pad;
			i += (_right_align ? -1 : 1);
			}
		}
	//Real number damage
	else
		{
		//Loop through the string and draw corresponding subimages
		if (_right_align) then _pad *= -1;
		var _str = string_format(_num, 0, damage_decimal_places);
		var _len = string_length(_str);
		var i = (_right_align ? _len - 1 : 0);
		var _is_decimal = (_right_align);
		repeat(_len)
			{
			var _char = string_char_at(_str, i + 1);
			if (_char == ".")
				{
				var _offset = _is_decimal ? (_pad / 4) : (-_pad / 4);
				draw_sprite_ext
					(
					_spr,
					10,
					floor(_x + _offset + 0.5),
					floor(_y + 0.5),
					_scale,
					_scale,
					0,
					_col,
					_alpha
					);
				_x += _is_decimal ? (_pad) : (_pad / 2);
				_is_decimal ^= true;
				}
			else
				{
				var _digit = real(_char);
				if (_is_decimal)
					{
					draw_sprite_ext
						(
						_spr,
						_digit,
						floor(_x + 0.5),
						floor(_y + ((sprite_get_height(_spr) * _scale) div 4) + 0.5),
						_scale / 2,
						_scale / 2,
						0,
						_col,
						_alpha
						);
					_x += (_pad / 2);
					}
				else
					{
					draw_sprite_ext
						(
						_spr,
						_digit,
						floor(_x + 0.5),
						floor(_y + 0.5),
						_scale,
						_scale,
						0,
						_col,
						_alpha
						);
					_x += _pad;
					}
				}
			
			i += (_right_align ? -1 : 1);
			}
		}

	//Percentage
	if (!is_undefined(_percent_sprite))
		{
		draw_sprite_ext
			(
			_percent_sprite,
			0,
			floor((_right_align ? argument[0] - _pad : _x) + 0.5),
			floor(_y + 0.5),
			_scale,
			_scale,
			0,
			_col,
			_alpha
			);
		}
}
/* Copyright 2023 Springroll Games / Yosi */