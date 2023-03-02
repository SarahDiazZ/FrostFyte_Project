///@category Verlet
///@param {real} vx				The x velocity
///@param {real} vy				The y velocity
///@param {real} bounce			The bounce multiplier
/*
The custom verlet point move script for PFE.
It makes use of the <collision> function.
*/
function verlet_custom_point_move() {
	var _vx = argument[0];
	var _vy = argument[1];
	var _bounce = argument_count > 2 ? argument[2] : 1.0;
	var _steps = 3;
	if (object_index == obj_verlet_point_fixed) then return;
	var _x_inc = _vx / _steps;
	var _y_inc = _vy / _steps;
	
	//Steps
	repeat(_steps)
		{
		if (_x_inc != 0)
			{
			if (!collision(x + _x_inc, y, [FLAG.solid]))
				{
				x += _x_inc;
				}
			else
				{
				xprev = x + (_vx * _bounce);
				_x_inc = 0;
				}
			}
		if (_y_inc != 0)
			{
			if (!collision(x, y + _y_inc, [FLAG.solid]))
				{
				y += _y_inc;
				}
			else
				{
				yprev = y + (_vy * _bounce);
				_y_inc = 0;
				}
			}
		}
}

/* Copyright 2023 Springroll Games / Yosi */