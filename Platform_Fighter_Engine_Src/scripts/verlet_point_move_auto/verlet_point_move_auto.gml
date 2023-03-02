///@category Verlet
///@param {real} vx				The x velocity
///@param {real} vy				The y velocity
///@param {real} [bounce]		The bounce multiplier
///@param {int} [steps]			The number of steps to take
/*
Moves the calling verlet point, taking collisions with <obj_block> into account.
If the calling point is a fixed point, it will NOT be moved.
By default, the bounce multiplier is 1.0 and the number of steps is 3.
*/
function verlet_point_move_auto() {
	var _vx = argument[0];
	var _vy = argument[1];
	var _bounce = argument_count > 2 ? argument[2] : 1.0;
	var _steps = argument_count > 3 ? argument[3] : 3;
	if (object_index == obj_verlet_point_fixed) then return;
	var _x_inc = _vx / _steps;
	var _y_inc = _vy / _steps;
	var _collided = false;
	
	//Steps
	repeat(_steps)
		{
		if (_x_inc != 0)
			{
			_collided = true;
			if (!position_meeting(x + _x_inc, y, obj_block))
				{
				_collided = false;
				}
			if (_collided)
				{
				xprev = x + (_vx * _bounce);
				_x_inc = 0;
				}
			else
				{
				x += _x_inc;
				}
			}
		if (_y_inc != 0)
			{
			_collided = true;
			if (!position_meeting(x, y + _y_inc, obj_block))
				{
				_collided = false;
				}
			if (_collided)
				{
				yprev = y + (_vy * _bounce);
				_y_inc = 0;
				}
			else
				{
				y += _y_inc;
				}
			}
		}
}

/* Copyright 2023 Springroll Games / Yosi */