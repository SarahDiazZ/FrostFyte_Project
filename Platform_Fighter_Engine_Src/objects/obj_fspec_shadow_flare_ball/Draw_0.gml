if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	//Fade value
	var _f = background_get_clear_amount();
	
	//Set up the shader and draw
	palette_shader_set(palette_base, palette_swap, 0.0, 1.0, _f, false);
	draw_self();
	shader_reset();
	
	if (game_surface_enable) surface_reset_target();
	}
	
/* Copyright 2023 Springroll Games / Yosi */