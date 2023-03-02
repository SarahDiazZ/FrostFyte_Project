///@description
if (setting().performance_mode) then exit;

if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	fade_shader_set();
	draw_sprite_ext(vfx_sprite, vfx_frame, floor(x), floor(y), vfx_xscale, vfx_yscale, vfx_angle, image_blend, image_alpha);
	shader_reset();

	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */