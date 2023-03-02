///@category Character Select Screen
/*
Determines an area on the character select screen that counts for a specific character when a token is put down.
You can change the character per instance in the room editor through the Variables tab.
*/
///@description
sprite_index = spr_rectangle;
image_blend = $444444;

//Find the character with the name
character = character_find(character_name);
if (character == -1)
	{
	crash("[obj_css_zone: Create] No character exists with the given name: ", character_name);
	}

//Get the character palette and cache it
palette_base = character_data_get(character, CHARACTER_DATA.palette_column_arrays)[@ 0];
palette_swap = character_data_get(character, CHARACTER_DATA.palette_column_arrays)[@ 1];
palette_data = character_data_get(character, CHARACTER_DATA.palette_data);
sprite = character_data_get(character, CHARACTER_DATA.CSS);
name = character_data_get(character, CHARACTER_DATA.name);
selected_animation_time = 0;

//Surface
surf = noone;
surf_drawn = false;
/* Copyright 2023 Springroll Games / Yosi */