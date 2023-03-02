function ui_toast_draw() {
	if (text != "")
		{
		draw_set_alpha(image_alpha);
		draw_set_valign(fa_middle);
		if (font != -1) then draw_set_font(font);
		else draw_set_font(fnt_consolas);
		var _col = draw_get_color();
		var _width = string_width(text);
		switch(halign)
			{
			case 0: 
				draw_set_color(box_color);
				draw_rectangle(x - (_width / 2) - padding, y - height, x + (_width / 2) + padding, y + height, false);
				draw_set_color(image_blend);
				draw_set_halign(fa_center); 
				draw_text(x, y, text);
				break;
			case 1: 
				draw_set_color(box_color);
				draw_rectangle(x - (_width) - (padding * 2), y - height, x, y + height, false);
				draw_set_color(image_blend);
				draw_set_halign(fa_right); 
				draw_text(x - padding, y, text);
				break;
			case -1: 
				draw_set_color(box_color);
				draw_rectangle(x, y - height, x + (_width) + (padding * 2), y + height, false);
				draw_set_color(image_blend);
				draw_set_halign(fa_left); 
				draw_text(x + padding, y, text);
				break;
			default: crash("[ui_toast_draw] Invalid halign (", halign, ")"); break;
			}
		draw_set_halign(fa_center);
		draw_set_alpha(1);
		draw_set_color(_col);
		draw_set_font(fnt_consolas);
		}
}
/* Copyright 2023 Springroll Games / Yosi */