///@description
if (setting().performance_mode) then exit;

if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	fade_shader_set();
	draw_speed_lines(x, y, vfx_angle, c_white, (lifetime / 10), obj_game.current_frame);
	shader_reset();

	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */