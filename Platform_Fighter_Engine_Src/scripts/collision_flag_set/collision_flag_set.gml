///@category Collisions
///@param {id} id				The instance to change a flag for
///@param {int} flag			The flag to change, from the FLAGS enum
///@param {bool} value			Either true or false
/*
Sets the value of a specific collision flag for an instance.
This is only used with the FLAGS enum for collision purposes.
If the specific instances does not have a "collision_flags" variable the game will crash.
*/
function collision_flag_set() {
	var _id = argument[0];
	var _f = argument[1];
	var _b = argument[2];
	with(_id)
		{
		collision_flags = _b ? collision_flags | (1 << _f) : collision_flags & ~(1 << _f);
		}
}
/* Copyright 2023 Springroll Games / Yosi */