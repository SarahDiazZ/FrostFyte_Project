///@category Characters
///@param {string} name						The name of the character
///@param {asset} script					The character init script
///@param {asset} render					The sprite of the character used on the Win Screen
///@param {asset} CSS						The sprite of the character used on the Character Select Screen
///@param {asset} palette					The palette sprite for the character
///@param {asset} portrait					The sprite of the character used on the in-game HUD
///@param {asset} stock_sprite				The sprite of the character used as the in-game stock icon
///@param {asset} music						The victory music of the character
///@param {asset/array} texture_groups		The texture group all of the character's sprites belong to. This can be a single group or an array of groups
///@param {asset} [cpu_script]				The script CPUs playing the character will use
/*
This function should only be used in <character_data>!
Creates an array that stores all of the metadata for a single character.
Data that is used in-game for a character is mostly stored in the character init script, which must be set here.
Please note: If you do not include all of the texture groups a character uses in the "texture_groups" argument, there may be lag in-game if a player switches to a sprite that is not loaded yet!
*/
function character_define() {
	assert(sprite_exists(argument[4]), "[character_define] Palette sprite does not exist! (", argument[4], ")");
	assert(!is_undefined(argument[1]), "[character_define] Character init script's value is undefined. Did you put parentheses after the script name?");
	assert(script_exists(argument[1]) || argument[1] == -1, "[character_define] Character init script does not exist! (", argument[1], ")");
		
	var _new = [];
	_new[@ CHARACTER_DATA.name				] = argument[0];
	_new[@ CHARACTER_DATA.script			] = argument[1];
	_new[@ CHARACTER_DATA.render			] = argument[2];
	_new[@ CHARACTER_DATA.CSS				] = argument[3];
	_new[@ CHARACTER_DATA.palette_sprite	] = argument[4];
	_new[@ CHARACTER_DATA.portrait			] = argument[5];
	_new[@ CHARACTER_DATA.stock_sprite		] = argument[6];
	_new[@ CHARACTER_DATA.music				] = argument[7];
	_new[@ CHARACTER_DATA.texture_groups	] = argument[8];
	_new[@ CHARACTER_DATA.cpu_script		] = argument_count > 9 ? argument[9] : undefined;
	
	//Palette caching
	var _data = palette_colors_get_from_sprite(argument[4]);
	_new[@ CHARACTER_DATA.palette_data] = _data;
	var _column_arrays = [];
	for(var i = 0; i < _data.columns; i++)
		{
		array_push(_column_arrays, palette_column_array(_data, i));
		}
	_new[@ CHARACTER_DATA.palette_column_arrays] = _column_arrays;
	
	return _new;
}
/* Copyright 2023 Springroll Games / Yosi */