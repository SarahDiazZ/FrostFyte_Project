///@description
if (surface_exists(obj_game.game_surface))
	{
	//Color
	image_blend = make_color_hsv(modulo(start_x + start_y, 255), 200, 255);
	image_index = modulo(start_x + start_y, image_number - 1) + 1;
	
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	draw_sprite_ext(sprite_index, image_index, mean(bbox_left, bbox_right) - 64, mean(bbox_top, bbox_bottom) - 64, 2, 2, 0, c_white, 1);
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */