///@category Verlet
///@param {asset} [move_script]				The script used to move points
///@param {asset} [draw_script]				The script used to draw the system
///@param {real} [gravity]					The gravity for all points
///@param {real} [gravity_direction]		The gravity direction. The default is 270
///@param {real} [air_resistance]			The air resistance for all points
///@param {real} [bounce_multiplier]		The bounce multiplier for all points
///@param {int} [stick_iterations]			The number of times stick contraints are calculated every update. More iterations will make shapes less bouncy
///@param {int} [strength_multiplier]		The strength multiplier for non-rigid sticks
/*
Creates a new instances of <obj_verlet_system>, initializes it with the given values, and returns the id.
*/
function verlet_system_create() {
	var _inst = instance_create_layer(x, y, layer, obj_verlet_system);
	with(_inst)
		{
		var i = 0;
		if (argument_count > i) then verlet_move_script = argument[i]; i++;
		if (argument_count > i) then verlet_draw_script = argument[i]; i++;
		if (argument_count > i) then verlet_grav = argument[i]; i++;
		if (argument_count > i) then verlet_grav_dir = argument[i]; i++;
		if (argument_count > i) then verlet_air_resist = argument[i]; i++;
		if (argument_count > i) then verlet_bounce_multiplier = argument[i]; i++;
		if (argument_count > i) then verlet_sticks_iterations = argument[i]; i++;
		if (argument_count > i) then verlet_sticks_strength_multiplier = argument[i]; i++;
		
		verlet_system_gravity_change(id, verlet_grav, verlet_grav_dir);
		}
	return _inst;
}

/* Copyright 2023 Springroll Games / Yosi */