///@category Verlet
///@param {id} system				The system to add a stick to
///@param {id} point1				The first point to connect
///@param {id} point2				The second point to connect
///@param {bool} [rigid]			Whether the stick should be rigid or not
///@param {int} [group]				The group for the stick
///@param {real} [length]			The length of the stick
/*
Creates a new verlet stick, adds it to the given system, and returns the id.
By default, sticks created are NOT rigid, and have the length of the distance between the points they connect.
*/
function verlet_system_stick_add() {
	assert(instance_exists(argument[0]), "[verlet_system_stick_add] The given system ", argument[0], " does not exist!");
	with(argument[0])
		{
		var _point1 = argument[1];
		var _point2 = argument[2];
		var _rigid = argument_count > 3 ? argument[3] : false;
		var _group = argument_count > 4 ? argument[4] : 0;
		var _length = argument_count > 5 ? argument[5] : point_distance(_point1.x, _point1.y, _point2.x, _point2.y);
		var _stick = instance_create_layer(_point1.x, _point1.y, layer, _rigid ? obj_verlet_stick_rigid : obj_verlet_stick);
		_stick.point1 = _point1;
		_stick.point2 = _point2;
		_stick.length = _length;
		_stick.group = _group;
		array_push(verlet_sticks, _stick);
		return _stick;
		}
}

/* Copyright 2023 Springroll Games / Yosi */