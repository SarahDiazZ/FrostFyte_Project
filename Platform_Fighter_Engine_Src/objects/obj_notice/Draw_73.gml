///@description
var _s = custom_vfx_struct;
if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	//fade_shader_set();
	draw_set_font(_s.font);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_alpha(image_alpha);
	draw_set_color(c_black);
	draw_text(x + 1, y, _s.text);
	draw_text(x - 1, y, _s.text);
	draw_text(x, y + 1, _s.text);
	draw_text(x, y - 1, _s.text);
	draw_set_color(_s.color);
	draw_text(x, y, _s.text);
	draw_set_alpha(1);
	//shader_reset();

	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */