///@category Verlet
///@param {id} system					The system to add a point to
///@param {real} x						The x to create the new point at
///@param {real} y						The y to create the new point at
///@param {bool} [fixed]				Whether the point should be fixed or not
///@param {int} [group]					The group for the point
///@param {real} [vx]					The starting x velocity
///@param {real} [vy]					The starting y velocity
/*
Creates a new verlet point, adds it to the given system, and returns the id.
By default, points created are NOT fixed.
*/
function verlet_system_point_add() {
	assert(instance_exists(argument[0]), "[verlet_system_point_add] The given system ", argument[0], " does not exist!");
	with(argument[0])
		{
		var _x = argument[1];
		var _y = argument[2];
		var _fixed = argument_count > 3 ? argument[3] : false;
		var _group = argument_count > 4 ? argument[4] : 0;
		var _vx = argument_count > 5 ? argument[5] : 0;
		var _vy = argument_count > 6 ? argument[6] : 0;
		var _point = instance_create_layer(_x, _y, layer, _fixed ? obj_verlet_point_fixed : obj_verlet_point);
		_point.xprev = _x - _vx;
		_point.yprev = _y - _vy;
		_point.group = _group;
		array_push(verlet_points, _point);
		return _point;
		}
}

/* Copyright 2023 Springroll Games / Yosi */