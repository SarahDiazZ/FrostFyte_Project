function stage_campground_distant_draw() {
	var _layer = argument[0];
	var _draw_x = argument[1];
	var _draw_y = argument[2];
	var _cam_dist_x = argument[3];
	var _cam_dist_y = argument[4];

	var _time = obj_game.daynight_time;
	
	//Choose the sprites to use
	var _sprites;
	if (_layer[@ BACK.sprite] == back_campground_day2)
		{
		_sprites = [back_campground_day2, back_campground_dusk2, back_campground_night2];
		}
	else
		{
		_sprites = [back_campground_day, back_campground_dusk, back_campground_night];
		}

	//Day
	if (_time < 30)
		{
		draw_sprite_ext
			(
			_sprites[@ 0],
			_layer[@ BACK.frame],
			_draw_x + _layer[@ BACK.x] + (_cam_dist_x * _layer[@ BACK.parallax_x]),
			_draw_y + _layer[@ BACK.y] + (_cam_dist_y * _layer[@ BACK.parallax_y]),
			_layer[@ BACK.scale],
			_layer[@ BACK.scale],
			0,
			c_white,
			1,
			);
		}
	//Dusk
	else if (_time < 50)
		{
		var _amt = (_time - 30) / 20;
		draw_sprite_ext
			(
			_sprites[@ 0],
			_layer[@ BACK.frame],
			_draw_x + _layer[@ BACK.x] + (_cam_dist_x * _layer[@ BACK.parallax_x]),
			_draw_y + _layer[@ BACK.y] + (_cam_dist_y * _layer[@ BACK.parallax_y]),
			_layer[@ BACK.scale],
			_layer[@ BACK.scale],
			0,
			c_white,
			1,
			);
		draw_sprite_ext
			(
			_sprites[@ 1],
			_layer[@ BACK.frame],
			_draw_x + _layer[@ BACK.x] + (_cam_dist_x * _layer[@ BACK.parallax_x]),
			_draw_y + _layer[@ BACK.y] + (_cam_dist_y * _layer[@ BACK.parallax_y]),
			_layer[@ BACK.scale],
			_layer[@ BACK.scale],
			0,
			c_white,
			lerp(0, 1, _amt),
			);
		}
	//Night
	else if (_time < 80)
		{
		var _amt = (_time - 50) / 30;
		draw_sprite_ext
			(
			_sprites[@ 1],
			_layer[@ BACK.frame],
			_draw_x + _layer[@ BACK.x] + (_cam_dist_x * _layer[@ BACK.parallax_x]),
			_draw_y + _layer[@ BACK.y] + (_cam_dist_y * _layer[@ BACK.parallax_y]),
			_layer[@ BACK.scale],
			_layer[@ BACK.scale],
			0,
			c_white,
			1,
			);
		draw_sprite_ext
			(
			_sprites[@ 2],
			_layer[@ BACK.frame],
			_draw_x + _layer[@ BACK.x] + (_cam_dist_x * _layer[@ BACK.parallax_x]),
			_draw_y + _layer[@ BACK.y] + (_cam_dist_y * _layer[@ BACK.parallax_y]),
			_layer[@ BACK.scale],
			_layer[@ BACK.scale],
			0,
			c_white,
			lerp(0, 1, _amt),
			);
		}
	//Dawn
	else if (_time < 100)
		{
		var _amt = (_time - 80) / 20;
		draw_sprite_ext
			(
			_sprites[@ 2],
			_layer[@ BACK.frame],
			_draw_x + _layer[@ BACK.x] + (_cam_dist_x * _layer[@ BACK.parallax_x]),
			_draw_y + _layer[@ BACK.y] + (_cam_dist_y * _layer[@ BACK.parallax_y]),
			_layer[@ BACK.scale],
			_layer[@ BACK.scale],
			0,
			c_white,
			1,
			);
		draw_sprite_ext
			(
			_sprites[@ 0],
			_layer[@ BACK.frame],
			_draw_x + _layer[@ BACK.x] + (_cam_dist_x * _layer[@ BACK.parallax_x]),
			_draw_y + _layer[@ BACK.y] + (_cam_dist_y * _layer[@ BACK.parallax_y]),
			_layer[@ BACK.scale],
			_layer[@ BACK.scale],
			0,
			c_white,
			lerp(0, 1, _amt),
			);
		}
}
/* Copyright 2023 Springroll Games / Yosi */