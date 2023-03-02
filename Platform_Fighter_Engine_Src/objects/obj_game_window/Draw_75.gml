///@description Draw the buttons
if (window_fade != 0 && room != rm_init && !disable)
	{
	var _p = 48;
	
	draw_set_alpha(window_fade / 4);
	draw_set_color(c_black);
	draw_rectangle(0, 0, screen_width, screen_height, false);
	draw_set_alpha(window_fade);
	draw_set_color($32A9F8);
	draw_rectangle(0, 0, screen_width, bar_height, false);
	
	//Exit button
	draw_set_alpha(button_exit_fade);
	draw_set_color(c_red);
	draw_rectangle(screen_width - (_p * 1), 0, screen_width, bar_height, false);
	draw_sprite_ext(spr_window_buttons, 0, screen_width - (_p * 1), 0, 1, 1, 0, c_white, window_fade);
	
	//Full window button
	draw_set_alpha(button_full_fade);
	draw_set_color(c_ltgray);
	draw_rectangle(screen_width - (_p * 2), 0, screen_width - (_p * 1), bar_height, false);
	var _image = (window_get_fullscreen() ? 2 : 1);
	//var _image = (window_get_width() == screen_width ? 1 : 2);
	draw_sprite_ext(spr_window_buttons, _image, screen_width - (_p * 2), 0, 1, 1, 0, c_white, window_fade);
	
	//Size button
	draw_set_alpha(button_size_fade);
	draw_set_color(c_ltgray);
	draw_rectangle(screen_width - (_p * 3), 0, screen_width - (_p * 2), bar_height, false);
	draw_set_alpha(window_fade);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_black);
	draw_set_font(fnt_window);
	var _scale = (window_get_width() div screen_width);
	draw_text(screen_width - (_p * 3) + (_p div 2), bar_height div 2, string(_scale) + "x");
	
	//Game Version
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(8, bar_height div 2, game_name + " " + version_string);
	
	draw_set_alpha(1);
	}
/* Copyright 2023 Springroll Games / Yosi */