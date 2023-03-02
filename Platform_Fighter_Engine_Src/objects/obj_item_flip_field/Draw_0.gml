///@description
if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	//Fade value
	var _f = background_get_clear_amount();
	
	//Draw the zone
	var _c = custom_entity_struct.flip
		? c_red
		: c_lime;
	
	draw_set_alpha(((sin(custom_entity_struct.lifetime / 10) * 0.2) + 0.3) * _f);
	draw_circle_color(x, y, 100, _c, _c, false);
	draw_set_alpha(1);
	
	item_draw_self();
	
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */