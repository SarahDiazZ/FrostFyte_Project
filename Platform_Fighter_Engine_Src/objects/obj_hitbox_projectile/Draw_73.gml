///@description
if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
		
	if (setting().show_hitboxes)
		{
		draw_self();
		draw_set_color(c_black);
		draw_arrow
			(
			x,
			y,
			x + lengthdir_x(base_knockback * hitbox_draw_angle_multiplier, drawing_angle),
			y + lengthdir_y(base_knockback * hitbox_draw_angle_multiplier, drawing_angle),
			20
			);
		}
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */