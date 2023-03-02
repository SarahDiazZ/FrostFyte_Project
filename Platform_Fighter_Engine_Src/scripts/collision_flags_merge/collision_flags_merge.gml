///@category Collisions
///@param {array} flags			The flags to merge into a single number, from the FLAG enum
/*
Merges multiple flags from the FLAG enum into a single number, which can be compared to the "collision_flags" variable of objects that are children of <obj_collidable>.
*/
function collision_flags_merge() {
	var _flags = argument[0];
	//Merge the flags into a number to easily check
	var _f = 0;
	for(var i = 0; i < array_length(_flags); i++)
		{
		_f = _f | (1 << _flags[@ i]);
		}
	return _f;
}
/* Copyright 2023 Springroll Games / Yosi */