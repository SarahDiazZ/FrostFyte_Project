///@category Palettes
///@param {asset} sprite			The palette sprite to get colors from
///@param {int} [column]			The column in the palette to get colors from
/*
Returns a palette data struct that contains the colors of the given palette sprite.
If you specify a column, it will return a struct with only a single column.
*/
function palette_colors_get_from_sprite() {
	var _spr = argument[0];
	var _one = argument_count > 1;
	var _col = _one ? argument[1] : 0;
	var _num_of_columns = sprite_get_width(_spr);
	var _colors_per_column = sprite_get_height(_spr);
	var _surf = surface_create(_num_of_columns, _colors_per_column);
	var _array = [];
	var _alphas = [];

	//Draw sprite to surface
	surface_set_target(_surf);
	gpu_set_blendenable(false);
	draw_clear_alpha(c_black, 1);
	draw_sprite(_spr, 0, 0, 0);
	gpu_set_blendenable(true);
	surface_reset_target();
	
	//Get a buffer from the surface
	var _b = getpixel_buffer();
	buffer_resize(_b, _num_of_columns * _colors_per_column * 4);
	buffer_get_surface(_b, _surf, 0);
	surface_free(_surf);

	var i = _col;
	repeat(_one ? 1 : _num_of_columns)
		{
		//Grab all of the colors in a column and put them in an array
		for(var m = 0; m < _colors_per_column; m++)
			{
			var _pos = (i + (m * _num_of_columns)) * 4;
			var _col = make_color_rgb
				(
				buffer_peek(_b, _pos, buffer_u8),
				buffer_peek(_b, _pos + 1, buffer_u8),
				buffer_peek(_b, _pos + 2, buffer_u8),
				);
			array_push(_array, _col);
			array_push(_alphas, buffer_peek(_b, _pos + 3, buffer_u8));
			}
		i++;
		}
		
	return 
		{ 
		array : _array, 
		columns : _num_of_columns, 
		colors_per_column : _colors_per_column,
		alphas : _alphas,
		};
}
/* Copyright 2023 Springroll Games / Yosi */