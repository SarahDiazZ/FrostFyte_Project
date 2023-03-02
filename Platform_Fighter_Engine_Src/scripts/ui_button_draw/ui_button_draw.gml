function ui_button_draw() {
	draw_sprite_ext(spr_pixel, image_index, x, y, sprite_width, sprite_height, image_angle, image_blend, image_alpha);

	if (text != "")
		{
		draw_set_halign(fa_center);
		if (font != -1) then draw_set_font(font);
		else draw_set_font(fnt_consolas);
		draw_text(x + (sprite_width / 2), y + (sprite_height / 2), text);
		draw_set_font(fnt_consolas);
		}
}
/* Copyright 2023 Springroll Games / Yosi */