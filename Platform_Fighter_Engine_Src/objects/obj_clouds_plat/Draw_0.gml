if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	var _color = merge_color(c_black, c_white, background_get_clear_amount());
	draw_sprite_ext(back_clouds_plat, (y > 752 ? 1 : 0), x, y, 2, 2, 0, _color, 1);
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */