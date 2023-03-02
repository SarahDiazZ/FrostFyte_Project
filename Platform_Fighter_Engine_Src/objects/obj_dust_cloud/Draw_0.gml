///@description
if (setting().performance_mode) then exit;

if (surface_exists(obj_game.game_surface))
	{
	var _s = custom_vfx_struct;

	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	var _alpha = fade ? lerp(0, image_alpha, lifetime / total_life) : image_alpha;
	
	if (!setting().disable_shaders)
		{
		shader_set(shd_dust_cloud);
		shader_set_uniform_f(_s.uni_c, _s.color[0], _s.color[1], _s.color[2]);
		shader_set_uniform_f(_s.uni_f, (1 - obj_stage_manager.background_clear_amount));
		}
	draw_sprite_ext(vfx_sprite, vfx_frame, floor(x), floor(y), vfx_xscale, vfx_yscale, vfx_angle, c_white, _alpha);
	shader_reset();
	
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */