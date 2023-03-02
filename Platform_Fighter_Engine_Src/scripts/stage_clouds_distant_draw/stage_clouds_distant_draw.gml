function stage_clouds_distant_draw() {
	var _layer = argument[0];
	var _draw_x = argument[1];
	var _draw_y = argument[2];
	var _cam_dist_x = argument[3];
	var _cam_dist_y = argument[4];
	
	draw_sprite_ext
		(
		back_clouds_distant,
		0,
		_draw_x + _layer[@ BACK.x] + (_cam_dist_x * _layer[@ BACK.parallax_x]),
		_draw_y + _layer[@ BACK.y] + (_cam_dist_y * _layer[@ BACK.parallax_y]),
		_layer[@ BACK.scale],
		_layer[@ BACK.scale],
		0,
		c_white,
		1,
		);
		
	var _alpha = min(abs(stage_tint[@ 0]), 0.5);
	draw_sprite_ext
		(
		back_clouds_distant,
		1,
		_draw_x + _layer[@ BACK.x] + (_cam_dist_x * _layer[@ BACK.parallax_x]),
		_draw_y + _layer[@ BACK.y] + (_cam_dist_y * _layer[@ BACK.parallax_y]),
		_layer[@ BACK.scale],
		_layer[@ BACK.scale],
		0,
		c_white,
		_alpha,
		);
}
/* Copyright 2023 Springroll Games / Yosi */