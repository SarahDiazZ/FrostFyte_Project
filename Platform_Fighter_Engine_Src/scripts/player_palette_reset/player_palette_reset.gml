///@category Player Engine Scripts
/*
Resets all of the player's palette variables to their value at the start of the match.
*/
function player_palette_reset() {
	assert(object_is(object_index, obj_player), "[player_palette_reset] This script can only be used by obj_player, not ", object_get_name(object_index));
	palette_data = palette_slice(character_data_get(character, CHARACTER_DATA.palette_data), player_color);
	palette_base = character_data_get(character, CHARACTER_DATA.palette_column_arrays)[@ 0];
	palette_swap = character_data_get(character, CHARACTER_DATA.palette_column_arrays)[@ player_color];
}
/* Copyright 2023 Springroll Games / Yosi */