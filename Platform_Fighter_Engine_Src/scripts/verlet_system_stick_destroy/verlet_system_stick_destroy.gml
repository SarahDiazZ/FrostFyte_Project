///@category Verlet
///@param {id} system		The system to destroy a stick from
///@param {id} stick		The stick to destroy
/*
Destroy the given verlet stick from the given system.
*/
function verlet_system_stick_destroy() {
	assert(instance_exists(argument[0]), "[verlet_system_stick_destroy] The given system ", argument[0], " does not exist!");
	with(argument[0])
		{
		var _stick = argument[1];
		instance_destroy(_stick);
		
		//Remove from the sticks array
		var _num = array_length(verlet_sticks);
		for(var i = _num - 1; i >= 0; i--)
			{
			if (verlet_sticks[@ i] == _stick)
				{
				array_delete(verlet_sticks, i, 1);
				break;
				}
			}
		}
}
/* Copyright 2023 Springroll Games / Yosi */