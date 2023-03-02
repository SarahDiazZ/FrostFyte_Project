///@description Draw
draw_self();

draw_set_font(fnt_window);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if (instance_exists(obj_game))
	{
	//No text while in-game right now
	}
else
	{
	draw_text(x, y, text_menu);
	}
/* Copyright 2023 Springroll Games / Yosi */