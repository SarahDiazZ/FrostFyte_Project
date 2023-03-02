///@category Collisions
///@param {id} id				The instance to check
///@param {int} flag			The flag to check for, from the FLAGS enum
/*
Returns true if the specific instance has a "collision_flags" variable with a certain flag in it.
This is only used with the FLAGS enum for collision purposes.
If the specific instances does not have a "collision_flags" variable the game will crash.
*/
function collision_flag_exists() {
	return argument[0].collision_flags & (1 << argument[1]);
}
/* Copyright 2023 Springroll Games / Yosi */