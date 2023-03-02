function stage_lava_back_draw() {
	//return;
	var _layer = argument[0];
	var _draw_x = argument[1];
	var _draw_y = argument[2];
	var _cam_dist_x = argument[3];
	var _cam_dist_y = argument[4];
	
	//Draw it with a shader applied
	var _sprite = _layer[@ BACK.sprite];
	var _tex = sprite_get_texture(_sprite, 0);
	var _surf_tw = texture_get_texel_width(_tex);
	var _surf_th = texture_get_texel_height(_tex);
	with(obj_lava_filter)
		{
		if (!setting().performance_mode && !setting().disable_shaders)
			{
			shader_set(shd_lava);
			texture_set_stage(samp, lava_tex);
			shader_set_uniform_f(uni_t, lava_tw, lava_th);
			shader_set_uniform_f(uni_b, _surf_tw, _surf_th);
			shader_set_uniform_f(uni_i, time);
			shader_set_uniform_f(uni_f, background_get_clear_amount() * 0.8);
			}
	
		draw_sprite_ext
			(
			_sprite,
			_layer[BACK.frame],
			_draw_x + _layer[BACK.x] + (_cam_dist_x * _layer[BACK.parallax_x]),
			_draw_y + _layer[BACK.y] + (_cam_dist_y * _layer[BACK.parallax_y]),
			_layer[BACK.scale],
			_layer[BACK.scale],
			0,
			c_white,
			1
			);
	
		shader_reset();
		}
}
/* Copyright 2023 Springroll Games / Yosi */