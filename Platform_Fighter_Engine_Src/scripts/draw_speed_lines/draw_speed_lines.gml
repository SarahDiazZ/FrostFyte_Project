///@param {real} x					The x position the action lines are centered around
///@param {real} y					The y position the action lines are centered around
///@param {real} dir				The direction of the lines
///@param {color} [color]			The color of the lines
///@param {real} [alpha]			The transparency of the lines
///@param {real} [time]				The time value to use for the position of the lines
/*
Draws lines tilted in a specific direction across the screen.
*/
function draw_speed_lines() {
	var _x = argument[0];
	var _y = argument[1];
	var _dir = argument[2];
	var _c = argument_count > 3 ? argument[3] : c_white;
	var _a = argument_count > 4 ? argument[4] : 1;
	var _t = argument_count > 5 ? argument[5] : 0;
	var _space = 200;
	
	for(var i = 0; i < 2; i++)
		{
		for(var m = 0; m < 3; m++)
			{
			var _newdir = (i == 0 ? _dir + 90 : _dir - 90);
			var _move_dist = -1920 + (960 * m) + modulo(_t * 50, 960);
			var _off_x = _x + lengthdir_x(_space, _newdir) + lengthdir_x(_move_dist, _dir);
			var _off_y = _y + lengthdir_y(_space, _newdir) + lengthdir_y(_move_dist, _dir);
			draw_sprite_ext(spr_speed_lines, 0, _off_x, _off_y, 1, (i == 0 ? 1 : -1), _dir, _c, _a);
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */