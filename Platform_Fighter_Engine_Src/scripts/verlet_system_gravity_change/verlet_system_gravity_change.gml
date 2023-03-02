///@category Verlet
///@param {id} system			The id of the system to change the gravity of
///@param {real} gravity		The strength of the gravity
///@param {real} direction		The direction of the gravity
/*
Changes the gravity strength and direction of the given system.
*/
function verlet_system_gravity_change() {
	assert(instance_exists(argument[0]), "[verlet_system_gravity_change] The given system ", argument[0], " does not exist!");
	with(argument[0])
		{
		verlet_grav = argument[1];
		verlet_grav_dir = argument[2];
		verlet_grav_x = lengthdir_x(verlet_grav, verlet_grav_dir);
		verlet_grav_y = lengthdir_y(verlet_grav, verlet_grav_dir);
		}
}

/* Copyright 2023 Springroll Games / Yosi */