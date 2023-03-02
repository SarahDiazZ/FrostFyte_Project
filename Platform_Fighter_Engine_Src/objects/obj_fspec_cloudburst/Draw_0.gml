///@description
if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);

	//Fade value
	var _f = background_get_clear_amount();
	
	//Set up the shader and draw
	palette_shader_set(owner.palette_base, owner.palette_swap, 0.0, 1.0, _f, false);
	var _final_scale = custom_entity_struct.scale + (sin(obj_game.current_frame / 20) * 0.2);
	draw_sprite_ext(spr_fspec_cloudburst_cloud, 0, x, y, _final_scale, _final_scale, 0, c_white, 1);
	draw_sprite_ext(spr_fspec_cloudburst_dust, custom_entity_struct.frame, x, y, custom_entity_struct.scale, custom_entity_struct.scale, 0, c_white, 1);
	shader_reset();
	
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */