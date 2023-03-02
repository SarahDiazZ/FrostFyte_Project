function main_menu_sidebar_ui_prompt_label_draw() {
	draw_set_color(c_white);
	draw_text_and_sprites
		(
		x, 
		y + (sprite_height div 2), 
			[
			"Press ", 
			[spr_icon_input_button_universal, gamepad_button_number(menu_back_button)],
			" or ",
			key_to_string(menu_back_key, true),
			" to go back",
			],
		0,
		);
}
/* Copyright 2023 Springroll Games / Yosi */