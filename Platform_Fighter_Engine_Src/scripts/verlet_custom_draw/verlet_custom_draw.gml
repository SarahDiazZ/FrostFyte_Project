///@category Verlet
/*
The custom verlet system draw script for PFE.
It only draws sticks in the system, with a width of 2 pixels.
*/
function verlet_custom_draw() {
	fade_shader_set();
	
	if (surface_exists(obj_game.game_surface))
		{
		if (game_surface_enable) surface_set_target(obj_game.game_surface);
		}
		
	draw_set_color(c_white);
	draw_set_alpha(1);
	
	//Draw sticks
	var _num = array_length(verlet_sticks);
	for(var i = 0; i < _num; i++)
		{
		var _stick = verlet_sticks[@ i];
		var _color = _stick.image_blend;
		draw_line_sprite(_stick.point1.x, _stick.point1.y, _stick.point2.x, _stick.point2.y, 6, c_black);
		draw_line_sprite(_stick.point1.x, _stick.point1.y, _stick.point2.x, _stick.point2.y, 2, _color);
		}	
	
	shader_reset();

	if (surface_exists(obj_game.game_surface))
		{
		if (game_surface_enable) surface_reset_target();
		}
}

/* Copyright 2023 Springroll Games / Yosi */