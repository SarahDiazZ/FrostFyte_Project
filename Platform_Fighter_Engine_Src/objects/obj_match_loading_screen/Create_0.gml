///@category Menus
/*
obj_match_loading_screen handles loading in all of the necessary textures for character and stages before the match begins.
This is important to prevent the game from stuttering mid-match if sprites need to be drawn from textures that aren't in memory.
*/
///@description
image_speed = 1;
image_xscale = 2;
image_yscale = 2;

//Flush all loaded textures
draw_texture_flush();
gc_collect();

textures_needed = [];
current_texture = 0;
load_time = 15;

//Game textures
array_push(textures_needed, "texture_gameplay");
array_push(textures_needed, "texture_vfx");

//Characters
array_push(textures_needed, "texture_moves");
var _num = array_length(engine().player_data);
for(var i = 0; i < _num; i++)
	{
	var _char = player_data_get(i, PLAYER_DATA.character);
	var _textures = character_data_get(_char, CHARACTER_DATA.texture_groups);
	if (!is_undefined(_textures) && is_array(_textures))
		{
		for(var m = 0; m < array_length(_textures); m++)
			{
			if (!array_contains(textures_needed, _textures[@ m]))
				{
				array_push(textures_needed, _textures[@ m]);
				}
			}
		}
	}

//Stage textures
switch(setting().match_stage)
	{
	case rm_warpgate:
		array_push(textures_needed, "texture_warpgate")
		break;
	case rm_speedhighway:
		array_push(textures_needed, "texture_speedhighway")
		break;
	}
	
//Items
if (setting().match_items_enable)
	{
	array_push(textures_needed, "texture_items");
	}
	
//Stop music
audio_stop_sound(song_menu);
/* Copyright 2023 Springroll Games / Yosi */