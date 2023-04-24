///@category Characters
/*
This script defines the data used for each character, including the character's init script, palette, portrait, texture page, etc.
*/
function character_data_get_all() {
	static _data =
		[
		character_define
			(
			"Alex",
			character_init5,
			spr_render5,
			spr_render5,
			spr_palette5,
			spr_portrait5,
			spr_stock5,
			song_victory0,
			["texture_character0"],
			cpu_script0,
			),
		character_define
			(
			"Random",
			-1,
			spr_render0,
			spr_css_random,
			spr_palette_random,
			spr_portrait0,
			spr_stock0,
			song_victory0,
			undefined,
			),
		];
	return _data;
}
/* Copyright 2023 Springroll Games / Yosi */