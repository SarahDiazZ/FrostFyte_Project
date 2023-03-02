///@description

if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	fade_shader_set();
	
	//Moving plat
	with(obj_platform_moving)
		{
		draw_sprite_ext(other.sprite_index, other.image_index, x, y, 2, 2, 0, c_white, 1);
		}
	
	//Spinning wheels
	draw_sprite_ext(back_library_wheel, 0, 864, 832, 2, 2, modulo(-obj_game.current_frame, 360), c_white, 1);
	draw_sprite_ext(back_library_wheel, 0, 1150, 832, 2, 2, modulo(obj_game.current_frame, 360), c_white, 1);
	
	shader_reset();
	
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */