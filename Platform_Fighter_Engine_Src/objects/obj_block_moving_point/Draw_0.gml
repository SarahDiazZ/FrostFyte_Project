///@description
if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	draw_self();
	
	if (next_point != noone)
		{
		draw_line_color(x, y, next_point.x, next_point.y, c_white, c_black);
		}
	
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */