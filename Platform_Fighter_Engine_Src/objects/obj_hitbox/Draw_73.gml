///@description
if ((setting().show_hitboxes || overlay_sprite != -1) && surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	if (setting().show_hitboxes)
		{
		draw_self();
		}
	
	if (overlay_sprite != -1)
		{
		draw_sprite_ext(overlay_sprite, overlay_frame, x, y, overlay_facing * overlay_scale, overlay_scale, overlay_angle, overlay_color, overlay_alpha);
		}
		
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */