///@description
if (surface_exists(obj_game.game_surface))
	{
	if (game_surface_enable) surface_set_target(obj_game.game_surface);
	
	//Fade value
	var _f = background_get_clear_amount();
	
	//Laser
	if (custom_entity_struct.phase == 1 && custom_entity_struct.frame > 0)
		{
		var _lx = custom_entity_struct.laser_x;
		var _ly = custom_entity_struct.laser_y;
		if (_lx != x || _ly != y)
			{
			var _c = merge_color(c_black, palette_color_get(palette_data, 1), _f);
			var _s = 30;
			var _dir = point_direction(x, y, _lx, _ly);
			var _times = (point_distance(x, y, _lx, _ly) div _s);
			for(var i = 0; i < _times; i++)
				{
				draw_sprite_ext
					(
					spr_dspec4_gaze_laser, 
					lerp(5, 0, (custom_entity_struct.frame / 10)),
					round(lerp(x, _lx, i / _times)), 
					round(lerp(y, _ly, i / _times)),
					2,
					2, 
					_dir,
					_c,
					1,
					);
				}
			draw_circle_color(x, y, lerp(33, 15, (custom_entity_struct.frame / 10)), _c, _c, false);
			draw_circle_color(_lx, _ly, lerp(33, 15, (custom_entity_struct.frame / 10)), _c, _c, false);
			}
		}
	
	entity_draw_self();
	
	if (game_surface_enable) surface_reset_target();
	}
/* Copyright 2023 Springroll Games / Yosi */