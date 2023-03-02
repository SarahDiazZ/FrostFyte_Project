///@category Palettes
///@param {struct} palette_data			The struct of palette data to slice
///@param {int} column					The column in the palette to get colors from
/*
Takes a single column from a palette data struct and returns a new struct with only that column.
*/
function palette_slice() {
	var _pal = argument[0];
	var _pal_array = _pal.array;
	var _pal_alphas = _pal.alphas;
	var _col = argument_count > 1 ? argument[1] : 0;
	var _colors_per_column = _pal.colors_per_column;

	var _new_array = array_create(_colors_per_column, c_black);
	var _new_alphas = array_create(_colors_per_column, 1.0);
	for(var i = 0; i < _colors_per_column; i++)
		{
		_new_array[@ i] = _pal_array[@ i + (_col * _colors_per_column)];
		_new_alphas[@ i] = _pal_alphas[@ i + (_col * _colors_per_column)];
		}

	return 
		{ 
		array : _new_array, 
		columns : 1, 
		colors_per_column : _colors_per_column,
		alphas : _new_alphas,
		};
}
/* Copyright 2023 Springroll Games / Yosi */