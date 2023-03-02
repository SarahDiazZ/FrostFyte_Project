function replays_ui_prompt_label_draw() {
	draw_set_font(fnt_consolas);
	draw_set_color(c_white);
	draw_text_and_sprites
		(
		x,
		y,
			[
			"Watch:",
			[spr_icon_input_button_universal, gamepad_button_number(menu_confirm_button)],
			" / ",
			key_to_string(menu_confirm_key, false),
			],
		);
	draw_text_and_sprites
		(
		x,
		y + 16,
			[
			"Delete:",
			[spr_icon_input_button_universal, gamepad_button_number(menu_remove_button)],
			" / ",
			key_to_string(menu_remove_key, false),
			"\n",
			],
		);
}
/* Copyright 2023 Springroll Games / Yosi */