///@category Player Engine Scripts
///@param {array} [new_colors]			Any number of arrays in the specified format
/*
Changes multiple colors in a player's palette, and updates all palette-related variables to reflect the changes.
The arguments must all be arrays in the following format:
	- [index, color, alpha]

The alpha value should be from 0 to 255.
Call <player_palette_reset> to undo any changes made to the player's palette.
*/
function player_palette_change_colors() {
	assert(object_is(object_index, obj_player), "[player_palette_change_colors] This script can only be used by obj_player, not ", object_get_name(object_index));
	
	for(var i = 0; i < argument_count; i++)
		{
		var _array = argument[i];
		
		//Change the palette data struct
		palette_data.array[@ _array[@ 0]] = _array[@ 1];
	
		//Change the alpha
		palette_data.alphas[@ _array[@ 0]] = _array[@ 2];
		}
		
	//Update other variables
	palette_swap = palette_column_array(palette_data);
}
/* Copyright 2023 Springroll Games / Yosi */