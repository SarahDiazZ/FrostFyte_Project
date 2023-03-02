///@category Verlet
///@param {id} system				The id of the system
///@param {int} group				The group number
/*
Destroy all points and sticks in the system that have the given group number.
*/
function verlet_system_group_destroy() {
	assert(instance_exists(argument[0]), "[verlet_system_group_destroy] The given system ", argument[0], " does not exist!");
	with(argument[0])
		{
		var _group = argument[1];
		
		//Points
		var _num = array_length(verlet_points);
		for(var i = _num - 1; i >= 0; i--)
			{
			if (verlet_points[@ i].group == _group)
				{
				verlet_system_point_destroy(id, verlet_points[@ i]);
				}
			}
		
		//Sticks
		var _num = array_length(verlet_sticks);
		for(var i = _num - 1; i >= 0; i--)
			{
			if (verlet_sticks[@ i].group == _group)
				{
				verlet_system_stick_destroy(id, verlet_sticks[@ i]);
				}
			}
		}
}

/* Copyright 2023 Springroll Games / Yosi */