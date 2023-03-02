///@description Draw script / auto draw
if (verlet_draw_script != -1 && script_exists(verlet_draw_script))
	{
	script_execute(verlet_draw_script);
	}
//Automatic draw
else
	{
	draw_set_color(c_white);
	draw_set_alpha(1);
	
	//Draw sticks
	var _num = array_length(verlet_sticks);
	for(var i = 0; i < _num; i++)
		{
		var _stick = verlet_sticks[@ i];
		draw_line_width
			(
			_stick.point1.x, _stick.point1.y,
			_stick.point2.x, _stick.point2.y, 
			3,
			);
		}
		
	//Draw points
	var _num = array_length(verlet_points);
	for(var i = 0; i < _num; i++)
		{
		var _point = verlet_points[@ i];
		draw_sprite(spr_verlet_point, 0, _point.x, _point.y);
		}
	}
	
/* Copyright 2023 Springroll Games / Yosi */