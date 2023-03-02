///@category Verlet
///@param {id} system		The id of the system to destroy
/*
Destroys the given verlet system, and all points / sticks associated with it.
*/
function verlet_system_destroy() {
	with(argument[0])
		{
		instance_destroy();
		return true;
		}
	return false;
}

/* Copyright 2023 Springroll Games / Yosi */