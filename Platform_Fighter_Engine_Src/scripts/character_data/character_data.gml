///@category Characters
/*
This script defines the data used for each character, including the character's init script, palette, portrait, texture page, etc.
*/
function character_data_get_all() {
	static _data =
		[
		character_define
			(
			"Blocky",
			character_init0,
			spr_render0,
			spr_css0,
			spr_palette0,
			spr_portrait0,
			spr_stock0,
			song_victory0,
			["texture_character0"],
			cpu_script0,
			),
		character_define
			(
			"Polygon",
			character_init1,
			spr_render1,
			spr_css1,
			spr_palette1,
			spr_portrait1,
			spr_stock1,
			song_victory0,
			["texture_character1", "texture_character0"],
			cpu_script1,
			),
		character_define
			(
			"Vertex",
			character_init2,
			spr_render2,
			spr_css2,
			spr_palette2,
			spr_portrait2,
			spr_stock2,
			song_victory0,
			["texture_character2", "texture_character0"],
			cpu_script2,
			),
		character_define
			(
			"Scalar",
			character_init3,
			spr_render3,
			spr_css3,
			spr_palette3,
			spr_portrait3,
			spr_stock3,
			song_victory0,
			["texture_character3"],
			),
		character_define
			(
			"Radian",
			character_init4,
			spr_render4,
			spr_css4,
			spr_palette4,
			spr_portrait4,
			spr_stock4,
			song_victory0,
			["texture_character4"],
			cpu_script4,
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