///@description Clear the surfaces
if (!surface_exists(game_surface))
	{
	game_surface = surface_create(room_width, room_height);
	}

//Stage background color
if (game_surface_enable) surface_set_target(game_surface);
draw_clear(setting().stage_background_color);
if (game_surface_enable) surface_reset_target();

if (!surface_exists(offscreen_view_surface))
	{
	offscreen_view_surface = surface_create(room_width, room_height);
	}
	
if (surface_exists(cam_surface))
	{
	surface_set_target(cam_surface);
	draw_clear_alpha(c_white, 1);
	surface_reset_target();
	}
	
surface_set_target(offscreen_view_surface);
draw_clear_alpha(c_white, 0);
surface_reset_target();
/* Copyright 2023 Springroll Games / Yosi */