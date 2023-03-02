///@category Palettes
///@param {struct} palette_data			The struct of palette data to get an array from
///@param {int} [column]				The column
/*
Returns a 1D array with the RGBA values of the colors in the column of the given palette.
For example, if the palette has a column with pure red, pure green, and pure blue, the following array would be returned:
	- [1.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0]
The array is inteded for the <palette_shader_set>, <palette_shader_rgb_set>, <palette_shader_simple_set>, and <palette_shader_simple_rgb_set> functions.
*/
function palette_column_array() {
	var _pal = argument[0];
	var _col = argument_count > 1 ? argument[1] : 0;
	var _pal_array = _pal.array;
	var _pal_alphas = _pal.alphas;
	var _colors_per_column = _pal.colors_per_column;
	var _new = array_create(_colors_per_column * 4, 0.0);
	var m = 0;
	for(var i = 0; i < _colors_per_column; i++)
		{
		var _index = (_col * _colors_per_column) + i;
		var _color = _pal_array[@ _index];
		_new[@ m] = color_get_red(_color) / 255;
		m++;
		_new[@ m] = color_get_green(_color) / 255;
		m++;
		_new[@ m] = color_get_blue(_color) / 255;
		m++;
		_new[@ m] = _pal_alphas[@ _index] / 255;
		m++;
		}
	return _new;
}
/* Copyright 2023 Springroll Games / Yosi */