///@description
if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	//Fade value
	var _f = background_get_clear_amount();
	
	palette_shader_set(palette_base, palette_swap, 0.0, 1.0, _f, false);
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, custom_entity_struct.lifetime * 13, c_white, 1);
	shader_reset();
	
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */