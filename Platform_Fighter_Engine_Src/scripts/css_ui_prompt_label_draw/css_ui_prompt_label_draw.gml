function css_ui_prompt_label_draw() {
	draw_set_color(merge_color(c_white, c_red, prompt_flash));
	draw_text_and_sprites(x, y, text, 0);
	draw_set_color(c_white);
}
/* Copyright 2023 Springroll Games / Yosi */