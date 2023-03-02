function stage_haven_shader_draw() {
	var _layer = argument[0];
	var _draw_x = argument[1];
	var _draw_y = argument[2];
	var _cam_dist_x = argument[3];
	var _cam_dist_y = argument[4];

	if (!setting().disable_shaders && !setting().performance_mode)
		{
		shader_set(shd_haven_final);
		shader_set_uniform_f(shader_get_uniform(shd_haven_final, "time"), obj_game.current_frame / 200);
		shader_set_uniform_f(shader_get_uniform(shd_haven_final, "fade_amount"), 1.0);
		}
	
	//Draw according to properties
	draw_sprite_ext
		(
		_layer[BACK.sprite],
		_layer[BACK.frame],
		round(_draw_x + _layer[BACK.x] + (_cam_dist_x * _layer[BACK.parallax_x])),
		round(_draw_y + _layer[BACK.y] + (_cam_dist_y * _layer[BACK.parallax_y])),
		_layer[BACK.scale],
		_layer[BACK.scale],
		0,
		c_white,
		1
		);
	
	shader_reset();
}
/* Copyright 2023 Springroll Games / Yosi */