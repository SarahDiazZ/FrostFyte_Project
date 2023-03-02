if (setting().performance_mode) then exit;

//Draw the other surface to the game surface
if (!surface_exists(surf))
	{
	surf = surface_create(room_width, room_height);
	}

if (surface_exists(obj_game.game_surface))
	{
	surface_set_target(surf);

	draw_clear_alpha(c_white, 0);
	gpu_set_colorwriteenable(false, false, false, true);
	with(obj_solid)
		{
		draw_self();
		}
	with(obj_slope)
		{
		draw_self();
		}
	gpu_set_colorwriteenable(true, true, true, false);
	draw_surface_ext(obj_game.game_surface, 0, room_height + (-screen_height) + y + (-24), 1, -1, 0, $FFFF33, 1);
	draw_set_alpha(0.5);
	draw_set_color(c_white);
	draw_rectangle(0, 0, room_width, room_height, false);
	var _clear = background_get_clear_amount();
	if (_clear < 1)
		{
		draw_set_alpha(1 - _clear);
		draw_set_color(c_black);
		draw_rectangle(0, 0, room_width, room_height, false);
		}
	draw_set_alpha(1);
	gpu_set_colorwriteenable(true, true, true, true);
	surface_reset_target();

	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	draw_surface(surf, 0, 0);
	
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */