///@category Player Engine Scripts
///@param {int} index			The index (row)
///@param {color} color			The new color
///@param {real} [alpha]		The new alpha, from 0 to 255
/*
Changes a specific color in a player's palette, and updates all palette-related variables to reflect the change.
You can also change the alpha of the specific color, though this will only affect the palette shader and not <palette_color_get>.
Call <player_palette_reset> to undo any changes made to the player's palette.
*/
function player_palette_change_color() {
	assert(object_is(object_index, obj_player), "[player_palette_change_color] This script can only be used by obj_player, not ", object_get_name(object_index));
	var _in = argument[0];
	var _new_color = argument[1];
	
	//Change the palette data struct
	palette_data.array[@ _in] = _new_color;
	
	//Change the alpha
	if (argument_count > 2)
		{
		palette_data.alphas[@ _in] = argument[2];
		}
		
	//Update other variables
	palette_swap = palette_column_array(palette_data);
}
/* Copyright 2023 Springroll Games / Yosi */