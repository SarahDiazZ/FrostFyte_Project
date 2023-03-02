///@category Verlet
///@param {id} system			The system to destroy a point from
///@param {id} point			The point to destroy
/*
Destroy the given verlet point from the given system.
Any sticks in the system that are connected to that point will be destroyed.
*/
function verlet_system_point_destroy() {
	assert(instance_exists(argument[0]), "[verlet_system_point_destroy] The given system ", argument[0], " does not exist!");
	with(argument[0])
		{
		var _point = argument[1];
		instance_destroy(_point);
		
		//Remove from the points array
		var _num = array_length(verlet_points);
		for(var i = _num - 1; i >= 0; i--)
			{
			if (verlet_points[@ i] == _point)
				{
				array_delete(verlet_points, i, 1);
				break;
				}
			}
		
		//Check all sticks
		var _num = array_length(verlet_sticks);
		for(var i = _num - 1; i >= 0; i--)
			{
			var _stick = verlet_sticks[@ i];
			if (_stick.point1 == _point ||
				_stick.point2 == _point)
				{
				instance_destroy(verlet_sticks[@ i]);
				array_delete(verlet_sticks, i, 1);
				}
			}
		
		return true;
		}
}

/* Copyright 2023 Springroll Games / Yosi */